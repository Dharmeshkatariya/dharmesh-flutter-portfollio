import 'package:flutter/material.dart';

class GradientAnimatedButton extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final Color textColor;
  final Color hoverTextColor;
  final Color borderColor;
  final Color backgroundColor;
  final Color hoverLeftColor;
  final Color hoverRightColor;

  const GradientAnimatedButton({
    super.key,
    required this.text,
    this.width = 150,
    this.height = 50,
    this.textColor = const Color(0xFF03045E),
    this.hoverTextColor = const Color(0xFFE0AAFF),
    this.borderColor = const Color(0xFF03045E),
    this.backgroundColor = Colors.transparent,
    this.hoverLeftColor = const Color(0xFF240046),
    this.hoverRightColor = const Color(0xFF5A189A),
  });
  @override
  State<GradientAnimatedButton> createState() => _GradientAnimatedButtonState();
}

class _GradientAnimatedButtonState extends State<GradientAnimatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.borderColor, width: 1),
          color: widget.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.hoverRightColor.withOpacity(0.5)
                  : Colors.transparent,
              blurRadius: 10,
              spreadRadius: 3,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              left: _isHovered ? 0 : -widget.width,
              child: Container(
                width: widget.width * 0.58,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.hoverLeftColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              right: _isHovered ? 0 : -widget.width,
              child: Container(
                width: widget.width * 0.58,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.hoverRightColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: _isHovered ? widget.hoverTextColor : widget.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(widget.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
