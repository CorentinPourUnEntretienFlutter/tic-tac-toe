import 'package:flutter/material.dart';
import 'package:tictactoe/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  factory AppButton.primary({
    required BuildContext context,
    required VoidCallback onPressed,
    required String text,
  }) {
    final colorTheme = context.appTheme.color;
    return AppButton(
      onPressed: onPressed,
      text: text,
      backgroundColor: colorTheme.mainBackground,
      foregroundColor: colorTheme.onMainBackground,
    );
  }

  factory AppButton.secondary({
    required BuildContext context,
    required VoidCallback onPressed,
    required String text,
  }) {
    final colorTheme = context.appTheme.color;
    return AppButton(
      onPressed: onPressed,
      text: text,
      backgroundColor: colorTheme.secondary,
      foregroundColor: colorTheme.onSecondary,
    );
  }

  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
