import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vikram_portfollio_dark/custom_view/custom_text.dart';
import 'package:vikram_portfollio_dark/utils/app_text_styles.dart';
import 'package:vikram_portfollio_dark/utils/color_file.dart';
class CustomInfoWidget extends StatelessWidget {
  final List<String> items;
  final bool isNumberedList;
  final bool isBulletList;
  final TextStyle? textStyle;
  final Color? bulletColor;
  final double spacing;

  const CustomInfoWidget({
    super.key,
    required this.items,
    this.isNumberedList = false,
    this.isBulletList = true,
    this.textStyle,
    this.bulletColor,
    this.spacing = 8.0,
  }) : assert(!(isNumberedList && isBulletList),
  'Cannot have both numbered and bullet list');


  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = textStyle ?? AppTextStyles.regularBlack13.copyWith(
      color: ColorFile.blueColor,
    );
    final bulletColor = this.bulletColor ?? ColorFile.blueColor;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 200.w, // adjust as needed
        maxWidth: 600.w, // adjust as needed
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < items.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == items.length - 1 ? 0 : spacing),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isBulletList)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 6),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: bulletColor,
                          ),
                        ),
                      Expanded(
                        child: CustomTextView(
                          items[i],
                          style: defaultTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}