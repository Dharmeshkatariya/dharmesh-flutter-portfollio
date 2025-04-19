import 'package:flutter/cupertino.dart';

class CustomTextCenter extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final String style;
  final int? maxLine;

  const CustomTextCenter(this.text, this.fontSize, this.color, this.style, {this.maxLine, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        maxLines: maxLine,
        overflow: maxLine != null ? TextOverflow.ellipsis : null,
        style: TextStyle(fontSize: fontSize, color: color, fontFamily: style, decoration: TextDecoration.none, height: 1.5));
  }
}
