// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tictactoe/firestore/models/game_state.dart';

// class FirestoreReferenceService {
//   const FirestoreReferenceService({
//     required FirebaseFirestore firestore,
//   }) : _firestore = firestore;

//   final FirebaseFirestore _firestore;

//   CollectionReference<GameState> gamesCollection() {
//     return _firestore.collection(GameState.collectionKey).withConverter(
//       fromFirestore: (
//         snapshot,
//         _,
//       ) {
//         return GameState.fromFirestore(snapshot);
//       },
//       toFirestore: (
//         value,
//         _,
//       ) {
//         return value.toFirestore();
//       },
//     );
//   }

//   DocumentReference<GameState> gameStateReference(
//       {required GameStateId gameStateId}) {
//     return gamesCollection().doc(gameStateId.value);
//   }
// }
