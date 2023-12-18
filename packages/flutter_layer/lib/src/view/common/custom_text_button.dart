import 'package:flutter/material.dart';
import 'package:flutter_layer/src/common/constants/ui_constants.dart';
import 'package:flutter_layer/src/common/extensions/extensions.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton({
    required this.text,
    required this.onTap,
    this.style,
    super.key,
  });

  final String text;
  final TextStyle? style;
  final VoidCallback onTap;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton>
    with SingleTickerProviderStateMixin {
  bool scaled = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: UIC.commonAnimationDuration,
    );
    _animation = Tween<double>(begin: 0.0, end: 5.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle =
        widget.style ?? context.textTheme.titleLargeN.white;
    final Color textColor =
        widget.style?.color ?? defaultStyle.color ?? Colors.white;
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _controller.forward();
            scaled = true;
          });
        },
        onExit: (_) {
          setState(() {
            _controller.reverse();
            scaled = false;
          });
        },
        child: AnimatedScale(
          scale: scaled ? 1.1 : 1,
          duration: UIC.commonAnimationDuration,
          curve: Curves.easeInQuad,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return Text(
                widget.text,
                style: widget.style ??
                    defaultStyle.copyWith(
                      shadows: [
                        BoxShadow(
                          color: textColor,
                          spreadRadius: 0,
                          blurRadius: _animation.value,
                        ),
                      ],
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
