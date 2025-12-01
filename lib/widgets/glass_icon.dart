import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:tictactoe/providers/settings_providers.dart';

class GlassIcon extends ConsumerWidget {
  const GlassIcon({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        child: Center(
          child: LiquidGlass.withOwnLayer(
            settings: ref.watch(settingsNotifier),
            shape: LiquidOval(),
            child: GlassGlow(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
