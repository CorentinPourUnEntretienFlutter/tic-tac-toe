import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/providers/game_providers.dart';
import 'package:tictactoe/theme/app_theme.dart';
import 'package:tictactoe/widgets/game_board.dart';
import 'package:motor/motor.dart';
import 'package:tictactoe/widgets/game_info.dart';

/// Content displayed on top of the moving game background
/// It contains the game board, the game info, and the restart button for finished games
class GameForeground extends ConsumerWidget {
  const GameForeground({
    super.key,
    required this.game,
    required this.currentPlayer,
    required this.onCellTapped,
    required this.onRestartGame,
    this.enabled = true,
    this.status,
  });

  final Game game;
  final String currentPlayer;
  final void Function(int, int) onCellTapped;
  final VoidCallback onRestartGame;
  final Widget? status;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = context.appTheme.color;

    ref.listen(gameStreamProvider(gameId: game.id), (previous, next) {
      if ((previous?.value?.status, next.value?.status)
          case (GameStatus? previousStatus, GameStatus nextStatus?)
          when previousStatus != nextStatus &&
              nextStatus == GameStatus.finished) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: MotorLogo("Finished!"),
            content: const Text(
              'The game has finished. You can restart the game.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onRestartGame();
                },
                child: const Text('Restart Game'),
              ),
            ],
          ),
        );
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Player info
          GameInfo(game: game, currentPlayer: currentPlayer),
          const SizedBox(height: 16),
          if (status case Widget status?) ...[
            status,
            const SizedBox(height: 24),
          ],

          // Game board
          GameBoard(
            board: game.board,
            onCellTapped: onCellTapped,
            canMakeMove: (row, col) =>
                game.canMakeMove(row, col, currentPlayer),
          ),

          const SizedBox(height: 24),

          // Restart button for finished games
          if (game.status == GameStatus.finished)
            Card(
              elevation: 2,
              color: colorTheme.mainBackground.withValues(alpha: 0.9),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(Icons.replay, color: colorTheme.onSecondary, size: 32),
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
                      onPressed: onRestartGame,
                      icon: const Icon(Icons.replay, size: 20),
                      label: const Text('Restart Game'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorTheme.secondary,
                        foregroundColor: colorTheme.onSecondary,
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
                              game.id,
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
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MotorLogo extends StatelessWidget {
  const MotorLogo(this.value, {super.key, this.visible = true});

  final String value;

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return SingleMotionBuilder(
      motion: CupertinoMotion.smooth(),
      value: visible ? 1 : 0,
      builder: (context, opacity, _) => Visibility(
        visible: opacity >= 0.01,
        child: Opacity(
          opacity: opacity.clamp(0, 1),
          child: RichText(
            key: ValueKey(true),
            text: TextSpan(
              children: [
                for (final (index, char) in value.runes.indexed)
                  WidgetSpan(
                    child: _Letter(
                      index: index,
                      letter: String.fromCharCode(char),
                      visible: visible,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Letter extends StatefulWidget {
  const _Letter({
    required this.letter,
    required this.index,
    required this.visible,
  });

  final String letter;

  final int index;

  final bool visible;

  @override
  State<_Letter> createState() => _LetterState();
}

class _LetterState extends State<_Letter> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final additionalDuration = Duration(milliseconds: widget.index * 200);
    final motion = CupertinoMotion.bouncy(
      extraBounce: .3,
      duration: Durations.extralong4,
    );

    final initialStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: 64,
      fontVariations: [FontVariation.weight(100), FontVariation.width(50)],
    );
    return MouseRegion(
      onEnter: (event) => setState(() => _hovered = true),
      onExit: (event) => setState(() => _hovered = false),
      child: MotionBuilder(
        motion: motion.copyWith(duration: motion.duration + additionalDuration),
        from: initialStyle ?? const TextStyle(),
        value: widget.visible
            ? (initialStyle ?? const TextStyle()).copyWith(
                fontSize: widget.visible ? 64 : 0,
                fontVariations: [
                  FontVariation.weight(_hovered ? 900 : 700),
                  FontVariation.width(110),
                ],
              )
            : (initialStyle ?? const TextStyle()),
        converter: FontMotionConverter(),
        builder: (context, value, child) {
          return SingleMotionBuilder(
            motion: motion,
            from: -50,
            value: widget.visible ? 0 : -50,
            builder: (context, xOffset, child) =>
                Transform.translate(offset: Offset(xOffset, 0), child: child),
            child: Text(
              textHeightBehavior: TextHeightBehavior(),
              widget.letter,
              style: value,
            ),
          );
        },
      ),
    );
  }
}

class FontMotionConverter implements MotionConverter<TextStyle> {
  late TextStyle latestValue;

  @override
  List<double> normalize(TextStyle value) {
    latestValue = value;
    return [
      value.fontSize!,
      value.fontVariations!.firstWhere((v) => v.axis == 'wght').value,
      value.fontVariations!.firstWhere((v) => v.axis == 'wdth').value,
    ];
  }

  @override
  TextStyle denormalize(List<double> values) {
    return latestValue.copyWith(
      fontSize: values[0],
      fontVariations: [
        FontVariation.weight(values[1].clamp(1, 900)),
        FontVariation.width(values[2].clamp(1, 900)),
      ],
    );
  }
}
