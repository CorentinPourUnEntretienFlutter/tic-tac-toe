// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/providers/game_providers.dart';
import 'package:tictactoe/theme/app_theme.dart';
import 'package:tictactoe/theme/theme_switcher.dart';
import 'package:tictactoe/widgets/app_scaffold.dart';
import 'package:tictactoe/widgets/game_background.dart';
import 'package:tictactoe/widgets/game_foreground.dart';
import 'package:tictactoe/widgets/glass_icon.dart';
import 'package:tictactoe/widgets/settings.dart';

class LocalGameScreen extends ConsumerWidget {
  const LocalGameScreen({super.key});

  Future<void> _onCellTapped(int row, int col, Game game, WidgetRef ref) async {
    if (game.status != GameStatus.playing) {
      return;
    }

    final currentPlayer = game.currentPlayer;

    if (currentPlayer == null) {
      return;
    }

    ref
        .read(gameServiceProvider)
        .makeMove(
          gameId: game.id,
          row: row,
          col: col,
          playerName: currentPlayer,
        );
  }

  Future<void> _restartGame(
    BuildContext context,
    WidgetRef ref,
    Game game,
  ) async {
    try {
      final gameService = ref.read(gameServiceProvider);
      await gameService.restartGame(gameId: game.id);
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
  Widget build(BuildContext context, WidgetRef ref) {
    // Local games use empty string as gameId since GameServiceLocal ignores it
    final gameStream = ref.watch(gameStreamProvider(gameId: ''));
    final theme = context.appTheme.color;

    return AppScaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        backgroundColor: theme.mainBackground.withValues(alpha: 0.5),
        actions: [
          ThemeSwitcher(),
          GlassIcon(
            icon: Icons.settings,
            onTap: () => SettingsSheet().show(context),
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
                  textColor: theme.playerBackgroundText,
                  curve: Curves.easeInOut,
                ),
              ),
              GameForeground(
                game: game,
                currentPlayer: game.currentPlayer ?? '',
                onCellTapped: (row, col) => _onCellTapped(row, col, game, ref),
                onRestartGame: () => _restartGame(context, ref, game),
                enabled: true,
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
      ],
    );
  }
}
