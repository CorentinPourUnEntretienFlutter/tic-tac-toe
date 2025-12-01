import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/theme/color_theme.dart';

part 'app_theme.freezed.dart';

const bg1R = "assets/images/BG1 R_00000.png";
const bg1W = "assets/images/BG1 W_00000.png";
const bg2R = "assets/images/BG2 R_00000.png";
const bg2W = "assets/images/BG2 W_00000.png";
const bg3B = "assets/images/BG3 B_00000.png";
const bg3R = "assets/images/BG3 R_00000.png";
const bg3W = "assets/images/BG3 W_00000.png";

/// Theme data containg the color theme
/// It could contain other theme data in the future, like text theme, etc.
@freezed
abstract class AppThemeData with _$AppThemeData {
  const factory AppThemeData({
    required AppBrightness brightness,
    required ColorTheme color,
    required String backgroundAssetPath,
  }) = _AppThemeData;

  factory AppThemeData.light() {
    return AppThemeData(
      brightness: AppBrightness.light,
      color: ColorTheme.light(),
      backgroundAssetPath: bg1R,
    );
  }

  factory AppThemeData.dark() {
    return AppThemeData(
      brightness: AppBrightness.dark,
      color: ColorTheme.dark(),
      backgroundAssetPath: bg3B,
    );
  }
}

class AppTheme extends InheritedWidget {
  final AppThemeData data;

  const AppTheme({super.key, required super.child, required this.data});

  static AppThemeData of(BuildContext context) {
    var result = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    return result?.data ?? AppThemeData.light();
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) {
    return data != oldWidget.data;
  }
}

enum AppBrightness { light, dark }

extension AppThemeDataExtension on BuildContext {
  AppThemeData get appTheme => AppTheme.of(this);
}
