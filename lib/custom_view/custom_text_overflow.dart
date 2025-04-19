import 'package:flutter/cupertino.dart';

class CustomTextOverFlow extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final String style;
  final int maxLines;

  const CustomTextOverFlow(this.text, this.fontSize, this.color, this.style, this.maxLines, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: fontSize, color: color, fontFamily: style, decoration: TextDecoration.none, height: 1.4));
  }
}
