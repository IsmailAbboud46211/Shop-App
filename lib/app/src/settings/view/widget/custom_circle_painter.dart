import 'package:flutter/material.dart';

class CircleImagePainter extends CustomPainter {
  final String imageUrl;

  const CircleImagePainter({required this.imageUrl});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey // Set background color if needed
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    // Draw the image inside the circle (replace with your image loading logic)
    // ...
  }

  @override
  bool shouldRepaint(CircleImagePainter oldDelegate) =>
      imageUrl != oldDelegate.imageUrl;
}
