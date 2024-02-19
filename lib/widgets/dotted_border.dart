import 'package:flutter/material.dart';

class DottedBorderDecoration extends Decoration {
  final Color borderColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double dotSpacing; // Added dotSpacing
  const DottedBorderDecoration({
    required this.borderColor,
    this.backgroundColor,
    this.borderRadius = 0.0,
    this.dotSpacing = 4.0, // Default dotSpacing is 4.0
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DottedBorderPainter(
      borderColor: borderColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      dotSpacing: dotSpacing,
    );
  }
}

class _DottedBorderPainter extends BoxPainter {
  final Color borderColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double dotSpacing;

  _DottedBorderPainter({
    required this.borderColor,
    this.backgroundColor,
    this.borderRadius = 0.0,
    this.dotSpacing = 4.0,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()..color = backgroundColor!;
      canvas.drawRect(offset & configuration.size!, backgroundPaint);
    }

    final Paint paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Rect rect = offset & configuration.size!;
    final Path path = _createDottedPath(rect, borderRadius, dotSpacing);

    canvas.drawPath(path, paint);
  }

  Path _createDottedPath(Rect rect, double borderRadius, double dotSpacing) {
    final Path path = Path();

    final RRect roundedRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    // Top side
    for (double i = roundedRect.left; i < roundedRect.right; i += dotSpacing * 2) {
      path.moveTo(i, roundedRect.top);
      path.lineTo(i + dotSpacing, roundedRect.top);
    }

    // Right side
    for (double i = roundedRect.top; i < roundedRect.bottom; i += dotSpacing * 2) {
      path.moveTo(roundedRect.right, i);
      path.lineTo(roundedRect.right, i + dotSpacing);
    }

    // Bottom side
    for (double i = roundedRect.left; i < roundedRect.right; i += dotSpacing * 2) {
      path.moveTo(i, roundedRect.bottom);
      path.lineTo(i + dotSpacing, roundedRect.bottom);
    }

    // Left side
    for (double i = roundedRect.top; i < roundedRect.bottom; i += dotSpacing * 2) {
      path.moveTo(roundedRect.left, i);
      path.lineTo(roundedRect.left, i + dotSpacing);
    }

    return path;
  }

}
