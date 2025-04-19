import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../utils/color_file.dart';

class CustomSwitchWidget extends StatelessWidget {
  final RxBool switchValue;
  final ValueChanged<bool> onChangedCallBack;
  Color? activeColor;

  CustomSwitchWidget(this.switchValue, this.onChangedCallBack, {super.key, this.activeColor});

  @override
  Widget build(BuildContext context) {
    activeColor ??= ColorFile.webThemeColor;
    return SizedBox(
      width: 40, // Constrain width to avoid layout issues
      height: 24, // Constrain height
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Obx(() => CupertinoSwitch(
          value: switchValue.value,
          onChanged: (value) {
            onChangedCallBack(value);
          },
          activeColor: activeColor,
        ),),
      ),
    );
  }
}
