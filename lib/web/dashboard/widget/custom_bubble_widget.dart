import 'dart:math';
import 'package:flutter/material.dart';

class CustomBubbleWidget extends StatelessWidget {
  final int bubbleCount;
  final bool randomPosition;
  final List<Color> bubbleColors;
  final double maxBubbleSize;

  const CustomBubbleWidget({
    super.key,
    this.bubbleCount = 5,
    this.randomPosition = true,
    this.bubbleColors = const [
      Colors.blue,
      Colors.purple,
      Colors.cyan,
    ],
    this.maxBubbleSize = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10.0,
      runSpacing: 10.0,
      children: _generateBubbles(),
    );
  }

  List<Widget> _generateBubbles() {
    final Random random = Random();
    return List.generate(bubbleCount, (index) {
      double size = random.nextDouble() * maxBubbleSize + 10;
      int colorIndex = index % bubbleColors.length;

      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bubbleColors[colorIndex],
          shape: BoxShape.circle,
        ),
      );
    });
  }
}

// class CustomBubbleWidget extends StatelessWidget {
//   const CustomBubbleWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildFloatingShapes();
//   }
//
//   Widget _buildFloatingShapes() {
//     final List<Color> floatingShapeColors = [
//       Colors.blue.shade200,
//       Colors.purple.shade300,
//       Colors.cyan.shade400,
//     ];
//
//     // Manually set positions and sizes
//     final List<Map<String, dynamic>> bubbleData = [
//       {"left": 50.0, "top": 100.0, "size": 20.0, "colorIndex": 0},
//       {"left": 80.0, "top": 150.0, "size": 50.0, "colorIndex": 1},
//       {"left": 150.0, "top": 200.0, "size": 30.0, "colorIndex": 2},
//     ];
//
//     return Positioned.fill(
//       child: Stack(
//         children: bubbleData.map((bubble) {
//           return Positioned(
//             left: bubble["left"],
//             top: bubble["top"],
//             child: Container(
//               width: bubble["size"],
//               height: bubble["size"],
//               decoration: BoxDecoration(
//                 color: floatingShapeColors[bubble["colorIndex"]],
//                 shape: BoxShape.circle,
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

//
// class CustomBubbleWidget extends StatelessWidget {
//   const CustomBubbleWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  _buildFloatingShapes();
//   }
//
//   Widget _buildFloatingShapes() {
//     final List<Color> floatingShapeColors = [
//       Colors.blue.shade200,
//       Colors.purple.shade300,
//       Colors.cyan.shade400,
//     ];
//     final Random random = Random();
//     return Positioned.fill(
//       child: Stack(
//         children: List.generate(3, (index) {
//           double size = random.nextDouble() * 30 + 10;
//           double left = random.nextDouble() * 300;
//           double top = random.nextDouble() * 150;
//           return Positioned(
//             left: left,
//             top: top,
//             child: Container(
//               width: size,
//               height: size,
//               decoration: BoxDecoration(
//                 color: floatingShapeColors[index % floatingShapeColors.length],
//                 shape: BoxShape.circle,
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
