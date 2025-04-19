import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/assets_icons.dart';


class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        _buildBackground(),
        _buildProfileContent(),
      ],
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3F2FD), Color(0xFFF1F8E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomPaint(
        size: Size(double.infinity, 400.h),
        painter: BackgroundShapesPainter(),
      ),
    );
  }

  Widget _buildProfileContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 80.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "HEY! I’m Laura,",

                ),
                Text(
                  "UI/UX designer",

                ),
                SizedBox(height: 15.h),
                Text(
                  "Agency-quality Webflow websites with the personal touch of a freelancer.",
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Icon(Icons.linked_camera, size: 32, color: Colors.black),
                    SizedBox(width: 15.w),
                    Icon(Icons.web, size: 32, color: Colors.black),
                    SizedBox(width: 15.w),
                    Icon(Icons.work, size: 32, color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
          ClipOval(
            child: Image.asset(
              AssetsIcons.portfolio,
              width: 300.w,
              height: 300.h,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.purple.shade100;
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.3), 50, paint);

    paint.color = Colors.blue.shade100;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.2, size.height * 0.6, 60, 60),
        Radius.circular(10),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


// class ProfileSection extends StatelessWidget {
//   const ProfileSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             ClipPath(
//               clipper: BottomCurveClipper(),
//               child: Container(
//                 height: 400.h,
//                 width: double.infinity,
//                 color:  ColorFile.webThemeColor,
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Padding(
//                 padding: EdgeInsets.only(right: 40.w, top: 80.h),
//                 child: Container(
//                   width: 200.w,
//                   height: 200.h,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 15,
//                         spreadRadius: 3,
//                         offset: Offset(0, 6),
//                       ),
//                     ],
//                     border: Border.all(color: Colors.white, width: 5),
//                   ),
//                   child: ClipOval(
//                     child: Image.asset(
//                       AssetsIcons.portfolio, // Your Image Here
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//
//             Positioned(
//               left: 30.w,
//               top: 100.h,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("HELLO I AM",
//                       style: TextStyle(
//                           fontSize: 18.sp,
//                           letterSpacing: 2,
//                           color: Colors.white)),
//                   SizedBox(height: 5.h),
//
//                   SizedBox(height: 15.h),
//
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }


