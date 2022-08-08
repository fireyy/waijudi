import 'dart:math';
import 'package:flutter/material.dart';

void moveTo (Path path, double top, double left, double width, double height) => path.moveTo(left + width, top + height);
void cubicTo (Path path, double top, double left, double x1, double y1, double x2, double y2, double x3, double y3) => path.cubicTo(left + x1, top + y1, left + x2, top + y2, left + x3, top + y3);
void lineTo (Path path, double top, double left, double width, double height) => path.lineTo(left + width, top + height);

class MyLogo extends CustomPainter {
  final Axis axis;
  final Color color;
  final double offset;
  final double actualTriggerOffset;

  MyLogo({
    required this.axis,
    required this.color,
    required this.offset,
    required this.actualTriggerOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    final Paint paint = Paint();
    double height = min(size.height, 32.0);
    double width = height * 0.92;
    double left = size.width / 2 - width / 2;
    double top = size.height - height;

    // Path 1 Fill
    paint.color = color;
    moveTo(path, top, left, width * 0.53, height * 0.88);
    cubicTo(path, top, left, width * 0.53, height * 0.89, width * 0.54, height * 0.89, width * 0.54, height * 0.89);
    lineTo(path, top, left, width * 0.64, height * 0.89);
    cubicTo(path, top, left, width * 0.69, height * 0.89, width * 0.77, height * 0.88, width * 0.85, height * 0.82);
    cubicTo(path, top, left, width * 0.85, height * 0.82, width * 0.85, height * 0.82, width * 0.86, height * 0.81);
    cubicTo(path, top, left, width * 0.86, height * 0.81, width * 0.86, height * 0.81, width * 0.86, height * 0.8);
    cubicTo(path, top, left, width * 0.86, height * 0.8, width * 0.85, height * 0.8, width * 0.85, height * 0.8);
    cubicTo(path, top, left, width * 0.85, height * 0.8, width * 0.83, height * 0.8, width * 0.83, height * 0.8);
    cubicTo(path, top, left, width * 0.79, height * 0.8, width * 0.76, height * 0.79, width * 0.74, height * 0.79);
    cubicTo(path, top, left, width * 0.71, height * 0.78, width * 0.69, height * 0.76, width * 0.67, height * 0.75);
    cubicTo(path, top, left, width * 0.66, height * 0.74, width * 0.64, height * 0.73, width * 0.62, height * 0.73);
    cubicTo(path, top, left, width * 0.59, height * 0.73, width * 0.56, height * 0.76, width * 0.55, height * 0.78);
    cubicTo(path, top, left, width * 0.55, height * 0.79, width * 0.55, height * 0.8, width * 0.54, height * 0.82);
    cubicTo(path, top, left, width * 0.54, height * 0.84, width * 0.54, height * 0.84, width * 0.53, height * 0.86);
    cubicTo(path, top, left, width * 0.53, height * 0.86, width * 0.53, height * 0.87, width * 0.53, height * 0.88);
    lineTo(path, top, left, width * 0.53, height * 0.88);
    canvas.drawPath(path, paint);

    // Path 2 Fill
    moveTo(path, top, left, 0, height * 0.61);
    cubicTo(path, top, left, 0, height * 0.77, width * 0.13, height * 0.88, width * 0.27, height * 0.89);
    lineTo(path, top, left, width * 0.28, height * 0.89);
    cubicTo(path, top, left, width * 0.3, height * 0.89, width * 0.31, height * 0.9, width * 0.32, height * 0.9);
    cubicTo(path, top, left, width * 0.32, height * 0.91, width * 0.32, height * 0.92, width * 0.32, height * 0.92);
    lineTo(path, top, left, width * 0.32, height * 0.97);
    cubicTo(path, top, left, width * 0.32, height * 0.97, width * 0.32, height * 0.98, width * 0.33, height * 0.99);
    cubicTo(path, top, left, width * 0.33, height, width * 0.34, height, width * 0.35, height);
    cubicTo(path, top, left, width * 0.39, height, width * 0.42, height * 0.98, width * 0.44, height * 0.96);
    cubicTo(path, top, left, width * 0.46, height * 0.94, width * 0.47, height * 0.93, width * 0.47, height * 0.92);
    cubicTo(path, top, left, width * 0.48, height * 0.91, width * 0.48, height * 0.9, width * 0.5, height * 0.85);
    cubicTo(path, top, left, width * 0.51, height * 0.83, width * 0.51, height * 0.81, width * 0.52, height * 0.79);
    cubicTo(path, top, left, width * 0.52, height * 0.78, width * 0.52, height * 0.77, width * 0.53, height * 0.76);
    cubicTo(path, top, left, width * 0.54, height * 0.73, width * 0.57, height * 0.71, width * 0.61, height * 0.7);
    cubicTo(path, top, left, width * 0.64, height * 0.7, width * 0.66, height * 0.71, width * 0.68, height * 0.72);
    cubicTo(path, top, left, width * 0.69, height * 0.73, width * 0.71, height * 0.74, width * 0.73, height * 0.75);
    cubicTo(path, top, left, width * 0.76, height * 0.76, width * 0.8, height * 0.77, width * 0.83, height * 0.77);
    cubicTo(path, top, left, width * 0.85, height * 0.77, width * 0.88, height * 0.77, width * 0.91, height * 0.75);
    cubicTo(path, top, left, width * 0.93, height * 0.74, width * 0.95, height * 0.72, width * 0.96, height * 0.7);
    cubicTo(path, top, left, width, height * 0.63, width, height * 0.57, width, height * 0.54);
    lineTo(path, top, left, width, height * 0.5);
    cubicTo(path, top, left, width, height * 0.42, width * 0.93, height * 0.34, width * 0.84, height * 0.34);
    lineTo(path, top, left, width * 0.78, height * 0.34);
    cubicTo(path, top, left, width * 0.77, height * 0.34, width * 0.76, height * 0.34, width * 0.75, height * 0.33);
    cubicTo(path, top, left, width * 0.74, height * 0.32, width * 0.74, height * 0.31, width * 0.74, height * 0.31);
    lineTo(path, top, left, width * 0.67, height * 0.31);
    cubicTo(path, top, left, width * 0.67, height * 0.31, width * 0.67, height * 0.32, width * 0.66, height * 0.33);
    cubicTo(path, top, left, width * 0.65, height * 0.34, width * 0.64, height * 0.34, width * 0.63, height * 0.34);
    lineTo(path, top, left, width * 0.2, height * 0.34);
    cubicTo(path, top, left, width * 0.2, height * 0.34, width * 0.19, height * 0.34, width * 0.18, height * 0.34);
    cubicTo(path, top, left, width * 0.17, height * 0.34, width * 0.16, height * 0.34, width * 0.15, height * 0.33);
    cubicTo(path, top, left, width * 0.13, height * 0.32, width * 0.12, height * 0.29, width * 0.12, height * 0.27);
    cubicTo(path, top, left, width * 0.12, height * 0.25, width * 0.13, height * 0.23, width * 0.15, height * 0.21);
    cubicTo(path, top, left, width * 0.16, height * 0.2, width * 0.18, height * 0.19, width * 0.2, height * 0.19);
    cubicTo(path, top, left, width * 0.21, height * 0.19, width * 0.22, height * 0.2, width * 0.23, height * 0.2);
    cubicTo(path, top, left, width * 0.24, height * 0.21, width * 0.25, height * 0.22, width * 0.25, height * 0.22);
    cubicTo(path, top, left, width * 0.27, height * 0.24, width * 0.3, height * 0.26, width * 0.34, height * 0.27);
    cubicTo(path, top, left, width * 0.34, height * 0.27, width * 0.35, height * 0.27, width * 0.35, height * 0.26);
    cubicTo(path, top, left, width * 0.36, height * 0.26, width * 0.36, height * 0.25, width * 0.36, height * 0.25);
    lineTo(path, top, left, width * 0.36, height * 0.19);
    cubicTo(path, top, left, width * 0.36, height * 0.19, width * 0.36, height * 0.18, width * 0.36, height * 0.18);
    cubicTo(path, top, left, width * 0.36, height * 0.18, width * 0.35, height * 0.18, width * 0.35, height * 0.17);
    cubicTo(path, top, left, width * 0.33, height * 0.17, width * 0.32, height * 0.15, width * 0.32, height * 0.14);
    cubicTo(path, top, left, width * 0.32, height * 0.12, width * 0.33, height * 0.1, width * 0.35, height * 0.1);
    cubicTo(path, top, left, width * 0.35, height * 0.1, width * 0.35, height * 0.1, width * 0.35, height * 0.09);
    cubicTo(path, top, left, width * 0.36, height * 0.09, width * 0.36, height * 0.08, width * 0.36, height * 0.08);
    lineTo(path, top, left, width * 0.36, height * 0.02);
    cubicTo(path, top, left, width * 0.36, height * 0.02, width * 0.36, height * 0.01, width * 0.35, height * 0.01);
    cubicTo(path, top, left, width * 0.35, 0, width * 0.34, 0, width * 0.34, 0);
    cubicTo(path, top, left, width * 0.3, height * 0.01, width * 0.27, height * 0.03, width * 0.25, height * 0.05);
    cubicTo(path, top, left, width * 0.24, height * 0.06, width * 0.23, height * 0.07, width * 0.22, height * 0.07);
    cubicTo(path, top, left, width * 0.22, height * 0.08, width * 0.21, height * 0.08, width * 0.2, height * 0.08);
    cubicTo(path, top, left, width * 0.09, height * 0.08, 0, height * 0.16, 0, height * 0.27);
    lineTo(path, top, left, 0, height * 0.61);
    lineTo(path, top, left, 0, height * 0.61);
    moveTo(path, top, left, width * 0.81, height * 0.67);
    cubicTo(path, top, left, width * 0.79, height * 0.69, width * 0.77, height * 0.69, width * 0.75, height * 0.67);
    cubicTo(path, top, left, width * 0.74, height * 0.66, width * 0.74, height * 0.64, width * 0.75, height * 0.62);
    cubicTo(path, top, left, width * 0.76, height * 0.61, width * 0.79, height * 0.6, width * 0.8, height * 0.62);
    cubicTo(path, top, left, width * 0.82, height * 0.63, width * 0.82, height * 0.66, width * 0.81, height * 0.67);
    lineTo(path, top, left, width * 0.81, height * 0.67);
    canvas.drawPath(path, paint);

    // Path 3 Fill
    path = Path();
    top = 0;
    moveTo(path, top, left, width * 0.74, height * 0.32);
    cubicTo(path, top, left, width * 0.74, height * 0.32, width * 0.74, height * 0.32, width * 0.74, height * 0.32);
    lineTo(path, top, left, width * 0.74, height * 0.26);
    cubicTo(path, top, left, width * 0.74, height * 0.24, width * 0.76, height * 0.23, width * 0.78, height * 0.23);
    cubicTo(path, top, left, width * 0.8, height * 0.23, width * 0.82, height * 0.24, width * 0.82, height * 0.26);
    cubicTo(path, top, left, width * 0.82, height * 0.28, width * 0.84, height * 0.3, width * 0.86, height * 0.3);
    cubicTo(path, top, left, width * 0.88, height * 0.3, width * 0.9, height * 0.28, width * 0.9, height * 0.26);
    cubicTo(path, top, left, width * 0.9, height * 0.2, width * 0.85, height * 0.15, width * 0.78, height * 0.15);
    cubicTo(path, top, left, width * 0.75, height * 0.15, width * 0.73, height * 0.16, width * 0.71, height * 0.18);
    cubicTo(path, top, left, width * 0.68, height * 0.16, width * 0.66, height * 0.15, width * 0.63, height * 0.15);
    cubicTo(path, top, left, width * 0.57, height * 0.15, width * 0.51, height * 0.2, width * 0.51, height * 0.26);
    cubicTo(path, top, left, width * 0.51, height * 0.28, width * 0.53, height * 0.3, width * 0.55, height * 0.3);
    cubicTo(path, top, left, width * 0.57, height * 0.3, width * 0.59, height * 0.28, width * 0.59, height * 0.26);
    cubicTo(path, top, left, width * 0.59, height * 0.24, width * 0.61, height * 0.23, width * 0.63, height * 0.23);
    cubicTo(path, top, left, width * 0.65, height * 0.23, width * 0.67, height * 0.24, width * 0.67, height * 0.26);
    lineTo(path, top, left, width * 0.67, size.height - height * 0.69);
    lineTo(path, top, left, width * 0.74, size.height - height * 0.69);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant MyLogo oldDelegate) {
    return oldDelegate.axis != axis ||
        oldDelegate.color != color ||
        oldDelegate.actualTriggerOffset != actualTriggerOffset ||
        (oldDelegate.offset != offset &&
            !(oldDelegate.offset < oldDelegate.actualTriggerOffset &&
                offset < actualTriggerOffset));
  }
}