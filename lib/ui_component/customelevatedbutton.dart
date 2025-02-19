// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomelevatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double borderRadius;

  // Constructor
  const CustomelevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.lightGreen,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.borderRadius = 8.0,
  });

  @override
  _CustomelevatedButtonState createState() => _CustomelevatedButtonState();
}

class _CustomelevatedButtonState extends State<CustomelevatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (_) {
          _animationController.forward(); // Trigger scale down effect
        },
        onTapUp: (_) {
          _animationController.reverse(); // Scale back up after tap
        },
        onTap: () {
          widget.onPressed(); // Call the original onPressed callback
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(widget.backgroundColor),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                ),
              ),
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                  wordSpacing: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
