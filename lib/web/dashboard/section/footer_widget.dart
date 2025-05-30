import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../custom_view/custom_horizontal_pager.dart';
import '../../../model/social_media_model.dart';
import '../../../utils/color_file.dart';
import '../../../utils/string_file.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
        // Animated Wave divider
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
        )
            .animate(onPlay: (controller) => controller.repeat())
            .fadeIn(duration: 1000.ms, curve: Curves.easeOut)
            .then(delay: 500.ms)
            .fadeOut(duration: 1000.ms)
            .then(delay: 500.ms),

        // Footer content with entrance animation
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
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 500.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .scaleXY(begin: 0.95, end: 1, curve: Curves.easeOut);
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
                  title: StringFile.aboutUS,
                  items: footerAboutList,
                  isLink: true)),
          SizedBox(width: 20.w),
          Expanded(child: _buildSocialMediaSection()),
          SizedBox(width: 20.w),
          Expanded(child: _buildContactSection()),
          SizedBox(width: 20.w),
          Expanded(flex: 2, child: _buildNewsletterSection()),
        ],
      )
          .animate()
          .fadeIn(delay: 200.ms, duration: 500.ms)
          .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
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
              title: StringFile.aboutUS, items: footerAboutList, isLink: true),
          SizedBox(height: 30.h),
          _buildSocialMediaSection(),
          SizedBox(height: 30.h),
          _buildContactSection(),
          SizedBox(height: 30.h),
          _buildNewsletterSection(),
        ],
      )
          .animate()
          .fadeIn(delay: 200.ms, duration: 500.ms)
          .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
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
        )
            .animate()
            .fadeIn(delay: 300.ms)
            .scaleXY(begin: 0.9, end: 1, curve: Curves.easeOutBack),
        SizedBox(height: 12.h),
        Text(
          StringFile.footerDescription,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            height: 1.5,
          ),
        )
            .animate()
            .fadeIn(delay: 400.ms)
            .slideX(begin: -10, end: 0, curve: Curves.easeOut),
        SizedBox(height: 16.h),
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
        ).animate().fadeIn(delay: 300.ms).scaleXY(begin: 0.95, end: 1),
        SizedBox(height: 16.h),
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _AnimatedLinkItem(
                item: item,
                isLink: isLink,
                isSelected: item == selectedFooterAboutItem,
                onTap: () => isLink ? onTapAbout(item) : null,
                footerAboutList: footerAboutList,
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
        ).animate().fadeIn(delay: 300.ms).scaleXY(begin: 0.95, end: 1),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: footerFollowUsList
              .map((item) => _AnimatedSocialMediaItem(
                    item: item,
                    onTap: () => onTapFollowUS(item),
                    isSelected: item == selectedFooterFollowUsItem,
                    footerFollowUsList: footerFollowUsList,
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
        ).animate().fadeIn(delay: 300.ms).scaleXY(begin: 0.95, end: 1),
        SizedBox(height: 16.h),
        ...contactUsList.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _AnimatedContactItem(
                item: item,
                onTap: () => onTapContactUS(item),
                isSelected: item == selectedFooterContactUsItem,
                contactUsList: contactUsList,
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
        ).animate().fadeIn(delay: 300.ms).scaleXY(begin: 0.95, end: 1),
        SizedBox(height: 16.h),
        Text(
          StringFile.subscriberToOurNewsLatter,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        )
            .animate()
            .fadeIn(delay: 400.ms)
            .slideX(begin: 10, end: 0, curve: Curves.easeOut),
        SizedBox(height: 16.h),
        _AnimatedEmailField(),
      ],
    );
  }
}

class _AnimatedLinkItem extends StatefulWidget {
  final PagerModel item;
  final bool isLink;
  final bool isSelected;
  final VoidCallback onTap;
  final List<PagerModel> footerAboutList;

  const _AnimatedLinkItem({
    required this.item,
    required this.isLink,
    required this.isSelected,
    required this.onTap,
    required this.footerAboutList,
  });

  @override
  State<_AnimatedLinkItem> createState() => _AnimatedLinkItemState();
}

