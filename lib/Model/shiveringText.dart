import 'package:flutter/material.dart';

class ShiveringText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  const ShiveringText({
    Key? key,
    required this.text,
    required this.textStyle,
  }) : super(key: key);

  @override
  _ShiveringTextState createState() => _ShiveringTextState();
}

class _ShiveringTextState extends State<ShiveringText> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      style: widget.textStyle.copyWith(
        decoration: TextDecoration.none,
        fontSize: widget.textStyle.fontSize! + 4, // Increase font size for shivering effect
      ),
      duration: const Duration(milliseconds: 300),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value * 4), // Adjust the offset as needed
            child: child,
          );
        },
        child: Text(widget.text),
      ),
    );
  }
}
