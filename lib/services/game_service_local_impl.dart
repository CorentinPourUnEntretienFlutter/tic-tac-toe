import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/services/game_service.dart';

/// Implementation of GameService using local in-memory state management
class GameServiceLocal extends GameService {
  Game? _game = Game.newOfflineGame(boardSize: 3);

  final StreamController<Game?> _gameController =
      StreamController<Game?>.broadcast();

  void _updateGame(Game? game) {
    _game = game;
    _gameController.add(_game);
  }

  @override
  Future<void> createGame(Game game) async {
    _game = game;
  }

  @override
  Future<Game?> getGame({required String gameId}) async {
    return _game;
  }

  @override
  Future<void> updateGame(Game game) async {
    _updateGame(game);
  }

  @override
  Future<void> deleteGame({required String gameId}) async {
    _updateGame(null);
  }

  @override
  Stream<Game?> watchGame({required String gameId}) async* {
    yield _game;
    yield* _gameController.stream;
  }

  @override
  Future<void> makeMove({
    required String gameId,
    required int row,
    required int col,
    required String playerName,
  }) async {
    debugPrint('🎮 Making move at ($row, $col) by $playerName');
    try {
      final game = _game;
      if (game == null) {
        throw Exception('Game not found');
      }

      final updatedGame = game.makeMove(row, col, playerName);
      _updateGame(updatedGame);
    } catch (e) {
      debugPrint('🎮 Error making move: $e');
      rethrow;
    }
  }

  @override
  Future<void> restartGame({required String gameId}) async {
    debugPrint('🎮 Restarting game locally');
    try {
      final game = _game;
      if (game == null) {
        debugPrint('🎮 Game aleady null');
        return;
      }

      if (game.status != GameStatus.finished) {
        throw Exception('Can only restart finished games');
      }

      final restartedGame = game.restart();
      _updateGame(restartedGame);
      debugPrint('🎮 Game restarted successfully');
    } catch (e) {
      debugPrint('🎮 Error restarting game: $e');
      rethrow;
    }
  }

  /// Clean up resources
  @override
  void dispose() {
    _gameController.close();
  }
}
