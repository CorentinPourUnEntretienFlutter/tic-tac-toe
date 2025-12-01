import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:tictactoe/models/game.dart';

/// Service to manage game operations in Firebase Realtime Database
class GameService {
  final DatabaseReference _gamesRef = FirebaseDatabase.instance.ref().child(
    'games',
  );

  /// Create a new game
  Future<void> createGame(Game game) async {
    debugPrint('🎮 Creating game: ${game.id}');
    try {
      await _gamesRef.child(game.id).set(game.toJson());
      debugPrint('🎮 Game created successfully');
    } catch (e) {
      debugPrint('🎮 Error creating game: $e');
      rethrow;
    }
  }

  /// Get a game by ID
  Future<Game?> getGame(String gameId) async {
    debugPrint('🎮 Getting game: $gameId');
    try {
      final snapshot = await _gamesRef.child(gameId).get();
      if (!snapshot.exists) {
        debugPrint('🎮 Game not found: $gameId');
        return null;
      }

      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return Game.fromJson(data);
    } catch (e) {
      debugPrint('🎮 Error getting game: $e');
      rethrow;
    }
  }

  /// Watch a game for real-time updates
  Stream<Game?> watchGame(String gameId) {
    debugPrint('🎮 Watching game: $gameId');
    return _gamesRef.child(gameId).onValue.map((event) {
      if (!event.snapshot.exists) {
        debugPrint('🎮 Game not found in stream: $gameId');
        return null;
      }

      try {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        return Game.fromJson(data);
      } catch (e) {
        debugPrint('🎮 Error parsing game data: $e');
        return null;
      }
    });
  }

  /// Update a game
  Future<void> updateGame(Game game) async {
    debugPrint('🎮 Updating game: ${game.id}');
    try {
      await _gamesRef.child(game.id).set(game.toJson());
      debugPrint('🎮 Game updated successfully');
    } catch (e) {
      debugPrint('🎮 Error updating game: $e');
      rethrow;
    }
  }

  /// Delete a game
  Future<void> deleteGame(String gameId) async {
    debugPrint('🎮 Deleting game: $gameId');
    try {
      await _gamesRef.child(gameId).remove();
      debugPrint('🎮 Game deleted successfully');
    } catch (e) {
      debugPrint('🎮 Error deleting game: $e');
      rethrow;
    }
  }

  /// Make a move in the game
  Future<void> makeMove({
    required String gameId,
    required int row,
    required int col,
    required String playerName,
  }) async {
    debugPrint('🎮 Making move at ($row, $col) by $playerName');
    try {
      final game = await getGame(gameId);
      if (game == null) {
        throw Exception('Game not found');
      }

      final updatedGame = game.makeMove(row, col, playerName);
      await updateGame(updatedGame);
      debugPrint('🎮 Move completed successfully');
    } catch (e) {
      debugPrint('🎮 Error making move: $e');
      rethrow;
    }
  }

  /// Restart a finished game
  Future<void> restartGame(String gameId) async {
    debugPrint('🎮 Restarting game: $gameId');
    try {
      final game = await getGame(gameId);
      if (game == null) {
        throw Exception('Game not found');
      }

      if (game.status != GameStatus.finished) {
        throw Exception('Can only restart finished games');
      }

      final restartedGame = game.restart();
      await updateGame(restartedGame);
      debugPrint('🎮 Game restarted successfully');
    } catch (e) {
      debugPrint('🎮 Error restarting game: $e');
      rethrow;
    }
  }
}
