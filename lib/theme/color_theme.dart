import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'color_theme.freezed.dart';

@freezed
abstract class ColorTheme with _$ColorTheme {
  factory ColorTheme({
    required Color mainBackground,
    required Color onMainBackground,
    required Color mainBackground2,
    required Color primary,
    required Color onPrimary,
    required Color onPrimary2,
    required Color secondary,
    required Color onSecondary,
    required Color playerBackgroundText,
    required Color playerSign,
  }) = _ColorTheme;

  factory ColorTheme.light() {
    return ColorTheme(
      mainBackground: Colors.white,
      onMainBackground: Color(0xFFE10014),
      mainBackground2: Colors.black,
      primary: Color(0xFFE10014),
      onPrimary: Colors.white,
      onPrimary2: Colors.black,
      secondary: Color(0xFFFFCC00),
      onSecondary: Colors.black,
      playerBackgroundText: Colors.black,
      playerSign: Colors.white,
    );
  }

  factory ColorTheme.dark() {
    return ColorTheme(
      mainBackground: Colors.black,
      onMainBackground: Colors.white,
      mainBackground2: Color(0xFFFFCC00),
      primary: Color(0xFFE10014),
      onPrimary: Colors.white,
      onPrimary2: Colors.white,
      secondary: Color(0xFFFFCC00),
      onSecondary: Colors.black,
      playerBackgroundText: const Color.fromARGB(255, 207, 207, 207),
      playerSign: Color(0xFFE10014),
    );
  }
}
