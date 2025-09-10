import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dharmesh_portfollio/web/dashboard/widget/sidebar_list_view.dart';
import '../../../custom_view/custom_horizontal_pager.dart';
import '../../../utils/color_file.dart';
import '../../../utils/common.dart';

class PrimarySideBar extends StatelessWidget {
  const PrimarySideBar(
      {super.key,
      required this.mList,
      required this.selectedPagerModel,
      required this.selectedModelCallBack});

  final RxList<PagerModel> mList;
  final Rx<PagerModel> selectedPagerModel;
  final ValueChanged<PagerModel> selectedModelCallBack;

  @override
  Widget build(BuildContext context) {
    Common().setScreenUtilDesignSize(context);
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 340.w,
        ),
        decoration: const BoxDecoration(
            color: ColorFile.whiteColor,

        ),
        width: 340.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:   PrimarySideBarListView(
                mList: mList,
                selectedPagerModel: selectedPagerModel,
                selectedModelCallBack: selectedModelCallBack,
              )
            ),
          ],
        ),
      ),
    );
  }
}
