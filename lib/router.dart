import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/providers/game_providers.dart';
import 'package:tictactoe/screens/home_screen.dart';
import 'package:tictactoe/screens/local_game_screen.dart';
import 'package:tictactoe/screens/online_game_screen.dart';
import 'package:tictactoe/screens/game_selection_screen.dart';
import 'package:tictactoe/screens/online_pseudo_screen.dart';
import 'package:tictactoe/screens/realtime_debug_screen.dart';
import 'package:tictactoe/services/game_service_local_impl.dart';

/// Application router configuration using go_router for declarative routing
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
    ),
    GoRoute(
      path: '/online-pseudo',
      name: 'online-pseudo',
      pageBuilder: (context, state) {
        return MaterialPage(child: OnlinePseudoScreen());
      },
    ),
    GoRoute(
      path: '/online-pseudo/game-selection',
      name: 'online-game-selection',
      pageBuilder: (context, state) {
        final playerName = state.uri.queryParameters['playerName'] ?? '';
        return MaterialPage(child: GameSelectionScreen(playerName: playerName));
      },
    ),
    GoRoute(
      path: '/online-pseudo/game-selection/:gameId',
      name: 'online-game',
      pageBuilder: (context, state) {
        final gameId = state.pathParameters['gameId']!;
        final playerName = state.uri.queryParameters['playerName'] ?? '';
        return MaterialPage(
          child: OnlineGameScreen(gameId: gameId, playerName: playerName),
        );
      },
    ),
    GoRoute(
      path: '/offlinegame',
      name: 'offlinegame',
      pageBuilder: (context, state) => MaterialPage(
        child: ProviderScope(
          overrides: [
            gameServiceProvider.overrideWith((ref) => GameServiceLocal()),
          ],
          child: const LocalGameScreen(),
        ),
      ),
    ),
    GoRoute(
      path: '/debug',
      name: 'debug',
      pageBuilder: (context, state) =>
          const MaterialPage(child: RealtimeDebugScreen()),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Page Not Found')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            '404 - Page Not Found',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Path: ${state.uri.path}',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);
