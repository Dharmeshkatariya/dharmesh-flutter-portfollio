import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../custom_view/custom_horizontal_pager.dart';
import '../../../model/social_media_model.dart';
import '../../../utils/color_file.dart';
import '../../../utils/string_file.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
    required this.footerAboutList,
    this.selectedFooterAboutItem,
    required this.onTapAbout,
    required this.footerFollowUsList,
    this.selectedFooterFollowUsItem,
    required this.onTapFollowUS,
    required this.padding,
    required this.contactUsList,
    this.selectedFooterContactUsItem,
    required this.onTapContactUS,
  });

  final List<PagerModel> footerAboutList;
  final PagerModel? selectedFooterAboutItem;
  final Function(PagerModel) onTapAbout;
  final List<SocialMediaModel> footerFollowUsList;
  final SocialMediaModel? selectedFooterFollowUsItem;
  final Function(SocialMediaModel) onTapFollowUS;
  final List<SocialMediaModel> contactUsList;
  final SocialMediaModel? selectedFooterContactUsItem;
  final Function(SocialMediaModel) onTapContactUS;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Wave divider
        ClipPath(
          clipper: _WaveClipper(),
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorFile.webThemeColor.withOpacity(0.3),
                  ColorFile.webThemeColor.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // Footer content
        Container(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return _buildWebLayout();
                  } else {
                    return _buildMobileLayout();
                  }
                },
              ),
              SizedBox(height: 20.h),
              const Divider(height: 1),
              Padding(
                padding: EdgeInsets.all(12.sp),
                child: Center(
                  child: Text(
                    '© ${DateTime.now().year} ${StringFile.allRightReserved}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWebLayout() {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: _buildBrandSection()),
          SizedBox(width: 20.w),
          Expanded(
              child: _buildLinksSection(
                  title: StringFile.aboutUS, items: footerAboutList, isLink: true)),
          SizedBox(width: 20.w),
          Expanded(child: _buildSocialMediaSection()),
          SizedBox(width: 20.w),
          Expanded(child: _buildContactSection()),
          SizedBox(width: 20.w),
          Expanded(flex: 2, child: _buildNewsletterSection()),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBrandSection(),
          SizedBox(height: 30.h),
          _buildLinksSection(
              title:  StringFile.aboutUS, items: footerAboutList, isLink: true),
          SizedBox(height: 30.h),
          _buildSocialMediaSection(),
          SizedBox(height: 30.h),
          _buildContactSection(),
          SizedBox(height: 30.h),
          _buildNewsletterSection(),
        ],
      ),
    );
  }

  Widget _buildBrandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringFile.footerTitle,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: ColorFile.webThemeColor,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          StringFile.footerDescription,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.h),
        // Social media icons could go here if you want them in the brand section
      ],
    );
  }

  Widget _buildLinksSection({
    required String title,
    required List<PagerModel> items,
    bool isLink = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: InkWell(
                onTap: () => isLink ? onTapAbout(item) : null,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Text(
                  item.displayText!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isLink && item == selectedFooterAboutItem
                        ? ColorFile.webThemeColor
                        : Colors.grey[700],
                    fontWeight: isLink && item == selectedFooterAboutItem
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildSocialMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringFile.followUs,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: footerFollowUsList
              .map((item) => InkWell(
                    onTap: () => onTapFollowUS(item),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            item.svgPath!,
                            height: 16.h,
                            width: 16.w,
                            colorFilter: ColorFilter.mode(
                              ColorFile.webThemeColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            item.displayText!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringFile.contactUs,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        ...contactUsList.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: InkWell(
                onTap: () => onTapContactUS(item),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      item.svgPath!,
                      height: 16.h,
                      width: 16.w,
                      colorFilter: ColorFilter.mode(
                        ColorFile.webThemeColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        item.displayText!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildNewsletterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringFile.newsletter,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          StringFile.subscriberToOurNewsLatter,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 16.h),
        TextField(
          decoration: InputDecoration(
            hintText: StringFile.yourEmail,
            hintStyle: TextStyle(fontSize: 14.sp),
            suffixIcon: IconButton(
              icon: Icon(Icons.send, color: ColorFile.webThemeColor),
              onPressed: () {},
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);

    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 3 / 4, size.height - 60);
    final secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
