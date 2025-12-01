// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tictactoe/firestore/models/game_state.dart';
// import 'package:tictactoe/firestore/services/firestore_reference_service.dart';

// class FirestoreStreamService {
//   const FirestoreStreamService({
//     required FirestoreReferenceService firestoreReferenceService,
//   }) : _firestoreReferenceService = firestoreReferenceService;

//   final FirestoreReferenceService _firestoreReferenceService;

//   Stream<List<GameState>> gamesCollectionStream() {
//     return _firestoreReferenceService.gamesCollection().snapshots().map(
//           (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
//         );
//   }

//   Stream<List<GameState>> gamesCollectionWhereStream(
//       {required Query<GameState> Function(CollectionReference<GameState>)
//           where}) {
//     final collection = _firestoreReferenceService.gamesCollection();
//     return where(collection).snapshots().map(
//           (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
//         );
//   }

//   Stream<GameState?> gameStateStream({required GameStateId gameStateId}) {
//     return _firestoreReferenceService
//         .gameStateReference(gameStateId: gameStateId)
//         .snapshots()
//         .map(
//           (event) => event.data(),
//         );
//   }
// }
