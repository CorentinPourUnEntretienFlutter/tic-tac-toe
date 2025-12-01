import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/models/game.dart';
import 'package:tictactoe/services/game_service.dart';
import 'package:tictactoe/services/game_service_realtimedb_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_providers.g.dart';

/// Provider for the game service
@Riverpod(dependencies: [])
GameService gameService(Ref ref) {
  final service = GameServiceOnline();
  ref.onDispose(service.dispose);
  return service;
}

@Riverpod(dependencies: [gameService])
Stream<Game?> gameStream(Ref ref, {required String gameId}) {
  final service = ref.watch(gameServiceProvider);
  return service.watchGame(gameId: gameId);
}
