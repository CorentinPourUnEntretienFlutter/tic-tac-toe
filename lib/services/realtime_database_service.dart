import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

/// Service to interact with Firebase Realtime Database
class RealtimeDatabaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  RealtimeDatabaseService() {
    debugPrint('🔥 FirebaseDatabase initialized');
    debugPrint('🔥 App name: ${FirebaseDatabase.instance.app.name}');
    debugPrint('🔥 Database root path: ${_db.path}');
  }

  /// Listen to real-time updates at a specific path
  Stream<DatabaseEvent> watchPath(String path) {
    debugPrint('🔥 Watching path: $path');
    debugPrint('🔥 Database reference root: ${_db.path}');
    debugPrint('🔥 Full reference path: ${_db.child(path).path}');

    return _db
        .child(path)
        .onValue
        .map((event) {
          debugPrint('🔥 Received event for $path: ${event.snapshot.value}');
          return event;
        })
        .handleError((error) {
          debugPrint('🔥 Error watching path $path: $error');
          throw error;
        });
  }

  /// Get a snapshot of data at a specific path
  Future<DataSnapshot> getData(String path) async {
    return await _db.child(path).get();
  }

  /// Write data to a specific path
  Future<void> writeData(String path, dynamic value) async {
    await _db.child(path).set(value);
  }

  /// Update data at a specific path
  Future<void> updateData(String path, Map<String, dynamic> updates) async {
    await _db.child(path).update(updates);
  }

  /// Delete data at a specific path
  Future<void> deleteData(String path) async {
    await _db.child(path).remove();
  }

  /// Get reference to a specific path
  DatabaseReference getReference(String path) {
    return _db.child(path);
  }
}
