import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/services/realtime_database_service.dart';

/// Provider for the Realtime Database service
final realtimeDatabaseServiceProvider = Provider<RealtimeDatabaseService>(
  (ref) => RealtimeDatabaseService(),
);

/// Stream provider to watch a specific path in the database
/// Usage: ref.watch(databasePathProvider('/test'))
final databasePathProvider =
    StreamProvider.family<DatabaseEvent, String>((ref, path) {
  final service = ref.watch(realtimeDatabaseServiceProvider);
  return service.watchPath(path);
});

