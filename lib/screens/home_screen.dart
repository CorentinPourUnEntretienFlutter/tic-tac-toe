import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/theme/app_theme.dart';
import 'package:tictactoe/theme/theme_switcher.dart';
import 'package:tictactoe/widgets/app_button.dart';
import 'package:tictactoe/widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _goToOnlinePseudoScreen(BuildContext context) {
    context.push('/online-pseudo');
  }

  void _goToOfflineScreen(BuildContext context) {
    context.push('/offlinegame');
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.appTheme.color;

    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [ThemeSwitcher()],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Game icon/title
              Icon(Icons.grid_3x3, size: 200, color: colorTheme.onPrimary2),
              const SizedBox(height: 24),
              Text(
                'Tic Tac Toe',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorTheme.onPrimary2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Play with friends in real-time!',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: colorTheme.onPrimary2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              const SizedBox(height: 24),

              // Play online button
              AppButton.primary(
                context: context,
                onPressed: () => _goToOnlinePseudoScreen(context),
                text: 'Online game',
              ),
              const SizedBox(height: 24),
              // Play offline button
              AppButton.secondary(
                context: context,
                onPressed: () => _goToOfflineScreen(context),
                text: 'Offline game',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
