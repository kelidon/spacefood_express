import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared/src/common/assets/shared_asset.dart';

part 'animated_cirlcle_painter.dart';

part 'functions/animated_circle_functions.dart';

class AnimatedCircle extends StatefulWidget {
  const AnimatedCircle({
    required this.sharedAsset,
    super.key,
  });

  final SharedAsset sharedAsset;

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
    return Stack(
      alignment: Alignment.center,
      children: [
        RotationTransition(
          turns: _planetController,
          child: Image.asset(
            widget.sharedAsset.asset,
            height: 400,
            width: 400,
            fit: BoxFit.contain,
            package: widget.sharedAsset.package,
          ),
        ),
        CustomPaint(
          size: const Size(400, 400),
          foregroundPainter: _AnimatedCirclePainter(
            color: _colorAnimation,
            waveAnimation: _waveAnimation,
            shadowAnimation: _shadowAnimation,
            shadowSigma: shadowSigma,
          ),
        ),
      ],
    );
  }
}
