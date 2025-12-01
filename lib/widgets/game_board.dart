import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/providers/settings_providers.dart';
import 'package:tictactoe/widgets/game_cell.dart';

class GameBoard extends ConsumerWidget {
  const GameBoard({
    super.key,
    required this.board,
    required this.onCellTapped,
    required this.canMakeMove,
  });

  final List<List<CellState>> board;
  final Function(int row, int col) onCellTapped;
  final Function(int row, int col) canMakeMove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: LiquidGlassLayer(
          settings: ref.watch(settingsNotifier),
          // 3. Add your LiquidGlass widgets here
          child: LiquidGlassBlendGroup(
            child: Column(
              children: List.generate(board.length, (row) {
                return Expanded(
                  child: Row(
                    children: List.generate(board.length, (col) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: GameCell(
                            state: board[row][col],
                            onTap: canMakeMove(row, col)
                                ? () => onCellTapped(row, col)
                                : null,
                            // onTap: () => print('🎮 onTap: $row, $col, $enabled'),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
