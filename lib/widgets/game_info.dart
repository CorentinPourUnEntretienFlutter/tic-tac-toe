import 'package:flutter/material.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/widgets/liquid_glass_card.dart';

class GameInfo extends StatelessWidget {
  const GameInfo({super.key, required this.game, required this.currentPlayer});

  final Game game;
  final String currentPlayer;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassCard(
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
                  isYou: game.player1Name == currentPlayer,
                ),
                const Text(
                  'VS',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                _PlayerInfo(
                  name: game.player2Name ?? 'Waiting...',
                  symbol: 'O',
                  isActive: game.currentPlayer == game.player2Name,
                  isYou: game.player2Name == currentPlayer,
                ),
              ],
            ),
          ],
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
