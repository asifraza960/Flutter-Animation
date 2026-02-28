import 'package:flutter/material.dart';
import 'dart:math';

class ArcPainter extends CustomPainter {
  final double startAngle;
  final double endAngle;

  ArcPainter({required this.startAngle, required this.endAngle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final rect = Rect.fromCircle(
      center: center,
      radius: min(size.width / 2, size.height / 2),
    );

    final paint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, endAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
