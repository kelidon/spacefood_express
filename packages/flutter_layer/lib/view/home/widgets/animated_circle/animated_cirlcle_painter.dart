part of 'animated_circle.dart';

class _AnimatedCirclePainter extends CustomPainter {
  final Animation<double> waveAnimation;
  final Animation<double> shadowAnimation;
  final math.Random random = math.Random();
  late double startAngle;

  final Animation<Color?> color;
  final double shadowSigma;
  final double mainStrokeWidth;

  _AnimatedCirclePainter({
    required this.color,
    required this.shadowSigma,
    required this.mainStrokeWidth,
    required this.shadowAnimation,
    required this.waveAnimation,
  }) : super(repaint: waveAnimation) {
    startAngle = random.nextDouble() * (2 * math.pi);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = color.value!
      ..style = PaintingStyle.stroke
      ..strokeWidth = mainStrokeWidth;
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
    final double radius = size.width / 3;

    const double wavesCount = 1;
    const double angleStep = (2 * math.pi) / 360;

    Path path = Path();

    double phase = waveAnimation.value * math.pi;

    for (double theta = 0; theta < 2 * math.pi; theta += angleStep) {
      double waveHeight =
          waveAnimation.value * math.sin(theta * wavesCount + phase).abs();

      double x = centerX + (radius + waveHeight) * math.cos(theta);
      double y = centerY + (radius + waveHeight) * math.sin(theta);

      if (theta == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, circlePaint);
    canvas.drawPath(path, shadowPaint);
  }

  @override
  bool shouldRepaint(_AnimatedCirclePainter oldDelegate) {
    return oldDelegate.waveAnimation != waveAnimation;
  }
}