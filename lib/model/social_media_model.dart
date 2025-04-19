import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialMediaModel {
  String? svgPath = '';
  Rx<bool>? isSelected = false.obs;
  GlobalKey? globalKey;
  String? displayText = '';
  String? link = '';



  SocialMediaModel(
      {this.svgPath,
      this.displayText,
      this.link,
      this.isSelected,
      this.globalKey});
}
