import 'package:bookease/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomPaint(size: const Size(90, 90), painter: LogoPainter()),
      ),
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Center circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.0, fillPaint);

    // Top chevron
    final topPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.40)
      ..lineTo(size.width * 0.5, size.height * 0.20)
      ..lineTo(size.width * 0.75, size.height * 0.40);
    canvas.drawPath(topPath, paint);

    // Bottom chevron
    final bottomPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.60)
      ..lineTo(size.width * 0.5, size.height * 0.80)
      ..lineTo(size.width * 0.75, size.height * 0.60);
    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
