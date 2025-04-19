import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final String style;
  final TextDecoration? textDecoration;
  TextOverflow? overflow;
  TextAlign? textAlign;
  int? maxLines;
  TextDecorationStyle? decorationStyle ;
  // FontWeight? fontWeight;
  FontStyle? fontStyle;
  CustomText(this.text, this.fontSize, this.color, this.style, {this.textAlign , this.decorationStyle,this.textDecoration, this.overflow,this.maxLines,this.fontStyle,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    overflow = (overflow == null) ? TextOverflow.clip : overflow;
    var textStyle = TextStyle(
            overflow: overflow,
            fontSize: fontSize,
            color: color,
            fontFamily: style,
            decoration: textDecoration ?? TextDecoration.none,
            decorationStyle: decorationStyle ,decorationColor: color,
            fontStyle: fontStyle,
            height: 1.5);

    return Text(text, textAlign: textAlign, maxLines: maxLines, overflow: maxLines != null ? TextOverflow.ellipsis : null, style: textStyle);
  }
}

class CustomTextView extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  const CustomTextView(this.text, {super.key, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style,textAlign: textAlign);
  }
}