part of '../animated_circle.dart';

extension _AnimatedCircleStateExt on _AnimatedCircleState {}

mixin _AnimatedCircleStateMixin<T extends StatefulWidget> on State<T> {
  late AnimationController _controller;
  late AnimationController _shadowController;
  late AnimationController _colorController;
  late Animation<double> _waveAnimation;
  late Animation<double> _shadowAnimation;
  late Animation<Color?> _colorAnimation;

  final double shadowSigma = 20;
  final double mainStrokeWidth = 10;
  final Duration waveAnimationDuration = const Duration(seconds: 30);
  final Duration shadowAnimationDuration = const Duration(seconds: 5);
  final Duration colorAnimationDuration = const Duration(seconds: 60);

  List<Color> tweenSequenceColors = [
    Colors.blueAccent,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.white,
    Colors.black,
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
    _shadowAnimation = Tween<double>(begin: 10, end: 20).animate(
      CurvedAnimation(
        parent: _shadowController,
        curve: Curves.decelerate,
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
  }
}
