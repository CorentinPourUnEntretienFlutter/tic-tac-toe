import 'package:flutter/widgets.dart';
import 'package:tictactoe/theme/app_theme.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  /// Different backgrounds assets found on https://brand.betclic.com/#graphics
  static const bg1R = "assets/images/BG1 R_00000.png";
  static const bg1W = "assets/images/BG1 W_00000.png";
  static const bg2R = "assets/images/BG2 R_00000.png";
  static const bg2W = "assets/images/BG2 W_00000.png";
  static const bg3B = "assets/images/BG3 B_00000.png";
  static const bg3R = "assets/images/BG3 R_00000.png";
  static const bg3W = "assets/images/BG3 W_00000.png";

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final shouldRotate = constraints.maxWidth < constraints.maxHeight;
        return RotatedBox(
          quarterTurns: shouldRotate ? 1 : 0,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset(theme.backgroundAssetPath),
          ),
        );
      },
    );
  }
}
