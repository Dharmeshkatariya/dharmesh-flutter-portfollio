import 'dart:ui';

import '../utils/color_file.dart';

class SkillProgressModel {
  String? skillName = '';
  double? percentage = 0.0;
  Color? progressColor = ColorFile.webThemeColor;
  Color? textColor = ColorFile.blackColor;

  SkillProgressModel(
      {this.skillName, this.progressColor, this.textColor, this.percentage});
}
