import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/firebase_options.dart';
import 'package:tictactoe/router.dart';
import 'package:tictactoe/theme/app_theme.dart';
import 'package:tictactoe/theme/app_theme.provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Configure Firebase to use emulator for development
  //todo: use environment variable for the emulator port
  //todo: use environment variable for the emulator host
  // todo: conditionally use the emulator based on the environment variable or kDebugMode
  if (kDebugMode) {
    try {
      FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
    } catch (e) {
      debugPrint('Error using database emulator: $e');
    }
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final materialAppBarTheme = AppBarTheme.of(context);

    return AppThemeProvider(
      child: Builder(
        builder: (context) {
          final materialThemData = ThemeData(
            appBarTheme: materialAppBarTheme.copyWith(
              systemOverlayStyle:
                  context.appTheme.brightness == AppBrightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
              titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: context.appTheme.color.onPrimary2,
              ),
              foregroundColor: context.appTheme.color.onPrimary2,
            ),
          );
          return MaterialApp.router(
            theme: materialThemData,
            title: 'Tic Tac Toe',
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
