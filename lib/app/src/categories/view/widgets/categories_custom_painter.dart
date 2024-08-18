import 'package:flutter/material.dart';
import 'package:shop_app/core/themes/app_color.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0025000, size.height * 0.0540000);
    path_0.quadraticBezierTo(size.width * 0.0616250, size.height * 0.0377200,
        size.width * 0.2083000, size.height * 0.1485800);
    path_0.cubicTo(
        size.width * 0.2925750,
        size.height * 0.2177300,
        size.width * 0.2844000,
        size.height * 0.2136000,
        size.width * 0.2883250,
        size.height * 0.2148500);
    path_0.cubicTo(
        size.width * 0.2916250,
        size.height * 0.3685000,
        size.width * 0.2641562,
        size.height * 0.5089700,
        size.width * 0.2550000,
        size.height * 0.6110000);
    path_0.cubicTo(
        size.width * 0.2547250,
        size.height * 0.6097000,
        size.width * 0.2337000,
        size.height * 0.7484600,
        size.width * 0.2099500,
        size.height * 0.7752100);
    path_0.quadraticBezierTo(size.width * 0.1699500, size.height * 0.8249600, 0,
        size.height * 0.9170000);
    path_0.lineTo(size.width * -0.0025000, size.height * 0.0540000);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
