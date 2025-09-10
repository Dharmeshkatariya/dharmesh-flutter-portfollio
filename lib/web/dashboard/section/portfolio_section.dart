import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dharmesh_portfollio/utils/color_file.dart';
import 'package:dharmesh_portfollio/utils/string_file.dart';
import '../../../model/portfolio_model.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dharmesh_portfollio/utils/color_file.dart';
import 'package:dharmesh_portfollio/utils/string_file.dart';
import '../../../model/portfolio_model.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dharmesh_portfollio/utils/color_file.dart';
import 'package:dharmesh_portfollio/utils/string_file.dart';
import '../../../model/portfolio_model.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dharmesh_portfollio/utils/color_file.dart';
import 'package:dharmesh_portfollio/utils/string_file.dart';
import '../../../model/portfolio_model.dart';

class CategoryTabModel {
  String category;
  Color selectedColor;
  IconData icon;

  CategoryTabModel({
    required this.category,
    required this.selectedColor,
    required this.icon,
  });
}

class PortfolioSection extends StatefulWidget {
  final List<PortfolioModel> portfolioList;
  final EdgeInsetsGeometry horizontalPadding;

  const PortfolioSection({
    super.key,
    required this.portfolioList,
    required this.horizontalPadding,
  });

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  List<PortfolioModel> get _filteredItems {
    if (_selectedCategory.category == 'All') return widget.portfolioList;
    return widget.portfolioList
        .where((item) => item.category == _selectedCategory.category)
        .toList();
  }

  late CategoryTabModel _selectedCategory;
  late List<CategoryTabModel> _categories;

  @override
  void initState() {
    super.initState();
    _categories = [
      CategoryTabModel(
        category: StringFile.all,
        selectedColor: Colors.blue,
        icon: Icons.all_inclusive,
      ),
      CategoryTabModel(
        category: StringFile.web,
        selectedColor: Colors.purple,
        icon: Icons.web,
      ),
      CategoryTabModel(
        category: StringFile.mobile,
        selectedColor: Colors.green,
        icon: Icons.phone_android,
      ),
      CategoryTabModel(
        category: StringFile.design,
        selectedColor: Colors.orange,
        icon: Icons.design_services,
      ),
    ];
    _selectedCategory = _categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 60.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey[50]!,
            Colors.grey[100]!,
          ],
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 40.h),
          _buildCategoryTabs(),
          SizedBox(height: 40.h),
          _buildPortfolioGrid(),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildHeader() {
    return Column(
      children: [
        ElasticIn(
          duration: 1000.ms,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'My ',
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: 'Portfolio',
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: 80.w,
          height: 4.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlue],
            ),
            borderRadius: BorderRadius.circular(2.r),
          ),
        )
            .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        )
            .fadeIn(duration: 1000.ms)
            .then(delay: 500.ms)
            .fadeOut(duration: 1000.ms)
            .then(delay: 500.ms),
        SizedBox(height: 20.h),
        SizedBox(
          width: 600.w,
          child: FadeInUp(
            duration: 1000.ms,
            child: Text(
              'Explore my creative journey through various projects. Each piece tells a story of innovation, design, and technical excellence.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black54,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return FadeInUp(
      duration: 800.ms,
      child: Container(
        height: 60.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            return _buildCategoryTabItem(_categories[index])
                .animate()
                .fadeIn(delay: (index * 200).ms)
                .slideX(
              begin: 0.2,
              end: 0,
              duration: 600.ms,
              curve: Curves.easeOutBack,
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryTabItem(CategoryTabModel category) {
    final isSelected = _selectedCategory.category == category.category;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = category;
          });
        },
        borderRadius: BorderRadius.circular(25.r),
        child: AnimatedContainer(
          duration: 300.ms,
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? category.selectedColor : Colors.transparent,
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(
              color: isSelected ? category.selectedColor : Colors.grey[300]!,
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: category.selectedColor.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 3),
              )
            ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                category.icon,
                size: 16.w,
                color: isSelected ? Colors.white : category.selectedColor,
              ),
              SizedBox(width: 8.w),
              Text(
                category.category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioGrid() {
    if (_filteredItems.isEmpty) {
      return _buildEmptyState();
    }

    return FadeInUp(
        duration: 800.ms,
        child: Container(
          padding: widget.horizontalPadding,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              crossAxisSpacing: 25.w,
              mainAxisSpacing: 25.h,
              childAspectRatio: _getChildAspectRatio(context),
            ),
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              return _PortfolioItemCard(
                item: _filteredItems[index],
                categoryColor: _getCategoryColor(_filteredItems[index].category),
              )
                  .animate()
                  .fadeIn(delay: (index * 150).ms)
                  .slideY(
                begin: 0.2,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOutBack,
              );
            },
          ),
        )
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 60.w, color: Colors.grey[400]),
          SizedBox(height: 20.h),
          Text(
            'No projects found in this category',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Try selecting a different category',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 3;
    if (width > 800) return 2;
    return 1;
  }

  double _getChildAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 0.85;
    if (width > 800) return 0.75;
    return 0.75;
  }

  Color _getCategoryColor(String? category) {
    final foundCategory = _categories.firstWhere(
          (c) => c.category == category,
      orElse: () => _categories.first,
    );
    return foundCategory.selectedColor;
  }
}

