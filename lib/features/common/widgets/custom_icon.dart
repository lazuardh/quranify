import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quranify/lib.dart';

class AyahMarker extends StatelessWidget {
  const AyahMarker({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    final digits = number.toString().length;

    final size = switch (digits) {
      1 => 38.0,
      2 => 44.0,
      _ => 50.0,
    };

    final fontSize = switch (digits) {
      1 => 12.0,
      2 => 11.0,
      _ => 9.0,
    };

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(size: Size.square(size), painter: _AyahMarkerPainter()),
          Text(
            '$number',
            style: AppTextStyle.extraBold.copyWith(
              color: AppColors.ink,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

class _AyahMarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final outerPath = _createStar(center, size.width * 0.45, size.width * 0.35);

    final innerPath = _createStar(center, size.width * 0.33, size.width * 0.25);

    canvas.drawShadow(outerPath, Colors.black.withValues(alpha: 0.25), 4, true);

    canvas.drawPath(
      outerPath,
      Paint()
        ..color = AppColors.tertiary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    canvas.drawPath(
      innerPath,
      Paint()
        ..color = AppColors.tertiaryDark
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  Path _createStar(Offset center, double outerRadius, double innerRadius) {
    final path = Path();

    for (int i = 0; i < 16; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;

      final angle = (pi / 8) * i - pi / 2;

      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_) => false;
}
