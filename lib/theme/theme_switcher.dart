import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/theme/app_theme.dart';
import 'package:tictactoe/theme/app_theme.provider.dart';
import 'package:tictactoe/widgets/glass_icon.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final brightness = theme.brightness;

    return GlassIcon(
      icon: brightness == AppBrightness.light
          ? Icons.dark_mode
          : Icons.light_mode,
      color: theme.color.onPrimary2,
      onTap: () => ref.read(appThemeProvider.notifier).state =
          brightness == AppBrightness.light
          ? AppThemeData.dark()
          : AppThemeData.light(),
    );
  }
}
