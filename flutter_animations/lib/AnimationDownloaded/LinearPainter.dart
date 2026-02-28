import 'package:flutter/material.dart';

class LinearPainter extends CustomPainter {
  final Animation<Offset> line1;
  final Animation<Offset> line2;
  final Offset linePoint1;
  final Offset commonPoint;
  final Offset linePoint2;

  LinearPainter(
    this.line1,
    this.line2,
    this.linePoint1,
    this.commonPoint,
    this.linePoint2,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final p1 = center + linePoint1;
    final pc = center + commonPoint;

    final current1 = center + line1.value;
    final current2 = center + line2.value;

    canvas.drawLine(p1, current1, paint);
    canvas.drawLine(pc, current2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
