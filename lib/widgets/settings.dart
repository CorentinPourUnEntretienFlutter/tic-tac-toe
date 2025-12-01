import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/providers/settings_providers.dart';

class SettingsSheet extends ConsumerWidget {
  const SettingsSheet({super.key});

  Future<void> show(BuildContext context) {
    return Navigator.push(
      context,
      CupertinoSheetRoute(builder: (context) => this),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifier);
    final blend = ref.watch(blendProvider);

    return LiquidStretch(
      interactionScale: 1.005,
      stretch: .1,
      child: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: LiquidGlass.withOwnLayer(
          settings: LiquidGlassSettings.figma(
            depth: 50,
            refraction: 100,
            dispersion: 4,
            frost: 2,
            glassColor: Theme.of(
              context,
            ).colorScheme.surface.withValues(alpha: 0.8),
          ),
          shape: LiquidRoundedSuperellipse(borderRadius: 32),
          child: GlassGlow(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyLarge!,
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Settings',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Blend Group blend:'),
                            Text(blend.toStringAsFixed(2)),
                          ],
                        ),
                        CupertinoSlider(
                          value: blend,
                          onChanged: (value) {
                            ref.read(blendProvider.notifier).state = value;
                          },
                          min: 0,
                          max: 200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Thickness:'),
                            Text(settings.thickness.toStringAsFixed(2)),
                          ],
                        ),
                        CupertinoSlider(
                          value: settings.thickness,
                          onChanged: (value) {
                            ref.read(settingsNotifier.notifier).state = settings
                                .copyWith(thickness: value);
                          },
                          min: 0,
                          max: 160,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Light Intensity:'),
                            Text(settings.lightIntensity.toStringAsFixed(2)),
                          ],
                        ),
                        CupertinoSlider(
                          value: settings.lightIntensity,
                          onChanged: (value) {
                            ref.read(settingsNotifier.notifier).state = settings
                                .copyWith(lightIntensity: value);
                          },
                          min: 0,
                          max: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ambient Strength:'),
                            Text(settings.ambientStrength.toStringAsFixed(2)),
                          ],
                        ),
                        CupertinoSlider(
                          value: settings.ambientStrength,
                          onChanged: (value) {
                            ref.read(settingsNotifier.notifier).state = settings
                                .copyWith(ambientStrength: value);
                          },
                          min: 0,
                          max: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Blur:'),
                            Text(settings.blur.toStringAsFixed(2)),
                          ],
                        ),
                        CupertinoSlider(
                          value: settings.blur,
                          onChanged: (value) {
                            ref.read(settingsNotifier.notifier).state = settings
                                .copyWith(blur: value);
                          },
                          min: 0,
                          max: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Chromatic Aberration:'),
                            Text(
                              settings.chromaticAberration.toStringAsFixed(2),
                            ),
                          ],
                        ),
                        CupertinoSlider(
                          value: settings.chromaticAberration,
                          onChanged: (value) {
                            ref.read(settingsNotifier.notifier).state = settings
                                .copyWith(chromaticAberration: value);
                          },
                          min: 0,
                          max: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Saturation:'),
                            Text(settings.saturation.toStringAsFixed(2)),
                          ],
                        ),
                        CupertinoSlider(
                          value: settings.saturation,
                          onChanged: (value) {
                            ref.read(settingsNotifier.notifier).state = settings
                                .copyWith(saturation: value);
                          },
                          min: 0,
                          max: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Refractive Index:'),
                            Text(settings.refractiveIndex.toStringAsFixed(2)),
                          ],
                        ),
                        CupertinoSlider(
                          value: settings.refractiveIndex,
                          onChanged: (value) {
                            ref.read(settingsNotifier.notifier).state = settings
                                .copyWith(refractiveIndex: value);
                          },
                          min: 1,
                          max: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
