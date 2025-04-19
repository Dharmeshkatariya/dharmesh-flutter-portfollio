import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/color_file.dart';

class HoverButtonController extends GetxController {
  var isHovered = false.obs;

  void setHovered(bool value) => isHovered.value = value;
}

class HoverButton extends StatelessWidget {
  final String text;

  HoverButton({super.key, required this.text});

  final HoverButtonController controller = Get.put(HoverButtonController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return MouseRegion(
          onEnter: (_) => controller.setHovered(true),
          onExit: (_) => controller.setHovered(false),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: controller.isHovered.value
                        ? [
                      ColorFile.webThemeColor,
                      ColorFile.webThemeColor.withOpacity(0.6),
                    ]
                        : [Colors.white.withOpacity(0.6), Colors.white],
                  ).createShader(bounds),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Arial',
                      letterSpacing: 3,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 0),
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: controller.isHovered.value
                      ? MediaQuery.of(context).size.width * 0.3
                      : 0,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: ColorFile.webThemeColor,
                        width: 6,
                      ),
                    ),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Arial',
                      letterSpacing: 3,
                      color: ColorFile.webThemeColor,
                      decoration: TextDecoration.none,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 0),
                          color: ColorFile.webThemeColor,
                          blurRadius: 23,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