class _AnimatedLinkItemState extends State<_AnimatedLinkItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: AnimatedContainer(
          duration: 200.ms,
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: _isHovered
                ? ColorFile.webThemeColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isSelected || _isHovered)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: ColorFile.webThemeColor,
                ).animate().fadeIn(duration: 200.ms).slideX(begin: -5, end: 0)
              else
                SizedBox(width: 12.sp),
              SizedBox(width: 8.w),
              Text(
                widget.item.displayText!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: widget.isSelected || _isHovered
                      ? ColorFile.webThemeColor
                      : Colors.grey[700],
                  fontWeight: widget.isSelected || _isHovered
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: (100 * widget.footerAboutList.indexOf(widget.item)).ms)
        .fadeIn(duration: 300.ms)
        .slideX(begin: 10, end: 0, curve: Curves.easeOut);
  }
}

class _AnimatedSocialMediaItem extends StatefulWidget {
  final SocialMediaModel item;
  final VoidCallback onTap;
  final bool isSelected;
  final List<SocialMediaModel> footerFollowUsList;

  const _AnimatedSocialMediaItem({
    required this.item,
    required this.onTap,
    required this.isSelected,
    required this.footerFollowUsList,
  });

  @override
  State<_AnimatedSocialMediaItem> createState() =>
      _AnimatedSocialMediaItemState();
}

