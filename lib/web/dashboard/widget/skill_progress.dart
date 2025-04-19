import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkillProgressBar extends StatelessWidget {
  final String skillName;
  final double percentage;
  final Color progressColor;
  final Color textColor;
  final Color backgroundColor;

  const SkillProgressBar({
    super.key,
    required this.skillName,
    required this.percentage,
    this.progressColor = Colors.pink,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skillName,
              style: TextStyle(color: textColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              "${percentage.toInt()}%",
              style: TextStyle(color: textColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        // Stack(
        //   children: [
        //     Container(
        //       height: 5.h,
        //       width: double.infinity,
        //       decoration: BoxDecoration(
        //         color: backgroundColor,
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //     ),
        //     Container(
        //       height: 5.h,
        //       width: (percentage / 100) * MediaQuery.of(context).size.width * 0.4 + 0.8,
        //       decoration: BoxDecoration(
        //         color: progressColor,
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //     ),
        //   ],
        // ),
        Stack(
          children: [
            Container(
              height: 5.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percentage / 100,
              child: Container(
                height: 5.h,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
