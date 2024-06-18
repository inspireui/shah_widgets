import 'dart:math' as math;
import 'package:flutter/material.dart';

class CouponPainter extends CustomPainter {
  Color color;
  final double strokeWidth;
  final double rightWidth;
  final double radius;
  final double circle;
  final double circlePadding;
  final double dashWidth;
  final double dashSpace;
  final bool isRTL;
  CouponPainter({
    required this.color,
    this.strokeWidth = 2,
    this.rightWidth = 100,
    this.radius = 10,
    this.circle = 20.0,
    this.circlePadding = 10.0,
    this.dashWidth = 5,
    this.dashSpace = 5,
    this.isRTL = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final height = size.height;
    final width = size.width;
    final right = rightWidth;
    final left = isRTL ? right : width - right;

    /// draw 4 border
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      math.pi,
      math.pi / 2,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width - radius, radius),
        radius: radius,
      ),
      3 / 2 * math.pi,
      math.pi / 2,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(radius, size.height - radius),
        radius: radius,
      ),
      math.pi / 2,
      math.pi / 2,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width - radius, size.height - radius),
        radius: radius,
      ),
      0,
      math.pi / 2,
      false,
      paint,
    );

    final linePadding = radius;
    final linePaddingCircel = circle * 2 + circlePadding * 2;
    var startLeftX = left - linePaddingCircel;
    if (isRTL) {
      startLeftX = right;
    }
    var startRightX = left;
    if (isRTL) {
      startRightX = right + linePaddingCircel;
    }

    /// draw top line
    canvas.drawLine(
      Offset(linePadding, 0),
      Offset(startLeftX, 0),
      paint,
    );
    canvas.drawLine(
      Offset(startRightX, 0),
      Offset(width - linePadding, 0),
      paint,
    );

    /// draw bottom line
    canvas.drawLine(
      Offset(linePadding, height),
      Offset(startLeftX, height),
      paint,
    );
    canvas.drawLine(
      Offset(startRightX, height),
      Offset(width - linePadding, height),
      paint,
    );

    /// draw left line
    canvas.drawLine(
      Offset(0, linePadding),
      Offset(0, height - linePadding),
      paint,
    );

    /// draw right line
    canvas.drawLine(
        Offset(width, linePadding), Offset(width, height - linePadding), paint);

    var centerX = left - linePaddingCircel / 2;
    if (isRTL) {
      centerX = left + linePaddingCircel / 2;
    }

    /// draw 2 half circle
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(centerX, 0),
        radius: circle,
      ),
      0,
      math.pi,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(centerX, height),
        radius: circle,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );

    /// draw dash
    final maxDashSize = height - (circle + strokeWidth + circlePadding) * 2;
    final dash = maxDashSize / (dashWidth + dashSpace);
    final remainder = dash - dash.toInt();
    var dashStartPoint = circle + circlePadding + remainder / 2;
    while (dashStartPoint < height - circle - circlePadding) {
      canvas.drawLine(
        Offset(centerX, dashStartPoint),
        Offset(
          centerX,
          dashStartPoint + dashWidth,
        ),
        paint,
      );
      dashStartPoint += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
