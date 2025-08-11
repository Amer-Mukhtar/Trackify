import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable Line Graph widget without external packages
class LineGraph extends StatelessWidget {
  final List<double> data;
  final Color lineColor;
  final double lineWidth;
  final double height;

  const LineGraph({
    super.key,
    required this.data,
    this.lineColor = Colors.blue,
    this.lineWidth = 2,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: double.infinity,
      child: CustomPaint(
        painter: _LineGraphPainter(data, lineColor, lineWidth),
      ),
    );
  }
}

class _LineGraphPainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final double lineWidth;

  _LineGraphPainter(this.data, this.lineColor, this.lineWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Handle empty data
    if (data.isEmpty) return;

    // Find the max value for scaling
    final maxValue = data.reduce((a, b) => a > b ? a : b);

    // Convert data points to canvas coordinates
    for (int i = 0; i < data.length; i++) {
      final x = (i / (data.length - 1)) * size.width;
      final y = size.height - (data[i] / maxValue) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Draw the line
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
