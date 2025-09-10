import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dharmesh_portfollio/web/splash/widget/animated_image.dart';
import 'package:dharmesh_portfollio/web/splash/widget/animated_loading.dart';
import '../../routes/routes.dart';
import '../../utils/color_file.dart';
import '../dashboard/dashboard_home_view_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.delete<DashboardHomeViewController>();
      Get.toNamed(
        Routes().homeScreen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFile.webThemeColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AnimatedImageContainer(
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: 20.h,
            ),
            const AnimatedLoadingText(),
          ],
        ),
      ),
    );
  }
}
