import 'package:flutter/material.dart';
import 'package:tictactoe/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeProvider = StateProvider<AppThemeData>(
  (ref) => AppThemeData.light(),
);

class AppThemeProvider extends ConsumerWidget {
  const AppThemeProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return AppTheme(data: theme, child: child);
  }
}
