import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    required this.icon,
    required this.onTap,
    this.size,
    this.color,
    this.style,
    super.key,
  });

  final Icon icon;
  final int? size;
  final Color? color;
  final TextStyle? style;
  final VoidCallback onTap;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with SingleTickerProviderStateMixin {
  bool scaled = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0.0, end: 5.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
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
          scale: scaled ? 1.3 : 1,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInQuad,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return Icon(
                Icons.chevron_left_rounded,
                size: 30,
                shadows: [
                  BoxShadow(
                    color: widget.color ?? Colors.white,
                    blurRadius: _animation.value,
                    spreadRadius: 0,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
