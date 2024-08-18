import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2475000, size.height * 0.3000000);
    path_0.lineTo(size.width * 0.6275000, size.height * 0.2980000);
    path_0.lineTo(size.width * 0.6250000, size.height * 0.5980000);
    path_0.lineTo(size.width * 0.2537500, size.height * 0.6040000);
    path_0.lineTo(size.width * 0.1925000, size.height * 0.7120000);
    path_0.lineTo(size.width * 0.2075000, size.height * 0.6080000);
    path_0.lineTo(size.width * 0.2475000, size.height * 0.3000000);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
/*
child: CustomPaint(
  size: Size(WIDTH,(WIDTH*0.625).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
  painter: RPSCustomPainter(),
),
*/