import 'package:tictactoe/models/game.dart';

/// Abstract service to manage game operations
abstract class GameService {
  /// Create a new game
  Future<void> createGame(Game game);

  /// Get a game by ID
  Future<Game?> getGame({required String gameId});

  /// Watch a game for real-time updates
  Stream<Game?> watchGame({required String gameId});

  /// Update a game
  Future<void> updateGame(Game game);

  /// Delete a game
  Future<void> deleteGame({required String gameId});

  /// Make a move in the game
  Future<void> makeMove({
    required String gameId,
    required int row,
    required int col,
    required String playerName,
  });

  /// Restart a finished game
  Future<void> restartGame({required String gameId});

  void dispose();
}
