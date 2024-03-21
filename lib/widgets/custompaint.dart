import 'package:flutter/material.dart';

class MyCustomChart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );

    final textSpan = TextSpan(
      text: 'Pro - 54%',
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    // Draw rectangle for 'Pro'
    paint.color = Colors.purple;
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.3, size.width * 0.54, size.height * 0.4),
      paint,
    );

    // Text for 'Pro'
    textPainter.paint(canvas, Offset(size.width * 0.54 + 5, size.height * 0.3));

    // Draw and text for other categories ('Expert', 'Basic', 'Pro Plus') as needed...
    // ...

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}