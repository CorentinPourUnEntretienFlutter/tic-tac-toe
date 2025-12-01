import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/providers/game_providers.dart';
import 'package:tictactoe/theme/app_theme.dart';
import 'package:tictactoe/widgets/app_scaffold.dart';
import 'package:tictactoe/widgets/game_background.dart';
import 'package:tictactoe/widgets/game_foreground.dart';

class OnlineGameScreen extends ConsumerStatefulWidget {
  const OnlineGameScreen({
    super.key,
    required this.gameId,
    required this.playerName,
  });
  final String gameId;
  final String playerName;

  @override
  ConsumerState<OnlineGameScreen> createState() => _OnlineGameScreenState();
}

class _OnlineGameScreenState extends ConsumerState<OnlineGameScreen> {
  void _copyGameId(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.gameId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Game ID copied to clipboard!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _leaveGame(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Game'),
        content: const Text('Are you sure you want to leave this game?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Leave'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.pop();
    }
  }

  Future<void> _onCellTapped(int row, int col, Game game) async {
    if (game.status != GameStatus.playing) {
      return;
    }

    if (game.currentPlayer != widget.playerName) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not your turn!'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    if (game.board[row][col] != CellState.empty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cell already occupied!'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    try {
      final gameService = ref.read(gameServiceProvider);
      await gameService.makeMove(
        gameId: widget.gameId,
        row: row,
        col: col,
        playerName: widget.playerName,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error making move: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _restartGame(Game game) async {
    try {
      final gameService = ref.read(gameServiceProvider);
      await gameService.restartGame(gameId: widget.gameId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Game restarted!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error restarting game: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final gameStream = ref.watch(gameStreamProvider(gameId: widget.gameId));

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        automaticallyImplyLeading: false,
        backgroundColor: theme.color.mainBackground.withValues(alpha: 0.5),
        actions: [
          IconButton(
            icon: const Icon(Icons.content_copy),
            onPressed: () => _copyGameId(context),
            tooltip: 'Copy Game ID',
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined),
            onPressed: () => _leaveGame(context, ref),
            tooltip: 'Leave Game',
          ),
        ],
      ),
      body: gameStream.when(
        data: (game) {
          if (game == null) {
            return const Center(
              child: Text('Game not found', style: TextStyle(fontSize: 18)),
            );
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: AnimatedGameBackground(
                  text: game.currentPlayer ?? '',
                  textColor: theme.color.playerBackgroundText,
                ),
              ),
              GameForeground(
                game: game,
                currentPlayer: widget.playerName,
                onCellTapped: (row, col) => _onCellTapped(row, col, game),
                onRestartGame: () => _restartGame(game),
                enabled:
                    game.status == GameStatus.playing &&
                    game.currentPlayer == widget.playerName,
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Error loading game',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension GameStatusExtension on GameStatus {
  Color get color {
    switch (this) {
      case GameStatus.waiting:
        return Colors.orange;
      case GameStatus.playing:
        return Colors.blue;
      case GameStatus.finished:
        return Colors.grey;
    }
  }
}
