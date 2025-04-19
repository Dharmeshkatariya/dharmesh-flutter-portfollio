import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color_file.dart';

class CustomCheckboxWidget extends StatelessWidget {
  final RxBool checkboxValue;
  final ValueChanged<bool> onChangedCallBack;
  OutlinedBorder? shape;

  CustomCheckboxWidget(this.checkboxValue, this.onChangedCallBack, {super.key, this.shape});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Checkbox(
        shape: shape,
        checkColor: Colors.white,
        activeColor: ColorFile.webThemeColor,
        value: checkboxValue.value,
        onChanged: (bool? value) {
          onChangedCallBack(value!);
        },
      ),
    );
  }
}
