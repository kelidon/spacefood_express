part of '../animated_circle.dart';

extension _AnimatedCircleStateExt on _AnimatedCircleState {}

mixin _AnimatedCircleStateMixin<T extends StatefulWidget> on State<T> {
  late AnimationController _controller;
  late AnimationController _shadowController;
  late AnimationController _colorController;
  late AnimationController _planetController;
  late Animation<double> _waveAnimation;
  late Animation<double> _shadowAnimation;
  late Animation<Color?> _colorAnimation;

  final double shadowSigma = 1;
  final Duration waveAnimationDuration = const Duration(seconds: 30);
  final Duration shadowAnimationDuration = const Duration(seconds: 3);
  final Duration colorAnimationDuration = const Duration(seconds: 60);

  List<Color> tweenSequenceColors = [
    Colors.white,
  ];

  void onInitState(TickerProvider parent) {
    _controller = AnimationController(
      vsync: parent,
      duration: waveAnimationDuration,
    )..repeat(reverse: true);
    _waveAnimation = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );
    _shadowController = AnimationController(
      vsync: parent,
      duration: shadowAnimationDuration,
    )..repeat(reverse: true);
    _shadowAnimation = Tween<double>(begin: 5, end: 10).animate(
      CurvedAnimation(
        parent: _shadowController,
        curve: Curves.easeInOutQuad.flipped,
      ),
    );
    _colorController = AnimationController(
      vsync: parent,
      duration: colorAnimationDuration,
    )..repeat();
    _colorAnimation = TweenSequence<Color?>(
      List.generate(
        tweenSequenceColors.length,
        (i) => TweenSequenceItem(
          weight: 1,
          tween: ColorTween(
            begin: tweenSequenceColors[((i - 1) % tweenSequenceColors.length)],
            end: tweenSequenceColors[i],
          ),
        ),
      ).toList(),
    ).animate(
      CurvedAnimation(
        parent: _colorController,
        curve: Curves.decelerate,
      ),
    );
    _planetController = AnimationController(
      vsync: parent,
      duration: const Duration(seconds: 120),
    )..repeat();

    _controller.drive(
      CurveTween(curve: Curves.linear),
    );
  }
}
