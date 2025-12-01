import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

StateProvider<double> blendProvider = StateProvider<double>((ref) => 20.0);
StateProvider<double> refractiveIndexProvider = StateProvider<double>(
  (ref) => 1.0,
);
final settingsNotifier = StateProvider<LiquidGlassSettings>(
  (ref) => LiquidGlassSettings(
    glassColor: Colors.white.withValues(alpha: 0.2),
    refractiveIndex: 1.2,
    thickness: 20.0,
    lightIntensity: 0.5,
    ambientStrength: 0.5,
    blur: 5.0,
    chromaticAberration: 1.17,
    saturation: 1,
  ),
);