class _PortfolioItemCard extends StatefulWidget {
  final PortfolioModel item;
  final Color categoryColor;

  const _PortfolioItemCard({
    required this.item,
    required this.categoryColor,
  });

  @override
  State<_PortfolioItemCard> createState() => _PortfolioItemCardState();
}

class _PortfolioItemCardState extends State<_PortfolioItemCard> {
  bool _isHovered = false;
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isTapped = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isTapped = true),
        onTapUp: (_) => setState(() => _isTapped = false),
        onTapCancel: () => setState(() => _isTapped = false),
        child: AnimatedContainer(
          duration: 300.ms,
          curve: Curves.easeOutQuint,
          transform: Matrix4.identity()
            ..scale(_isHovered ? 1.03 : 1.0)
            ..translate(0.0, _isHovered ? -8.0 : 0.0, 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.05),
                blurRadius: _isHovered ? 30 : 15,
                spreadRadius: _isHovered ? -5 : 0,
                offset: Offset(0, _isHovered ? 15 : 8),
              )
            ],
            border: Border.all(
              color: Colors.grey.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSection(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.w),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Category Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title with proper overflow handling
                                      Container(
                                        constraints: BoxConstraints(
                                          maxHeight: 45.h,
                                        ),
                                        child: FadeInLeft(
                                          duration: 500.ms,
                                          child: Text(
                                            widget.item.title ?? '',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black87,
                                              height: 1.2,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      FadeInLeft(
                                        duration: 600.ms,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 4.h),
                                          decoration: BoxDecoration(
                                            color: widget.categoryColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12.r),
                                          ),
                                          child: Text(
                                            widget.item.category ?? '',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: widget.categoryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Expand/Collapse Icon
                                Obx(() => FlipInX(
                                  duration: 300.ms,
                                  child: IconButton(
                                    icon: Icon(
                                      widget.item.isMoreExpanded.value
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: Colors.grey[600],
                                      size: 22.w,
                                    ),
                                    onPressed: () {
                                      widget.item.isMoreExpanded.toggle();
                                    },
                                    splashRadius: 20,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(height: 12.h),

                            // Enhanced Tags Section
                            if (widget.item.tags != null && widget.item.tags!.isNotEmpty)
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: 40.h,
                                ),
                                child: SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Wrap(
                                    spacing: 6.w,
                                    runSpacing: 6.h,
                                    children: widget.item.tags!
                                        .map((tag) => FadeInUp(
                                      delay: (widget.item.tags!.indexOf(tag) * 100).ms,
                                      duration: 500.ms,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 6.h),
                                        decoration: BoxDecoration(
                                          color: widget.categoryColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: widget.categoryColor.withOpacity(0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          tag,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: widget.categoryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                  ),
                                ),
                              ),

                            SizedBox(height: 12.h),

                            // Expandable Description - FIXED OVERFLOW
                            Obx(() => AnimatedCrossFade(
                              duration: const Duration(milliseconds: 300),
                              crossFadeState: widget.item.isMoreExpanded.value
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: SizedBox(height: 8.h),
                              secondChild: FadeInUp(
                                duration: 300.ms,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxHeight: constraints.maxHeight * 0.4,
                                  ),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      widget.item.description ?? '',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey[700],
                                        height: 1.5,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),

                            Spacer(),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: _buildActionButton(),
                                ),
                                SizedBox(width: 12.w),
                                if (widget.item.siteUrl != null &&
                                    widget.item.siteUrl!.isNotEmpty)
                                  FadeInRight(
                                    duration: 800.ms,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10.r),
                                      onTap: () async {
                                        final Uri url = Uri.parse(widget.item.siteUrl!);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(
                                            url,
                                            mode: LaunchMode.externalApplication,
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 12.h),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.open_in_new,
                                          size: 20.w,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return AnimatedContainer(
      duration: 200.ms,
      decoration: BoxDecoration(
        color: _isTapped
            ? widget.categoryColor.withOpacity(0.9)
            : widget.categoryColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: _isHovered
            ? [
          BoxShadow(
            color: widget.categoryColor.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          )
        ]
            : null,
      ),
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Center(
        child: Text(
          widget.item.buttonText ?? 'VIEW PROJECT',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              widget.item.imagePath ?? 'assets/images/placeholder.png',
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                child: Icon(Icons.image, size: 40.w, color: Colors.grey[400]),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
                stops: const [0.4, 1],
              ),
            ),
          ),
        ),

        // Category Badge
        Positioned(
          top: 16,
          right: 16,
          child: AnimatedContainer(
            duration: 300.ms,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: widget.categoryColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getCategoryIcon(widget.item.category),
                  size: 12.w,
                  color: Colors.white,
                ),
                SizedBox(width: 4.w),
                Text(
                  widget.item.category ?? '',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),

        // Featured Badge
        if (widget.item.isFeatured ?? false)
          Positioned(
            top: 16,
            left: 0,
            child: Swing(
              infinite: true,
              duration: 2000.ms,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.amber[600],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, size: 14.w, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text(
                      'FEATURED',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Hover Effect
        if (_isHovered)
          Positioned.fill(
            child: FadeIn(
              duration: 300.ms,
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: Center(
                  child: JelloIn(
                    duration: 1000.ms,
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.zoom_in,
                        size: 28.w,
                        color: widget.categoryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  IconData _getCategoryIcon(String? category) {
    switch (category) {
      case 'Mobile':
        return Icons.phone_android;
      case 'Web':
        return Icons.web;
      case 'Design':
        return Icons.design_services;
      default:
        return Icons.work;
    }
  }
}

// class CategoryTabModel {
//   String category;
//   Color selectedColor;
//   IconData icon;
//
//   CategoryTabModel({
//     required this.category,
//     required this.selectedColor,
//     required this.icon,
//   });
// }
//
// class PortfolioSection extends StatefulWidget {
//   final List<PortfolioModel> portfolioList;
//   final EdgeInsetsGeometry horizontalPadding;
//
//   const PortfolioSection({
//     super.key,
//     required this.portfolioList,
//     required this.horizontalPadding,
//   });
//
//   @override
//   State<PortfolioSection> createState() => _PortfolioSectionState();
// }
//
// class _PortfolioSectionState extends State<PortfolioSection> {
//   List<PortfolioModel> get _filteredItems {
//     if (_selectedCategory.category == 'All') return widget.portfolioList;
//     return widget.portfolioList
//         .where((item) => item.category == _selectedCategory.category)
//         .toList();
//   }
//
//   late CategoryTabModel _selectedCategory;
//   late List<CategoryTabModel> _categories;
//
//   @override
//   void initState() {
//     super.initState();
//     _categories = [
//       CategoryTabModel(
//         category: StringFile.all,
//         selectedColor: Colors.blue,
//         icon: Icons.all_inclusive,
//       ),
//       CategoryTabModel(
//         category: StringFile.web,
//         selectedColor: Colors.purple,
//         icon: Icons.web,
//       ),
//       CategoryTabModel(
//         category: StringFile.mobile,
//         selectedColor: Colors.green,
//         icon: Icons.phone_android,
//       ),
//       CategoryTabModel(
//         category: StringFile.design,
//         selectedColor: Colors.orange,
//         icon: Icons.design_services,
//       ),
//     ];
//     _selectedCategory = _categories.first;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(vertical: 60.h),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Colors.grey[50]!,
//             Colors.grey[100]!,
//           ],
//         ),
//       ),
//       child: Column(
//         children: [
//           _buildHeader(),
//           SizedBox(height: 40.h),
//           _buildCategoryTabs(),
//           SizedBox(height: 40.h),
//           _buildPortfolioGrid(),
//         ],
//       ),
//     ).animate().fadeIn(duration: 500.ms);
//   }
//
//   Widget _buildHeader() {
//     return Column(
//       children: [
//         ElasticIn(
//           duration: 1000.ms,
//           child: RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'My ',
//                   style: TextStyle(
//                     fontSize: 36.sp,
//                     fontWeight: FontWeight.w800,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 TextSpan(
//                   text: 'Portfolio',
//                   style: TextStyle(
//                     fontSize: 36.sp,
//                     fontWeight: FontWeight.w800,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 16.h),
//         Container(
//           width: 80.w,
//           height: 4.h,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue, Colors.lightBlue],
//             ),
//             borderRadius: BorderRadius.circular(2.r),
//           ),
//         )
//             .animate(
//           onPlay: (controller) => controller.repeat(reverse: true),
//         )
//             .fadeIn(duration: 1000.ms)
//             .then(delay: 500.ms)
//             .fadeOut(duration: 1000.ms)
//             .then(delay: 500.ms),
//         SizedBox(height: 20.h),
//         SizedBox(
//           width: 600.w,
//           child: FadeInUp(
//             duration: 1000.ms,
//             child: Text(
//               'Explore my creative journey through various projects. Each piece tells a story of innovation, design, and technical excellence.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: Colors.black54,
//                 height: 1.6,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCategoryTabs() {
//     return FadeInUp(
//       duration: 800.ms,
//       child: Container(
//         height: 60.h,
//         margin: EdgeInsets.symmetric(horizontal: 20.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 15,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemCount: _categories.length,
//           itemBuilder: (context, index) {
//             return _buildCategoryTabItem(_categories[index])
//                 .animate()
//                 .fadeIn(delay: (index * 200).ms)
//                 .slideX(
//               begin: 0.2,
//               end: 0,
//               duration: 600.ms,
//               curve: Curves.easeOutBack,
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategoryTabItem(CategoryTabModel category) {
//     final isSelected = _selectedCategory.category == category.category;
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//       child: InkWell(
//         onTap: () {
//           setState(() {
//             _selectedCategory = category;
//           });
//         },
//         borderRadius: BorderRadius.circular(25.r),
//         child: AnimatedContainer(
//           duration: 300.ms,
//           curve: Curves.easeInOut,
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
//           decoration: BoxDecoration(
//             color: isSelected ? category.selectedColor : Colors.transparent,
//             borderRadius: BorderRadius.circular(25.r),
//             border: Border.all(
//               color: isSelected ? category.selectedColor : Colors.grey[300]!,
//               width: 1.5,
//             ),
//             boxShadow: isSelected
//                 ? [
//               BoxShadow(
//                 color: category.selectedColor.withOpacity(0.3),
//                 blurRadius: 10,
//                 spreadRadius: 2,
//                 offset: Offset(0, 3),
//               )
//             ]
//                 : null,
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 category.icon,
//                 size: 16.w,
//                 color: isSelected ? Colors.white : category.selectedColor,
//               ),
//               SizedBox(width: 8.w),
//               Text(
//                 category.category,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.black87,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14.sp,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPortfolioGrid() {
//     if (_filteredItems.isEmpty) {
//       return _buildEmptyState();
//     }
//
//     return FadeInUp(
//       duration: 800.ms,
//       child: Container(
//         padding: widget.horizontalPadding,
//         child: GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: _getCrossAxisCount(context),
//             crossAxisSpacing: 25.w,
//             mainAxisSpacing: 25.h,
//             childAspectRatio: _getChildAspectRatio(context),
//           ),
//           itemCount: _filteredItems.length,
//           itemBuilder: (context, index) {
//             return _PortfolioItemCard(
//               item: _filteredItems[index],
//               categoryColor: _getCategoryColor(_filteredItems[index].category),
//             )
//                 .animate()
//                 .fadeIn(delay: (index * 150).ms)
//                 .slideY(
//               begin: 0.2,
//               end: 0,
//               duration: 800.ms,
//               curve: Curves.easeOutBack,
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Container(
//       height: 200.h,
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.search_off, size: 60.w, color: Colors.grey[400]),
//           SizedBox(height: 20.h),
//           Text(
//             'No projects found in this category',
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 10.h),
//           Text(
//             'Try selecting a different category',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.grey[500],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   int _getCrossAxisCount(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     if (width > 1200) return 3;
//     if (width > 800) return 2;
//     return 1;
//   }
//
//   double _getChildAspectRatio(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     if (width > 1200) return 0.85;
//     if (width > 800) return 0.8;
//     return 0.75;
//   }
//
//   Color _getCategoryColor(String? category) {
//     final foundCategory = _categories.firstWhere(
//           (c) => c.category == category,
//       orElse: () => _categories.first,
//     );
//     return foundCategory.selectedColor;
//   }
// }
//
// class _PortfolioItemCard extends StatefulWidget {
//   final PortfolioModel item;
//   final Color categoryColor;
//
//   const _PortfolioItemCard({
//     required this.item,
//     required this.categoryColor,
//   });
//
//   @override
//   State<_PortfolioItemCard> createState() => _PortfolioItemCardState();
// }
//
// class _PortfolioItemCardState extends State<_PortfolioItemCard> {
//   bool _isHovered = false;
//   bool _isTapped = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() {
//         _isHovered = false;
//         _isTapped = false;
//       }),
//       child: GestureDetector(
//         onTapDown: (_) => setState(() => _isTapped = true),
//         onTapUp: (_) => setState(() => _isTapped = false),
//         onTapCancel: () => setState(() => _isTapped = false),
//         child: AnimatedContainer(
//           duration: 300.ms,
//           curve: Curves.easeOutQuint,
//           transform: Matrix4.identity()
//             ..scale(_isHovered ? 1.03 : 1.0)
//             ..translate(0.0, _isHovered ? -8.0 : 0.0, 0.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.r),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.05),
//                 blurRadius: _isHovered ? 30 : 15,
//                 spreadRadius: _isHovered ? -5 : 0,
//                 offset: Offset(0, _isHovered ? 15 : 8),
//               )
//             ],
//             border: Border.all(
//               color: Colors.grey.withOpacity(0.1),
//               width: 1,
//             ),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20.r),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildImageSection(),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.all(15.w),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Title and Category Row
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Title with proper overflow handling
//                                   Container(
//                                     constraints: BoxConstraints(
//                                       maxHeight: 45.h, // Limit title height
//                                     ),
//                                     child: FadeInLeft(
//                                       duration: 500.ms,
//                                       child: Text(
//                                         widget.item.title ?? '',
//                                         style: TextStyle(
//                                           fontSize: 18.sp,
//                                           fontWeight: FontWeight.w800,
//                                           color: Colors.black87,
//                                           height: 1.2,
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 6.h),
//                                   FadeInLeft(
//                                     duration: 600.ms,
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 12.w, vertical: 4.h),
//                                       decoration: BoxDecoration(
//                                         color: widget.categoryColor.withOpacity(0.1),
//                                         borderRadius: BorderRadius.circular(12.r),
//                                       ),
//                                       child: Text(
//                                         widget.item.category ?? '',
//                                         style: TextStyle(
//                                           fontSize: 12.sp,
//                                           color: widget.categoryColor,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Expand/Collapse Icon
//                             Obx(() => FlipInX(
//                               duration: 300.ms,
//                               child: IconButton(
//                                 icon: Icon(
//                                   widget.item.isMoreExpanded.value
//                                       ? Icons.expand_less
//                                       : Icons.expand_more,
//                                   color: Colors.grey[600],
//                                   size: 22.w,
//                                 ),
//                                 onPressed: () {
//                                   widget.item.isMoreExpanded.toggle();
//                                 },
//                                 splashRadius: 20,
//                               ),
//                             )),
//                           ],
//                         ),
//                         SizedBox(height: 12.h),
//
//                         // Enhanced Tags Section
//                         if (widget.item.tags != null && widget.item.tags!.isNotEmpty)
//                           Container(
//                             constraints: BoxConstraints(
//                               maxHeight: 40.h, // Limit tags container height
//                             ),
//                             child: SingleChildScrollView(
//                               physics: const NeverScrollableScrollPhysics(),
//                               child: Wrap(
//                                 spacing: 6.w,
//                                 runSpacing: 6.h,
//                                 children: widget.item.tags!
//                                     .map((tag) => FadeInUp(
//                                   delay: (widget.item.tags!.indexOf(tag) * 100).ms,
//                                   duration: 500.ms,
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 10.w, vertical: 6.h),
//                                     decoration: BoxDecoration(
//                                       color: widget.categoryColor.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(8.r),
//                                       border: Border.all(
//                                         color: widget.categoryColor.withOpacity(0.3),
//                                         width: 1,
//                                       ),
//                                     ),
//                                     child: Text(
//                                       tag,
//                                       style: TextStyle(
//                                         fontSize: 10.sp,
//                                         color: widget.categoryColor,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ))
//                                     .toList(),
//                               ),
//                             ),
//                           ),
//
//                         SizedBox(height: 12.h),
//
//                         // Expandable Description
//                         Obx(() => AnimatedCrossFade(
//                           duration: const Duration(milliseconds: 300),
//                           crossFadeState: widget.item.isMoreExpanded.value
//                               ? CrossFadeState.showSecond
//                               : CrossFadeState.showFirst,
//                           firstChild: SizedBox(height: 8.h),
//                           secondChild: FadeInUp(
//                             duration: 300.ms,
//                             child: Container(
//                               constraints: BoxConstraints(
//                                 minHeight: 120.h, // Limit description height
//                               ),
//                               child: SingleChildScrollView(
//                                 physics: const BouncingScrollPhysics(),
//                                 child: Text(
//                                   widget.item.description ?? '',
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontSize: 13.sp,
//                                     color: Colors.grey[700],
//                                     height: 1.5,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )),
//
//                         Spacer(),
//
//                         // Action Buttons
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _buildActionButton(),
//                             ),
//                             SizedBox(width: 12.w),
//                             if (widget.item.siteUrl != null &&
//                                 widget.item.siteUrl!.isNotEmpty)
//                               FadeInRight(
//                                 duration: 800.ms,
//                                 child: InkWell(
//                                   borderRadius: BorderRadius.circular(10.r),
//                                   onTap: () async {
//                                     final Uri url = Uri.parse(widget.item.siteUrl!);
//                                     if (await canLaunchUrl(url)) {
//                                       await launchUrl(
//                                         url,
//                                         mode: LaunchMode.externalApplication,
//                                       );
//                                     }
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 16.w, vertical: 12.h),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[100],
//                                       borderRadius: BorderRadius.circular(10.r),
//                                       border: Border.all(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     child: Icon(
//                                       Icons.open_in_new,
//                                       size: 20.w,
//                                       color: Colors.grey[700],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   return MouseRegion(
//   //     onEnter: (_) => setState(() => _isHovered = true),
//   //     onExit: (_) => setState(() {
//   //       _isHovered = false;
//   //       _isTapped = false;
//   //     }),
//   //     child: GestureDetector(
//   //       onTapDown: (_) => setState(() => _isTapped = true),
//   //       onTapUp: (_) => setState(() => _isTapped = false),
//   //       onTapCancel: () => setState(() => _isTapped = false),
//   //       child: AnimatedContainer(
//   //         duration: 300.ms,
//   //         curve: Curves.easeOutQuint,
//   //         transform: Matrix4.identity()
//   //           ..scale(_isHovered ? 1.03 : 1.0)
//   //           ..translate(0.0, _isHovered ? -8.0 : 0.0, 0.0),
//   //         decoration: BoxDecoration(
//   //           borderRadius: BorderRadius.circular(20.r),
//   //           color: Colors.white,
//   //           boxShadow: [
//   //             BoxShadow(
//   //               color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.05),
//   //               blurRadius: _isHovered ? 30 : 15,
//   //               spreadRadius: _isHovered ? -5 : 0,
//   //               offset: Offset(0, _isHovered ? 15 : 8),
//   //             )
//   //           ],
//   //           border: Border.all(
//   //             color: Colors.grey.withOpacity(0.1),
//   //             width: 1,
//   //           ),
//   //         ),
//   //         child: ClipRRect(
//   //           borderRadius: BorderRadius.circular(20.r),
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               _buildImageSection(),
//   //               Expanded(
//   //                 child: Padding(
//   //                   padding: EdgeInsets.all(15.w),
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       Row(
//   //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                         crossAxisAlignment: CrossAxisAlignment.start,
//   //                         children: [
//   //                           Expanded(
//   //                             child: Column(
//   //                               crossAxisAlignment: CrossAxisAlignment.start,
//   //                               children: [
//   //                                 FadeInLeft(
//   //                                   duration: 500.ms,
//   //                                   child: Text(
//   //                                     widget.item.title ?? '',
//   //                                     style: TextStyle(
//   //                                       fontSize: 18.sp,
//   //                                       fontWeight: FontWeight.w800,
//   //                                       color: Colors.black87,
//   //                                       height: 1.2,
//   //                                     ),
//   //                                     maxLines: 2,
//   //                                     overflow: TextOverflow.ellipsis,
//   //                                   ),
//   //                                 ),
//   //                                 SizedBox(height: 6.h),
//   //                                 FadeInLeft(
//   //                                   duration: 600.ms,
//   //                                   child: Container(
//   //                                     padding: EdgeInsets.symmetric(
//   //                                         horizontal: 12.w, vertical: 4.h),
//   //                                     decoration: BoxDecoration(
//   //                                       color: widget.categoryColor.withOpacity(0.1),
//   //                                       borderRadius: BorderRadius.circular(12.r),
//   //                                     ),
//   //                                     child: Text(
//   //                                       widget.item.category ?? '',
//   //                                       style: TextStyle(
//   //                                         fontSize: 12.sp,
//   //                                         color: widget.categoryColor,
//   //                                         fontWeight: FontWeight.w600,
//   //                                       ),
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                           ),
//   //                           Obx(() => FlipInX(
//   //                             duration: 300.ms,
//   //                             child: IconButton(
//   //                               icon: Icon(
//   //                                 widget.item.isMoreExpanded.value
//   //                                     ? Icons.expand_less
//   //                                     : Icons.expand_more,
//   //                                 color: Colors.grey[600],
//   //                                 size: 22.w,
//   //                               ),
//   //                               onPressed: () {
//   //                                 widget.item.isMoreExpanded.toggle();
//   //                               },
//   //                               splashRadius: 20,
//   //                             ),
//   //                           )),
//   //                         ],
//   //                       ),
//   //                       SizedBox(height: 12.h),
//   //
//   //                       // Enhanced Tags Section
//   //                       if (widget.item.tags != null && widget.item.tags!.isNotEmpty)
//   //                         Wrap(
//   //                           spacing: 6.w,
//   //                           runSpacing: 6.h,
//   //                           children: widget.item.tags!
//   //                               .map((tag) => FadeInUp(
//   //                             delay: (widget.item.tags!.indexOf(tag) * 100).ms,
//   //                             duration: 500.ms,
//   //                             child: Container(
//   //                               padding: EdgeInsets.symmetric(
//   //                                   horizontal: 10.w, vertical: 6.h),
//   //                               decoration: BoxDecoration(
//   //                                 color: widget.categoryColor.withOpacity(0.1),
//   //                                 borderRadius: BorderRadius.circular(8.r),
//   //                                 border: Border.all(
//   //                                   color: widget.categoryColor.withOpacity(0.3),
//   //                                   width: 1,
//   //                                 ),
//   //                               ),
//   //                               child: Text(
//   //                                 tag,
//   //                                 style: TextStyle(
//   //                                   fontSize: 10.sp,
//   //                                   color: widget.categoryColor,
//   //                                   fontWeight: FontWeight.w500,
//   //                                 ),
//   //                               ),
//   //                             ),
//   //                           ))
//   //                               .toList(),
//   //                         ),
//   //
//   //                       SizedBox(height: 12.h),
//   //
//   //                       Obx(() => AnimatedCrossFade(
//   //                         duration: const Duration(milliseconds: 300),
//   //                         crossFadeState: widget.item.isMoreExpanded.value
//   //                             ? CrossFadeState.showSecond
//   //                             : CrossFadeState.showFirst,
//   //                         firstChild: SizedBox(height: 8.h),
//   //                         secondChild: FadeInUp(
//   //                           duration: 300.ms,
//   //                           child: Column(
//   //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                             children: [
//   //                               Text(
//   //                                 widget.item.description ?? '',
//   //                                 style: TextStyle(
//   //                                   fontSize: 13.sp,
//   //                                   color: Colors.grey[700],
//   //                                   height: 1.5,
//   //                                   fontWeight: FontWeight.w400,
//   //                                 ),
//   //                               ),
//   //                               SizedBox(height: 16.h),
//   //                             ],
//   //                           ),
//   //                         ),
//   //                       )),
//   //
//   //                       Spacer(),
//   //
//   //                       // Action Buttons
//   //                       Row(
//   //                         children: [
//   //                           Expanded(
//   //                             child: _buildActionButton(),
//   //                           ),
//   //                           SizedBox(width: 12.w),
//   //                           if (widget.item.siteUrl != null &&
//   //                               widget.item.siteUrl!.isNotEmpty)
//   //                             FadeInRight(
//   //                               duration: 800.ms,
//   //                               child: InkWell(
//   //                                 borderRadius: BorderRadius.circular(10.r),
//   //                                 onTap: () async {
//   //                                   final Uri url = Uri.parse(widget.item.siteUrl!);
//   //                                   if (await canLaunchUrl(url)) {
//   //                                     await launchUrl(
//   //                                       url,
//   //                                       mode: LaunchMode.externalApplication,
//   //                                     );
//   //                                   }
//   //                                 },
//   //                                 child: Container(
//   //                                   padding: EdgeInsets.symmetric(
//   //                                       horizontal: 16.w, vertical: 12.h),
//   //                                   decoration: BoxDecoration(
//   //                                     color: Colors.grey[100],
//   //                                     borderRadius: BorderRadius.circular(10.r),
//   //                                     border: Border.all(
//   //                                       color: Colors.grey[300]!,
//   //                                       width: 1.5,
//   //                                     ),
//   //                                   ),
//   //                                   child: Icon(
//   //                                     Icons.open_in_new,
//   //                                     size: 20.w,
//   //                                     color: Colors.grey[700],
//   //                                   ),
//   //                                 ),
//   //                               ),
//   //                             ),
//   //                         ],
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget _buildActionButton() {
//     return AnimatedContainer(
//       duration: 200.ms,
//       decoration: BoxDecoration(
//         color: _isTapped
//             ? widget.categoryColor.withOpacity(0.9)
//             : widget.categoryColor,
//         borderRadius: BorderRadius.circular(10.r),
//         boxShadow: _isHovered
//             ? [
//           BoxShadow(
//             color: widget.categoryColor.withOpacity(0.4),
//             blurRadius: 15,
//             spreadRadius: 2,
//             offset: const Offset(0, 5),
//           )
//         ]
//             : null,
//       ),
//       padding: EdgeInsets.symmetric(vertical: 14.h),
//       child: Center(
//         child: Text(
//           widget.item.buttonText ?? 'VIEW PROJECT',
//           style: TextStyle(
//             fontSize: 12.sp,
//             color: Colors.white,
//             fontWeight: FontWeight.w700,
//             letterSpacing: 0.8,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImageSection() {
//     return Stack(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//           child: AspectRatio(
//             aspectRatio: 16 / 9,
//             child: Image.asset(
//               widget.item.imagePath ?? 'assets/images/placeholder.png',
//               width: double.infinity,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) => Container(
//                 color: Colors.grey[200],
//                 child: Icon(Icons.image, size: 40.w, color: Colors.grey[400]),
//               ),
//             ),
//           ),
//         ),
//         Positioned.fill(
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.transparent,
//                   Colors.black.withOpacity(0.6),
//                 ],
//                 stops: const [0.4, 1],
//               ),
//             ),
//           ),
//         ),
//
//         // Category Badge
//         Positioned(
//           top: 16,
//           right: 16,
//           child: AnimatedContainer(
//             duration: 300.ms,
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//             decoration: BoxDecoration(
//               color: widget.categoryColor,
//               borderRadius: BorderRadius.circular(20.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 )
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   _getCategoryIcon(widget.item.category),
//                   size: 12.w,
//                   color: Colors.white,
//                 ),
//                 SizedBox(width: 4.w),
//                 Text(
//                   widget.item.category ?? '',
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         // Featured Badge
//         if (widget.item.isFeatured ?? false)
//           Positioned(
//             top: 16,
//             left: 0,
//             child: Swing(
//               infinite: true,
//               duration: 2000.ms,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                 decoration: BoxDecoration(
//                   color: Colors.amber[600],
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(12.r),
//                     bottomRight: Radius.circular(12.r),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     )
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.star, size: 14.w, color: Colors.white),
//                     SizedBox(width: 4.w),
//                     Text(
//                       'FEATURED',
//                       style: TextStyle(
//                         fontSize: 10.sp,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w800,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//         // Hover Effect
//         if (_isHovered)
//           Positioned.fill(
//             child: FadeIn(
//               duration: 300.ms,
//               child: Container(
//                 color: Colors.black.withOpacity(0.2),
//                 child: Center(
//                   child: JelloIn(
//                     duration: 1000.ms,
//                     child: Container(
//                       padding: EdgeInsets.all(16.w),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.3),
//                             blurRadius: 20,
//                             spreadRadius: 2,
//                           )
//                         ],
//                       ),
//                       child: Icon(
//                         Icons.zoom_in,
//                         size: 28.w,
//                         color: widget.categoryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   IconData _getCategoryIcon(String? category) {
//     switch (category) {
//       case 'Mobile':
//         return Icons.phone_android;
//       case 'Web':
//         return Icons.web;
//       case 'Design':
//         return Icons.design_services;
//       default:
//         return Icons.work;
//     }
//   }
// }
