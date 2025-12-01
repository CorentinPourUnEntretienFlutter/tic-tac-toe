import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Widget that displays a background with a tilted text pattern.
/// Used to display the player name in the background.
class GameBackground extends StatelessWidget {
  const GameBackground({
    super.key,
    required this.text,
    required this.textColor,
    this.rotateAngle = -math.pi / 4,
    this.numberOfLines = 10,
    this.spacing = 20.0,
  });

  final String text;
  final Color textColor;
  final double rotateAngle;
  final int numberOfLines;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          child: CustomPaint(
            painter: _TiltedTextPatternPainter(
              textToRepeat: text,
              textColor: textColor,
              rotateAngle: rotateAngle,
              numberOfLines: numberOfLines,
              spacing: spacing,
            ),
          ),
        );
      },
    );
  }
}

/// Custom painter that draws a tilted text pattern background.
class _TiltedTextPatternPainter extends CustomPainter {
  const _TiltedTextPatternPainter({
    required this.textToRepeat,
    required this.textColor,
    required this.rotateAngle,
    required this.numberOfLines,
    required this.spacing,
  });

  final String textToRepeat;
  final Color textColor;
  final double rotateAngle;
  final int numberOfLines;
  final double spacing;

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate font size based on available height and number of lines
    // We need to account for rotation, so we use the diagonal of the canvas
    final diagonal = math.sqrt(
      size.width * size.width + size.height * size.height,
    );
    final lineSpacing = diagonal / numberOfLines;
    final fontSize = lineSpacing * 0.6; // Adjust factor to control text size

    final textStyle = TextStyle(fontSize: fontSize, color: textColor);

    final textPainter = TextPainter(
      text: TextSpan(text: textToRepeat, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    // Save canvas state
    canvas.save();

    // Move to center and rotate
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotateAngle);

    // Calculate the bounding box needed after rotation
    // We need to cover the entire visible area, so we use the diagonal
    final rotatedWidth = diagonal;
    final rotatedHeight = diagonal;

    // Calculate line spacing in rotated space
    final rotatedLineSpacing = rotatedHeight / numberOfLines;

    // Layout text to get its width
    textPainter.layout();
    final textWidth = textPainter.width;

    // Draw lines from top to bottom
    final startY = -rotatedHeight / 2;
    for (int lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
      final y = startY + (lineIndex * rotatedLineSpacing);

      // Shift each line horizontally to avoid vertical alignment
      // Use a sine wave or simple offset based on line index
      final horizontalShift = (lineIndex % 3) * textWidth * 0.3;

      // Draw text repetitions across the line
      var x = -rotatedWidth / 2 + horizontalShift;
      while (x < rotatedWidth / 2) {
        textPainter.paint(canvas, Offset(x, y));
        x += textWidth + spacing;
      }
    }

    // Restore canvas state
    canvas.restore();
  }

  @override
  bool shouldRepaint(_TiltedTextPatternPainter oldDelegate) {
    return oldDelegate.textToRepeat != textToRepeat ||
        oldDelegate.textColor != textColor ||
        oldDelegate.rotateAngle != rotateAngle ||
        oldDelegate.numberOfLines != numberOfLines ||
        oldDelegate.spacing != spacing;
  }
}

/// Animated widget that slides GameBackground when the player changes.
/// New background slides in from the right, old one slides out to the left.
/// (note: it could be improved by using more relevant identifier than the player name)
class AnimatedGameBackground extends StatefulWidget {
  const AnimatedGameBackground({
    super.key,
    required this.text,
    required this.textColor,
    this.rotateAngle = -math.pi / 4,
    this.numberOfLines = 10,
    this.spacing = 20.0,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  final String text;
  final Color textColor;
  final double rotateAngle;
  final int numberOfLines;
  final double spacing;
  final Duration duration;
  final Curve curve;

  @override
  State<AnimatedGameBackground> createState() => _AnimatedGameBackgroundState();
}

class _AnimatedGameBackgroundState extends State<AnimatedGameBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  String? _previousText;
  Color? _previousTextColor;
  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start from right
      end: Offset.zero, // End at center
    ).chain(CurveTween(curve: widget.curve)).animate(_controller);
    // Start at the end position (no animation on first build)
    _controller.value = 1.0;
    _previousText = widget.text;
    _previousTextColor = widget.textColor;
  }

  @override
  void didUpdateWidget(AnimatedGameBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.textColor != widget.textColor) {
      // Player changed - animate transition
      _previousText = oldWidget.text;
      _previousTextColor = oldWidget.textColor;
      _isTransitioning = true;
      _controller.reset();
      _controller.forward().then((_) {
        if (mounted) {
          setState(() {
            _isTransitioning = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Previous background sliding out to the left (only during transition)
        if (_isTransitioning && _previousText != null)
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0), // Exit to left
            ).chain(CurveTween(curve: widget.curve)).animate(_controller),
            child: GameBackground(
              text: _previousText!,
              textColor: _previousTextColor ?? widget.textColor,
              rotateAngle: widget.rotateAngle,
              numberOfLines: widget.numberOfLines,
              spacing: widget.spacing,
            ),
          ),
        // Current background sliding in from the right
        SlideTransition(
          position: _slideAnimation,
          child: GameBackground(
            text: widget.text,
            textColor: widget.textColor,
            rotateAngle: widget.rotateAngle,
            numberOfLines: widget.numberOfLines,
            spacing: widget.spacing,
          ),
        ),
      ],
    );
  }
}
