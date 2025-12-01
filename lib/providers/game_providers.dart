import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/services/game_service.dart';

/// Provider for the game service
final gameServiceProvider = Provider<GameService>((ref) {
  return GameService();
});

/// Stream provider to watch a game by ID
final gameStreamProvider = StreamProvider.family<Game?, String>((ref, gameId) {
  final service = ref.watch(gameServiceProvider);
  return service.watchGame(gameId);
});
