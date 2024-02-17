import 'dart:ui';

import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final Color color;
  final double height;
  final double dashWidth;
  final double dashHeight;

  DashedLine({
    this.color = Colors.grey,
    this.height = 1.0,
    this.dashWidth = 4.0,
    this.dashHeight = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _DashedLinePainter(
          color: color,
          dashWidth: dashWidth,
          dashHeight: dashHeight,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashHeight;

  _DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = dashHeight;

    final dashCount = (size.width / (2 * dashWidth)).floor();
    final dashSpace = (size.width - (dashCount * dashWidth)) / (dashCount - 1);

    var startPoint = Offset(0.0, size.height / 2);
    for (var i = 0; i < dashCount; i++) {
      canvas.drawLine(startPoint, startPoint + Offset(dashWidth, 0), paint);
      startPoint += Offset(dashWidth + dashSpace, 0);
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) => false;
}
