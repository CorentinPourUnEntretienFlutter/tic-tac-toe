import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/firebase_options.dart';
import 'package:tictactoe/screens/name_entry_screen.dart';
import 'package:tictactoe/screens/realtime_debug_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Configure Firebase to use emulator for development
  //todo: use environment variable for the emulator port
  //todo: use environment variable for the emulator host
  // todo: conditionally use the emulator based on the environment variable or kDebugMode
  FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NameEntryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Debug screen helper - can be accessed via a debug menu if needed
class DebugMenuScreen extends StatelessWidget {
  const DebugMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Menu'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: const Text('Realtime Database Debug'),
            subtitle: const Text('View and test Firebase Realtime Database'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RealtimeDebugScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
