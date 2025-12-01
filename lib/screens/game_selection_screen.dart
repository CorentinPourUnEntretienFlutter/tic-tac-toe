import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/theme/app_theme.dart';
import 'package:tictactoe/widgets/app_scaffold.dart';
import 'package:tictactoe/widgets/liquid_glass_card.dart';
import 'package:uuid/uuid.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/providers/game_providers.dart';
import 'package:tictactoe/providers/realtime_database_providers.dart';

class GameSelectionScreen extends ConsumerStatefulWidget {
  const GameSelectionScreen({super.key, required this.playerName});

  final String playerName;

  @override
  ConsumerState<GameSelectionScreen> createState() =>
      _GameSelectionScreenState();
}

class _GameSelectionScreenState extends ConsumerState<GameSelectionScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _gameIdController.dispose();
    super.dispose();
  }

  Future<void> _createGame() async {
    setState(() => _isLoading = true);

    try {
      const uuid = Uuid();
      final gameId = uuid.v4();

      final game = Game.newOnlineGame(
        id: gameId,
        player1Name: widget.playerName,
        boardSize: 3,
      );

      final gameService = ref.read(gameServiceProvider);
      await gameService.createGame(game);

      if (mounted) {
        context.push(
          '/online-pseudo/game-selection/$gameId?playerName=${Uri.encodeComponent(widget.playerName)}',
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating game: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _joinGame() async {
    final gameId = _gameIdController.text.trim();

    if (gameId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a game ID'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final gameService = ref.read(gameServiceProvider);
      final game = await gameService.getGame(gameId: gameId);

      if (game == null) {
        throw Exception('Game not found');
      }

      if (!game.canJoin) {
        throw Exception('Game is full or already started');
      }

      // Join the game
      final updatedGame = game.joinAsPlayer2(widget.playerName);
      await gameService.updateGame(updatedGame);

      if (mounted) {
        context.push(
          '/online-pseudo/game-selection/$gameId?playerName=${Uri.encodeComponent(widget.playerName)}',
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error joining game: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.appTheme.color;
    final connectionStatus = ref.watch(databaseConnectionStatusProvider);

    return AppScaffold(
      appBar: AppBar(
        backgroundColor: colorTheme.mainBackground.withValues(alpha: 0.5),

        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Welcome, '),
              TextSpan(
                text: widget.playerName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '!'),
            ],
          ),
        ),
        actions: [
          // Connection status indicator
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 10.0),
            child: connectionStatus.when(
              data: (isConnected) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isConnected ? Icons.cloud_done : Icons.cloud_off,
                    color: isConnected
                        ? Colors.green
                        : Colors.red, // todo: use color theme
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isConnected ? 'Connected' : 'Offline',
                    style: TextStyle(
                      fontSize: 14,
                      color: isConnected
                          ? Colors.green
                          : Colors.red, // todo: use color theme
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              loading: () => const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('Checking...', style: TextStyle(fontSize: 14)),
                ],
              ),
              error: (_, _) => const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Error',
                    style: TextStyle(fontSize: 14, color: Colors.orange),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Connection status banner (only show when disconnected)
                  connectionStatus.when(
                    data: (isConnected) => !isConnected
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              border: Border.all(color: Colors.red.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.red.shade700,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'No database connection. Please check your internet connection.',
                                    style: TextStyle(
                                      color: Colors.red.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                  ),

                  const SizedBox(height: 24),

                  // Create game section
                  LiquidGlassCard(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 64,
                            color: colorTheme.secondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Create New Game',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorTheme.onPrimary2,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start a new game and share the ID with a friend',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colorTheme.onPrimary2),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _createGame,
                            icon: const Icon(Icons.add),
                            label: const Text('Create Game'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              backgroundColor: colorTheme.secondary,
                              foregroundColor: colorTheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Divider with "OR"
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Join game section
                  LiquidGlassCard(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.login,
                            size: 64,
                            color: colorTheme.onPrimary2,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Join Existing Game',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorTheme.onPrimary2,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enter the game ID shared by your friend',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colorTheme.onPrimary2),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          TextField(
                            controller: _gameIdController,
                            decoration: InputDecoration(
                              labelText: 'Game ID',
                              hintText: 'Enter game ID',
                              hintStyle: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: colorTheme.onPrimary2),
                              prefixIcon: Icon(
                                Icons.tag,
                                color: colorTheme.onPrimary2,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorTheme.onPrimary2,
                                ),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _joinGame(),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _joinGame,
                            icon: const Icon(Icons.login),
                            label: const Text('Join Game'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              backgroundColor: colorTheme.mainBackground,
                              foregroundColor: colorTheme.onMainBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
