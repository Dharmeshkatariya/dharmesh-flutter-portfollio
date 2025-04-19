import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vikram_portfollio_dark/web/dashboard/widget/user_display_name_widget.dart';
import '../../../custom_view/custom_horizontal_pager.dart';
import '../../../custom_view/custom_web_header_tab.dart';
import '../../../utils/color_file.dart';
import '../../../utils/common.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
      {super.key,
      required this.mList,
      required this.selectedItem,
      required this.onTap,
      required this.paddingHorizontal,
      required this.mobileMenuWidget, required this.themeColor});

  final List<PagerModel> mList;
  final PagerModel? selectedItem;
  final Function(PagerModel) onTap;
  final EdgeInsetsGeometry paddingHorizontal;
  final Widget mobileMenuWidget;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    Common().setScreenUtilDesignSize(context);
    return _web();
  }

  Widget _web() {
    return Container(
      decoration: const BoxDecoration(color: ColorFile.whiteColor),
      padding: paddingHorizontal,
      width: double.infinity,
      height: 75.h,
      child: Common.isWebSize()
          ? Row(
              children: [
                UserDisplayNameWidget(name: "Vikram", themeColor: themeColor),
                SizedBox(width: 250.w),
                Expanded(child: _pager()),
              ],
            )
          : Row(
              children: [
                Expanded(child: UserDisplayNameWidget(name: "Vikram", themeColor: themeColor)),
                mobileMenuWidget,
              ],
            ),
    );
  }

  Widget _pager() {
    return CustomWebHeaderTab(
      mList: mList,
      selectedItem: selectedItem,
      onTap: (pagerModel) {
        onTap(pagerModel);
      },
    );
  }
}
