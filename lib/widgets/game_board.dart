import 'package:flutter/material.dart';
import 'package:tictactoe/models/game.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    super.key,
    required this.board,
    required this.onCellTapped,
    this.enabled = true,
  });

  final List<List<CellState>> board;
  final Function(int row, int col) onCellTapped;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: List.generate(board.length, (row) {
            return Expanded(
              child: Row(
                children: List.generate(board.length, (col) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: _GameCell(
                        state: board[row][col],
                        onTap: enabled ? () => onCellTapped(row, col) : null,
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _GameCell extends StatelessWidget {
  const _GameCell({required this.state, required this.onTap});

  final CellState state;
  final VoidCallback? onTap;

  Color _getCellColor() {
    switch (state) {
      case CellState.x:
        return Colors.blue.shade100;
      case CellState.o:
        return Colors.red.shade100;
      case CellState.empty:
        return Colors.white;
    }
  }

  Color _getTextColor() {
    switch (state) {
      case CellState.x:
        return Colors.blue.shade700;
      case CellState.o:
        return Colors.red.shade700;
      case CellState.empty:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _getCellColor(),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Center(
            child: Text(
              state.displayValue,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: _getTextColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
