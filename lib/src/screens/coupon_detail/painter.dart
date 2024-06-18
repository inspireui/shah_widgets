import 'package:flutter/material.dart';
import 'dart:math' as math;

class CouponDetailPainter extends CustomPainter {
  final double height;
  final double radius;
  final Color color;
  CouponDetailPainter({
    this.height = 200,
    this.radius = 20,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;
    var path = Path();
    path.arcTo(
      Rect.fromCircle(center: Offset(0, height + radius), radius: radius),
      3 / 2 * math.pi,
      math.pi,
      false,
    );
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.arcTo(
      Rect.fromCircle(
          center: Offset(size.width, height + radius), radius: radius),
      math.pi / 2,
      math.pi,
      false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
