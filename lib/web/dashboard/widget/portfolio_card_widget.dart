import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../custom_view/border_container.dart';
import '../../../custom_view/custom_text.dart';
import '../../../custom_view/web_custom_button_with_border.dart';
import '../../../model/portfolio_model.dart';
import '../../../utils/app_text_styles.dart';
import '../hover_effect/slide_zoom_effect.dart';

class PortfolioCardWidget extends StatelessWidget {
  final PortfolioModel model;

  const PortfolioCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SlideZoomEffect(
      child: SizedBox(
        width: 300.w,
        height: 350.h,
        child: BorderContainer(
          width: 300.w,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Image with fixed height
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
                child: SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: Image.asset(
                    model.imagePath ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Remaining space for text & button
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextView(
                        model.category!.toUpperCase(),
                        style: AppTextStyles.regularBlack12,
                      ),
                      SizedBox(height: 5.h),
                      CustomTextView(
                        model.title!,
                        style: AppTextStyles.boldBlack16,
                      ),
                      SizedBox(height: 5.h),

                      // Scrollable text if it's very long
                      Expanded(
                        child: SingleChildScrollView(
                          child: CustomTextView(
                            model.description!,
                            style: AppTextStyles.mediumBlack12.copyWith(
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Button at bottom
                      Row(
                        children: [
                          _button(),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return WebCustomButtonWithBorder(model.buttonText!, () {});
  }
}
