part of 'animated_circle.dart';

class _AnimatedCirclePainter extends CustomPainter {
  final Animation<double> waveAnimation;
  final Animation<double> shadowAnimation;
  final math.Random random = math.Random();

  final Animation<Color?> color;
  final double shadowSigma;

  _AnimatedCirclePainter({
    required this.color,
    required this.shadowSigma,
    required this.shadowAnimation,
    required this.waveAnimation,
  }) : super(repaint: waveAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = Paint()
      ..color = color.value!
      ..style = PaintingStyle.stroke
      ..imageFilter = ImageFilter.blur(
        sigmaY: shadowSigma,
        sigmaX: shadowSigma,
      )
      ..strokeWidth = shadowAnimation.value;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = (size.width / 2) - (shadowAnimation.value / 1.5);

    const double wavesCount = 1;
    const double angleStep = (2 * math.pi) / 360;

    final Path path = Path();

    final double phase = waveAnimation.value * math.pi;

    for (double theta = 0; theta < 2 * math.pi; theta += angleStep) {
      final double waveHeight =
          waveAnimation.value * math.sin(theta * wavesCount + phase).abs();

      final double x = centerX + (radius + waveHeight) * math.cos(theta);
      final double y = centerY + (radius + waveHeight) * math.sin(theta);

      if (theta == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, shadowPaint);
  }

  @override
  bool shouldRepaint(_AnimatedCirclePainter oldDelegate) {
    return oldDelegate.waveAnimation != waveAnimation;
  }
}
