import 'package:flutter/material.dart';

class CustomTextFieldWithDottedLines extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final double cursorHeight;
  final double cursorWidth;
  final String hintText;
  final TextStyle textStyle;
  final EdgeInsets contentPadding;

  const CustomTextFieldWithDottedLines({
    super.key,
    required this.controller,
    this.maxLines = 8,
    this.cursorHeight = 25.0,
    this.cursorWidth = 2.0,
    this.hintText = '',
    this.textStyle = const TextStyle(fontSize: 16, height: 3.0),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dotted lines background
        CustomPaint(
          size: Size(double.infinity, 48.20 * maxLines), // Adjust height dynamically
          painter: DottedLinePainter(lineHeight: 48.20),
        ),
        // TextField overlay
        TextField(
          maxLines: maxLines,
          cursorHeight: cursorHeight,
          cursorWidth: cursorWidth,
          onTapOutside:(v){
            FocusManager.instance.primaryFocus!.unfocus();
          },
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: contentPadding,
          ),
          style: textStyle,
        ),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final double lineHeight;

  DottedLinePainter({required this.lineHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 2.0;

    for (double y = lineHeight; y <= size.height; y += lineHeight) {
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, y),
          Offset(startX + dashWidth, y),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



