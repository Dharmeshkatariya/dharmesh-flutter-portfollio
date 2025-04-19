import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/assets_icons.dart';
import '../utils/color_file.dart';

class PageScrollerCircularProgressBar extends StatelessWidget {
  final ScrollController scrollController;

  PageScrollerCircularProgressBar({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  RxDouble scrollProgress = 0.0.obs;

  // Method to update scroll progress
  void updateScrollProgress(double progress) {
    scrollProgress.value = progress;
  }

  @override
  Widget build(BuildContext context) {
    // Scroll listener
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double scrollPercentage = currentScroll / maxScroll;
      updateScrollProgress(scrollPercentage);
    });

    return Positioned(
      bottom: 50.w,
      right: 20.h,
      child: Obx(
            () => InkWell(
          onTap: () {
            scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 3,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 48.w,
                height: 48.h,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  value: scrollProgress.value,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(ColorFile.webThemeColor),
                ),
              ),
              SvgPicture.asset(
                AssetsIcons.icUpArrow,
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(ColorFile.webThemeColor, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
