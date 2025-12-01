// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:tictactoe/models/game.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:tictactoe/theme/app_theme.dart';

class GameCell extends StatelessWidget {
  const GameCell({super.key, required this.state, required this.onTap});

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LiquidStretch(
        child: LiquidGlass.grouped(
          shape: LiquidRoundedSuperellipse(borderRadius: 20),
          child: GlassGlow(
            child: Center(
              child: Text(
                state.displayValue,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: context.appTheme.color.playerSign,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
