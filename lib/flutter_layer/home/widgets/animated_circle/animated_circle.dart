import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

part 'functions/animated_circle_functions.dart';

part 'animated_cirlcle_painter.dart';

class AnimatedCircle extends StatefulWidget {
  const AnimatedCircle({
    super.key,
  });

  @override
  State<AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with _AnimatedCircleStateMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    onInitState(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _shadowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(400, 400),
        painter: _AnimatedCirclePainter(
          color: _colorAnimation,
          waveAnimation: _waveAnimation,
          shadowAnimation: _shadowAnimation, shadowSigma: shadowSigma, mainStrokeWidth: mainStrokeWidth,
        ),
      ),
    );
  }
}
