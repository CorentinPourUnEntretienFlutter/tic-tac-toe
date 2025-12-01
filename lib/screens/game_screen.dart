import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/providers/game_providers.dart';
import 'package:tictactoe/services/game_service.dart';
import 'package:tictactoe/widgets/game_board.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key, required this.gameId, required this.playerName});

  final String gameId;
  final String playerName;

  void _copyGameId(BuildContext context) {
    Clipboard.setData(ClipboardData(text: gameId));
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
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStream = ref.watch(gameStreamProvider(gameId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.content_copy),
            onPressed: () => _copyGameId(context),
            tooltip: 'Copy Game ID',
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
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

          return _GameContent(
            game: game,
            playerName: playerName,
            gameId: gameId,
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

class _GameContent extends StatelessWidget {
  const _GameContent({
    required this.game,
    required this.playerName,
    required this.gameId,
  });

  final Game game;
  final String playerName;
  final String gameId;

  void _copyGameId(BuildContext context) {
    Clipboard.setData(ClipboardData(text: gameId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Game ID copied to clipboard!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  String _getStatusMessage() {
    if (game.status == GameStatus.waiting) {
      return 'Waiting for opponent...';
    }

    if (game.status == GameStatus.finished) {
      if (game.isDraw) {
        return "It's a draw!";
      }
      if (game.winner == playerName) {
        return 'You won! 🎉';
      }
      return '${game.winner} won!';
    }

    if (game.currentPlayer == playerName) {
      return 'Your turn (${game.getPlayerSymbol(playerName).displayValue})';
    }

    return '${game.currentPlayer}\'s turn (${game.currentPlayerCellState.displayValue})';
  }

  Color _getStatusColor() {
    if (game.status == GameStatus.waiting) {
      return Colors.orange;
    }

    if (game.status == GameStatus.finished) {
      if (game.isDraw) {
        return Colors.grey;
      }
      return game.winner == playerName ? Colors.green : Colors.red;
    }

    return game.currentPlayer == playerName ? Colors.green : Colors.blue;
  }

  Future<void> _onCellTapped(BuildContext context, int row, int col) async {
    if (game.status != GameStatus.playing) {
      return;
    }

    if (game.currentPlayer != playerName) {
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
      final gameService = GameService();
      await gameService.makeMove(
        gameId: gameId,
        row: row,
        col: col,
        playerName: playerName,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error making move: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _restartGame(BuildContext context) async {
    try {
      final gameService = GameService();
      await gameService.restartGame(gameId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Game restarted!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Player info
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _PlayerInfo(
                        name: game.player1Name,
                        symbol: 'X',
                        isActive: game.currentPlayer == game.player1Name,
                        isYou: game.player1Name == playerName,
                      ),
                      const Text(
                        'VS',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _PlayerInfo(
                        name: game.player2Name ?? 'Waiting...',
                        symbol: 'O',
                        isActive: game.currentPlayer == game.player2Name,
                        isYou: game.player2Name == playerName,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Status message
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getStatusColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _getStatusColor(), width: 2),
            ),
            child: Column(
              children: [
                Text(
                  _getStatusMessage(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(),
                  ),
                  textAlign: TextAlign.center,
                ),
                if (game.status == GameStatus.waiting) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          gameId,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 14,
                            color: _getStatusColor(),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        iconSize: 20,
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                        onPressed: () => _copyGameId(context),
                        tooltip: 'Copy Game ID',
                        color: _getStatusColor(),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Game board
          GameBoard(
            board: game.board,
            onCellTapped: (row, col) => _onCellTapped(context, row, col),
            enabled:
                game.status == GameStatus.playing &&
                game.currentPlayer == playerName,
          ),

          const SizedBox(height: 24),

          // Restart button for finished games
          if (game.status == GameStatus.finished)
            Card(
              elevation: 2,
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.refresh, color: Colors.green, size: 32),
                    const SizedBox(height: 12),
                    const Text(
                      'Want to play again?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => _restartGame(context),
                      icon: const Icon(Icons.replay, size: 20),
                      label: const Text('Restart Game'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Game info
          if (game.status == GameStatus.waiting)
            Card(
              elevation: 2,
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.share, color: Colors.blue, size: 32),
                    const SizedBox(height: 12),
                    const Text(
                      'Share the Game ID with a friend to start playing!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: SelectableText(
                              gameId,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => _copyGameId(context),
                      icon: const Icon(Icons.content_copy, size: 18),
                      label: const Text('Copy Game ID'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PlayerInfo extends StatelessWidget {
  const _PlayerInfo({
    required this.name,
    required this.symbol,
    required this.isActive,
    required this.isYou,
  });

  final String name;
  final String symbol;
  final bool isActive;
  final bool isYou;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActive ? Colors.green.shade100 : Colors.grey.shade100,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? Colors.green : Colors.grey,
              width: 3,
            ),
          ),
          child: Text(
            symbol,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.green : Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isYou)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'YOU',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
