import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomImage extends StatelessWidget {
  final String imgUrl;
  final double widthSize;
  final double heightSize;
  final String? emptyImgUrl;

  const CustomImage(this.imgUrl, this.widthSize, this.heightSize, {this.emptyImgUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imgUrl.isNotEmpty) {
      return imgUrl.contains(".svg")
          ? SvgPicture.network(imgUrl, width: widthSize.w, height: heightSize.w)
          : Image.network(
              imgUrl,
              width: widthSize.w,
              height: heightSize.w,
            );
    } else {
      if (emptyImgUrl != null) {
        return emptyImgUrl!.contains(".svg")
            ? SvgPicture.asset(emptyImgUrl!, width: widthSize.w, height: heightSize.w)
            : Image.asset(
                emptyImgUrl!,
                width: widthSize.w,
                height: heightSize.w,
              );
      } else {
        return const SizedBox.shrink();
      }
    }
  }
}
