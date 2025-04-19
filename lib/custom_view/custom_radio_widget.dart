import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/color_file.dart';
import '../utils/constants_file.dart';
import 'custom_text.dart';

class CustomRadioWidget extends StatelessWidget {
  final String radioValue;
  final RxString radioGroupValue;
  final ValueChanged<String> onChangedCallBack;


   CustomRadioWidget(this.radioValue, this.radioGroupValue, this.onChangedCallBack,   {super.key});
  @override
  Widget build(BuildContext context) {


    return Obx(() => Radio(
        value: radioValue,
        activeColor: ColorFile.webThemeColor,
        groupValue: radioGroupValue.value,
        onChanged: (value) {
          onChangedCallBack(value.toString());
        }));
  }
}
