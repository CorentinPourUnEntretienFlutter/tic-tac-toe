import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:tictactoe/providers/settings_providers.dart';

class LiquidGlassCard extends ConsumerWidget {
  const LiquidGlassCard({
    super.key,
    required this.child,
    this.borderRadius = 32,
  });

  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LiquidGlass.withOwnLayer(
      settings: ref.watch(settingsNotifier),
      shape: LiquidRoundedSuperellipse(borderRadius: borderRadius),
      child: GlassGlow(child: child),
    );
  }
}
