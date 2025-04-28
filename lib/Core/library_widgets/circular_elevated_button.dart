import 'package:flutter/material.dart';

class CircularRectangleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;

  const CircularRectangleButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: borderColor) // Sharp rectangle
            ),
      ),
      child: child,
    );
  }
}
