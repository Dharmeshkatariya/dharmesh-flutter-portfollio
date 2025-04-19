import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double cornerRadius = 25.w; // Adjust as needed

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(0, size.height, cornerRadius, size.height);
    path.lineTo(size.width - cornerRadius, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - cornerRadius);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(0, size.height * 0.1, 0, size.height * 0.7);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ForegroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double curveHeight = size.height * 0.3; // Adjust curve height

    path.lineTo(0, size.height - curveHeight);
    path.quadraticBezierTo(size.width * 0.1, size.height, size.width * 0.3, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomShapeWidget extends StatelessWidget {
  final Widget child;

  const CustomShapeWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 300.h,
      child: Stack(
        children: [
          // Background Shape
          ClipPath(
            clipper: BackgroundClipper(),
            child: Container(
              width: 340.w,
              height: 320.h,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100, // Background color
              ),
            ),
          ),
          // Foreground clipped image
          ClipPath(
            clipper: ForegroundClipper(),
            child: Container(
              width: 300.w,
              height: 300.h,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

//
// class CustomClipShape extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//
//     double curveHeight = size.height * 0.3; // Adjust curve height
//
//     path.lineTo(0, size.height - curveHeight);
//     path.quadraticBezierTo(size.width * 0.1, size.height, size.width * 0.3, size.height);
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 0);
//     path.lineTo(0, 0);
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
//
// class CustomShapeWidget extends StatelessWidget {
//   final Widget child;
//
//   const CustomShapeWidget({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 250.w,
//       height: 250.h,
//       child: Stack(
//         children: [
//           ClipPath(
//             clipper: CustomClipShape(),
//             child: Container(
//               width: 390.w,
//               height: 280.h,
//               decoration: BoxDecoration(
//                 color: Colors.lightBlue.shade100, // Background color
//                 borderRadius: BorderRadius.circular(20.w),
//               ),
//             ),
//           ),
//           // Foreground clipped image
//           ClipPath(
//             clipper: CustomClipShape(),
//             child: Container(
//               width: 250.w,
//               height: 250.h,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.w),
//               ),
//               child: child,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomClipShape extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//
//     double cornerRadius = 25.w; // Adjust as needed
//
//     path.moveTo(0, size.height * 0.7);
//     path.quadraticBezierTo(0, size.height, cornerRadius, size.height);
//     path.lineTo(size.width - cornerRadius, size.height);
//     path.quadraticBezierTo(size.width, size.height, size.width, size.height - cornerRadius);
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width * 0.3, 0);
//     path.quadraticBezierTo(0, size.height * 0.1, 0, size.height * 0.7);
//
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }
//
// class CustomShapeWidget extends StatelessWidget {
//   final Widget child;
//
//   const CustomShapeWidget({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return  ClipPath(
//       clipper: CustomClipShape(),
//       child: Container(
//         width: 300.w,
//         height: 450.h,
//         child: child,
//       ),
//     );
//   }
// }
