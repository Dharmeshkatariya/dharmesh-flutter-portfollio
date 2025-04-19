import 'package:flutter/material.dart';

import '../../../custom_view/custom_text.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/color_file.dart';

class AnimatedTextWidget extends StatefulWidget {
  final List<String> texts;
  final TextStyle? textStyle;
  final Duration duration;
  final Duration pauseDuration;

  const AnimatedTextWidget({
    super.key,
    required this.texts,
    this.textStyle,
    this.duration = const Duration(milliseconds: 3000),
    this.pauseDuration = const Duration(milliseconds: 1000),
  });

  @override
  _AnimatedTextWidgetState createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;
  bool _reverse = false;
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_reverse) {
        Future.delayed(widget.pauseDuration, () {
          if (mounted) {
            _reverse = true;
            _controller.reverse();
          }
        });
      } else if (status == AnimationStatus.dismissed && _reverse) {
        _currentIndex = (_currentIndex + 1) % widget.texts.length;
        _reverse = false;
        _controller.forward();
      }
    });

    _startCursorBlinking();
  }

  void _startCursorBlinking() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _showCursor = !_showCursor;
        _startCursorBlinking();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        String text = widget.texts[_currentIndex];
        int charCount = (text.length * _animation.value).floor();
        String displayedText = text.substring(0, charCount);
        return CustomTextView(
          displayedText + (_showCursor ? '|' : ''),
          style: AppTextStyles.semiBoldBlack40
              .copyWith(color: ColorFile.webThemeColor),
        );
      },
    );
  }
}
