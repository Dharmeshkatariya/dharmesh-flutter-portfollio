import 'package:flutter/material.dart';

class HoverButton extends StatelessWidget {
  const HoverButton({super.key});

  @override
  Widget build(BuildContext context) {
    double parentSize = MediaQuery.of(context).size.width;

    return Transform(
      child: Positioned(
        child: Container(
            child: Text(
              "Hello World",
              style: TextStyle(
                color: Color(0x03045E00),
                fontSize: 18.0,
              ),
            ),
            width: parentSize * 0.58,
            height: parentSize * 1,
            decoration: BoxDecoration(
              color: Color(0xE0E0E000),
              borderRadius: BorderRadius.all(const Radius.circular(10.0)),
              border: Border.all(
                  color: Color(0xFF000000),
                  width: 5.0,
                  style: BorderStyle.solid),
            )),
        top: 0,
        left: -10.0,
        right: -10.0,
      ),
      transform: Matrix4.skew(0.15, 0.1), // Skew on both axes
    );
  }
}
