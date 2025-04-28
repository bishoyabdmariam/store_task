import 'package:flutter/material.dart';

class SharpRectangleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;

  const SharpRectangleButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Sharp rectangle
          side: BorderSide(color: color)
        ),
      ),
      child: child,
    );
  }
}
