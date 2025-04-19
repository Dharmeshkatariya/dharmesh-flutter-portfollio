import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../custom_view/border_container.dart';
import '../../../custom_view/custom_text.dart';
import '../../../model/portfolio_model.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/color_file.dart';
import '../../../utils/common.dart';
import '../../../utils/string_file.dart';
import '../widget/portfolio_card_widget.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({
    super.key,
    required this.portfolioList,
    required this.horizontalPadding,
  });

  final List<PortfolioModel> portfolioList;
  final EdgeInsetsGeometry horizontalPadding;

  @override
  _PortfolioSectionState createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  final scrollController = ScrollController();

  void _nextPage() {
    double scrollAmount = 250.w + 20.w;
    scrollController.animateTo(
      scrollController.offset + scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _prevPage() {
    double scrollAmount = 250.w + 20.w;
    scrollController.animateTo(
      scrollController.offset - scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _card();
  }

  Widget _card() {
    return BorderContainer(
      width: double.infinity,
      height: Common.isWebSize() ? 550.h : 550.h,
      border: Border.all(color: ColorFile.transparentColor),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          CustomTextView(StringFile.portfolio,
              style: AppTextStyles.boldBlack28),
          SizedBox(height: 10.h),
          CustomTextView(
            StringFile.portfolioDescription,
            textAlign: TextAlign.center,
            style: AppTextStyles.regularBlack14,
          ),
          SizedBox(height: 20.h),
          Expanded(
              child: Container(
            padding: widget.horizontalPadding,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      size: 30.w, color: Colors.black),
                  onPressed: _prevPage,
                ),
                Expanded(
                  child: _horizontalScroll(),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                      size: 30.w, color: Colors.black),
                  onPressed: _nextPage,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _horizontalScroll() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 25.w,
          runSpacing: 25.h,
          children: widget.portfolioList.map((item) {
            return PortfolioCardWidget(model: item);
          }).toList(),
        ),
      ),
    );
  }
}