class _AnimatedSocialMediaItemState extends State<_AnimatedSocialMediaItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: 300.ms,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: _isHovered
                ? ColorFile.webThemeColor.withOpacity(0.2)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: ColorFile.webThemeColor.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: _isHovered ? 1.2 : 1.0,
                duration: 200.ms,
                child: SvgPicture.asset(
                  widget.item.svgPath!,
                  height: 16.h,
                  width: 16.w,
                  colorFilter: ColorFilter.mode(
                    _isHovered || widget.isSelected
                        ? ColorFile.webThemeColor
                        : ColorFile.grayColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              AnimatedOpacity(
                opacity: _isHovered ? 1 : 0.8,
                duration: 200.ms,
                child: Text(
                  widget.item.displayText!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: _isHovered || widget.isSelected
                        ? ColorFile.webThemeColor
                        : Colors.grey[700],
                    fontWeight: _isHovered || widget.isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(
            delay: (100 * widget.footerFollowUsList.indexOf(widget.item)).ms)
        .fadeIn(duration: 300.ms)
        .slideY(begin: 10, end: 0, curve: Curves.easeOut);
  }
}

class _AnimatedContactItem extends StatefulWidget {
  final SocialMediaModel item;
  final VoidCallback onTap;
  final bool isSelected;
  final List<SocialMediaModel> contactUsList;

  const _AnimatedContactItem({
    required this.item,
    required this.onTap,
    required this.isSelected, required this.contactUsList,
  });

  @override
  State<_AnimatedContactItem> createState() => _AnimatedContactItemState();
}

class _AnimatedContactItemState extends State<_AnimatedContactItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: 300.ms,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: _isHovered
                ? ColorFile.webThemeColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: 200.ms,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: _isHovered || widget.isSelected
                      ? ColorFile.webThemeColor.withOpacity(0.2)
                      : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  widget.item.svgPath!,
                  height: 16.h,
                  width: 16.w,
                  colorFilter: ColorFilter.mode(
                    _isHovered || widget.isSelected
                        ? ColorFile.webThemeColor
                        : ColorFile.grayColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: 200.ms,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: _isHovered || widget.isSelected
                        ? ColorFile.webThemeColor
                        : Colors.grey[700],
                    fontWeight: _isHovered || widget.isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  child: Text(
                    widget.item.displayText!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: (100 * widget.contactUsList.indexOf(widget.item)).ms)
        .fadeIn(duration: 300.ms)
        .slideX(begin: 10, end: 0, curve: Curves.easeOut);
  }
}

class _AnimatedEmailField extends StatefulWidget {
  @override
  State<_AnimatedEmailField> createState() => _AnimatedEmailFieldState();
}

class _AnimatedEmailFieldState extends State<_AnimatedEmailField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _hasFocus = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 300.ms,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: _hasFocus
            ? [
                BoxShadow(
                  color: ColorFile.webThemeColor.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ]
            : null,
      ),
      child: TextField(
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: StringFile.yourEmail,
          hintStyle: TextStyle(fontSize: 14.sp),
          suffixIcon: AnimatedRotation(
            duration: 300.ms,
            turns: _hasFocus ? 0.1 : 0,
            child: IconButton(
              icon: Icon(Icons.send, color: ColorFile.webThemeColor),
              onPressed: () {},
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: _hasFocus ? ColorFile.webThemeColor : Colors.grey[300]!,
              width: _hasFocus ? 1.5 : 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: ColorFile.webThemeColor,
              width: 1.5,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: 500.ms)
        .scaleXY(begin: 0.95, end: 1, curve: Curves.easeOutBack);
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

// class FooterWidget extends StatelessWidget {
//   const FooterWidget({
//     super.key,
//     required this.footerAboutList,
//     this.selectedFooterAboutItem,
//     required this.onTapAbout,
//     required this.footerFollowUsList,
//     this.selectedFooterFollowUsItem,
//     required this.onTapFollowUS,
//     required this.padding,
//     required this.contactUsList,
//     this.selectedFooterContactUsItem,
//     required this.onTapContactUS,
//   });
//
//   final List<PagerModel> footerAboutList;
//   final PagerModel? selectedFooterAboutItem;
//   final Function(PagerModel) onTapAbout;
//   final List<SocialMediaModel> footerFollowUsList;
//   final SocialMediaModel? selectedFooterFollowUsItem;
//   final Function(SocialMediaModel) onTapFollowUS;
//   final List<SocialMediaModel> contactUsList;
//   final SocialMediaModel? selectedFooterContactUsItem;
//   final Function(SocialMediaModel) onTapContactUS;
//   final EdgeInsetsGeometry padding;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Wave divider
//         ClipPath(
//           clipper: _WaveClipper(),
//           child: Container(
//             height: 60.h,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   ColorFile.webThemeColor.withOpacity(0.3),
//                   ColorFile.webThemeColor.withOpacity(0.1),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//         ),
//
//         // Footer content
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
//           color: Theme.of(context).cardColor,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               LayoutBuilder(
//                 builder: (context, constraints) {
//                   if (constraints.maxWidth > 600) {
//                     return _buildWebLayout();
//                   } else {
//                     return _buildMobileLayout();
//                   }
//                 },
//               ),
//               SizedBox(height: 20.h),
//               const Divider(height: 1),
//               Padding(
//                 padding: EdgeInsets.all(12.sp),
//                 child: Center(
//                   child: Text(
//                     '© ${DateTime.now().year} ${StringFile.allRightReserved}',
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                           color: Colors.grey[600],
//                         ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildWebLayout() {
//     return Padding(
//       padding: padding,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(flex: 2, child: _buildBrandSection()),
//           SizedBox(width: 20.w),
//           Expanded(
//               child: _buildLinksSection(
//                   title: StringFile.aboutUS, items: footerAboutList, isLink: true)),
//           SizedBox(width: 20.w),
//           Expanded(child: _buildSocialMediaSection()),
//           SizedBox(width: 20.w),
//           Expanded(child: _buildContactSection()),
//           SizedBox(width: 20.w),
//           Expanded(flex: 2, child: _buildNewsletterSection()),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout() {
//     return Padding(
//       padding: padding,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildBrandSection(),
//           SizedBox(height: 30.h),
//           _buildLinksSection(
//               title:  StringFile.aboutUS, items: footerAboutList, isLink: true),
//           SizedBox(height: 30.h),
//           _buildSocialMediaSection(),
//           SizedBox(height: 30.h),
//           _buildContactSection(),
//           SizedBox(height: 30.h),
//           _buildNewsletterSection(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBrandSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           StringFile.footerTitle,
//           style: TextStyle(
//             fontSize: 22.sp,
//             fontWeight: FontWeight.bold,
//             color: ColorFile.webThemeColor,
//           ),
//         ),
//         SizedBox(height: 12.h),
//         Text(
//           StringFile.footerDescription,
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: Colors.grey[600],
//             height: 1.5,
//           ),
//         ),
//         SizedBox(height: 16.h),
//         // Social media icons could go here if you want them in the brand section
//       ],
//     );
//   }
//
//   Widget _buildLinksSection({
//     required String title,
//     required List<PagerModel> items,
//     bool isLink = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         SizedBox(height: 16.h),
//         ...items.map((item) => Padding(
//               padding: EdgeInsets.only(bottom: 8.h),
//               child: InkWell(
//                 onTap: () => isLink ? onTapAbout(item) : null,
//                 hoverColor: Colors.transparent,
//                 splashColor: Colors.transparent,
//                 child: Text(
//                   item.displayText!,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: isLink && item == selectedFooterAboutItem
//                         ? ColorFile.webThemeColor
//                         : Colors.grey[700],
//                     fontWeight: isLink && item == selectedFooterAboutItem
//                         ? FontWeight.w600
//                         : FontWeight.normal,
//                   ),
//                 ),
//               ),
//             )),
//       ],
//     );
//   }
//
//   Widget _buildSocialMediaSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           StringFile.followUs,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         SizedBox(height: 16.h),
//         Wrap(
//           spacing: 12.w,
//           runSpacing: 12.h,
//           children: footerFollowUsList
//               .map((item) => InkWell(
//                     onTap: () => onTapFollowUS(item),
//                     borderRadius: BorderRadius.circular(8),
//                     child: Container(
//                       padding: EdgeInsets.all(8.w),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SvgPicture.asset(
//                             item.svgPath!,
//                             height: 16.h,
//                             width: 16.w,
//                             colorFilter: ColorFilter.mode(
//                               ColorFile.webThemeColor,
//                               BlendMode.srcIn,
//                             ),
//                           ),
//                           SizedBox(width: 8.w),
//                           Text(
//                             item.displayText!,
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContactSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           StringFile.contactUs,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         SizedBox(height: 16.h),
//         ...contactUsList.map((item) => Padding(
//               padding: EdgeInsets.only(bottom: 12.h),
//               child: InkWell(
//                 onTap: () => onTapContactUS(item),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SvgPicture.asset(
//                       item.svgPath!,
//                       height: 16.h,
//                       width: 16.w,
//                       colorFilter: ColorFilter.mode(
//                         ColorFile.webThemeColor,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     SizedBox(width: 8.w),
//                     Expanded(
//                       child: Text(
//                         item.displayText!,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//       ],
//     );
//   }
//
//   Widget _buildNewsletterSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           StringFile.newsletter,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         SizedBox(height: 16.h),
//         Text(
//           StringFile.subscriberToOurNewsLatter,
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: Colors.grey[600],
//           ),
//         ),
//         SizedBox(height: 16.h),
//         TextField(
//           decoration: InputDecoration(
//             hintText: StringFile.yourEmail,
//             hintStyle: TextStyle(fontSize: 14.sp),
//             suffixIcon: IconButton(
//               icon: Icon(Icons.send, color: ColorFile.webThemeColor),
//               onPressed: () {},
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 16.w,
//               vertical: 12.h,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, size.height - 40);
//
//     final firstControlPoint = Offset(size.width / 4, size.height);
//     final firstEndPoint = Offset(size.width / 2, size.height - 30);
//     path.quadraticBezierTo(
//       firstControlPoint.dx,
//       firstControlPoint.dy,
//       firstEndPoint.dx,
//       firstEndPoint.dy,
//     );
//
//     final secondControlPoint = Offset(size.width * 3 / 4, size.height - 60);
//     final secondEndPoint = Offset(size.width, size.height - 30);
//     path.quadraticBezierTo(
//       secondControlPoint.dx,
//       secondControlPoint.dy,
//       secondEndPoint.dx,
//       secondEndPoint.dy,
//     );
//
//     path.lineTo(size.width, size.height - 40);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
