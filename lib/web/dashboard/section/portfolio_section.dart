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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../custom_view/border_container.dart';
import '../../../custom_view/custom_text.dart';
import '../../../model/portfolio_model.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/color_file.dart';
import '../../../utils/common.dart';
import '../widget/portfolio_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../custom_view/border_container.dart';
import '../../../custom_view/custom_text.dart';
import '../../../custom_view/web_custom_button_with_border.dart';
import '../../../model/portfolio_model.dart';
import '../../../utils/app_text_styles.dart';
import '../hover_effect/slide_zoom_effect.dart';

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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Web',
    'Mobile',
    'Design',
    'Branding'
  ];
  final Map<String, Color> _categoryColors = {
    'All': Colors.blue,
    'Web': Colors.purple,
    'Mobile': Colors.green,
    'Design': Colors.orange,
    'Branding': Colors.red,
  };

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    setState(() {
      _currentPage = _pageController.page?.round() ?? 0;
    });
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _prevPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  List<PortfolioModel> get _filteredPortfolioList {
    if (_selectedCategory == 'All') return widget.portfolioList;
    return widget.portfolioList
        .where((item) => item.category == _selectedCategory)
        .toList();
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
            Colors.white.withOpacity(0.95),
            Colors.grey[50]!,
          ],
        ),
      ),
      child: Column(
        children: [
          _buildSectionHeader(),
          SizedBox(height: 30.h),
          _buildCategoryTabs(),
          SizedBox(height: 30.h),
          _filteredPortfolioList.isEmpty
              ? _buildEmptyState()
              : _buildPortfolioCarousel(),
          if (_filteredPortfolioList.isNotEmpty) SizedBox(height: 20.h),
          if (_filteredPortfolioList.isNotEmpty) _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Text(
          'PORTFOLIO',
          style: TextStyle(
            fontSize: 42.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 15.h),
        Container(
          width: 100.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: _categoryColors[_selectedCategory] ?? Colors.blue,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          width: 700.w,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Explore my creative works and projects across different categories. Each project represents my skills and dedication to quality.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black54,
              height: 1.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                  _currentPage = 0;
                });
              },
              borderRadius: BorderRadius.circular(20.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? _categoryColors[category]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: _categoryColors[category]!.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPortfolioCarousel() {
    return SizedBox(
      height: 450.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _filteredPortfolioList.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final item = _filteredPortfolioList[index];
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                  }
                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: value.clamp(0.8, 1.0),
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: PortfolioCard(
                    model: item,
                    accentColor:
                        _categoryColors[_selectedCategory] ?? Colors.blue,
                  ),
                ),
              );
            },
          ),
          if (_filteredPortfolioList.length > 1) ...[
            Positioned(
              left: 20.w,
              child: _buildNavigationArrow(isLeft: true),
            ),
            Positioned(
              right: 20.w,
              child: _buildNavigationArrow(isLeft: false),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _filteredPortfolioList.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentPage == index ? 20.w : 10.w,
          height: 10.w,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: _currentPage == index
                ? _categoryColors[_selectedCategory] ?? Colors.blue
                : Colors.grey[300],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationArrow({required bool isLeft}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isLeft ? _prevPage : _nextPage,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              isLeft ? Icons.chevron_left : Icons.chevron_right,
              size: 30.w,
              color: _categoryColors[_selectedCategory] ?? Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 300.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: 60.w,
            color: Colors.grey[400],
          ),
          SizedBox(height: 20.h),
          Text(
            'No projects in this category yet',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Check back later or explore other categories',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class PortfolioCard extends StatelessWidget {
  final PortfolioModel model;
  final Color accentColor;

  const PortfolioCard({
    super.key,
    required this.model,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: 320.w,
        height: 420.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 1,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with hover effect
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Stack(
                children: [
                  SizedBox(
                    height: 200.h,
                    width: double.infinity,
                    child: Image.asset(
                      model.imagePath ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.h,
                    left: 20.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        model.category!.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(12.r)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title!,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          model.description!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black54,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(25.r),
                            boxShadow: [
                              BoxShadow(
                                color: accentColor.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                model.buttonText!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.arrow_forward,
                                size: 18.w,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class PortfolioModel {
//   final String? imagePath;
//   final String? category;
//   final String? title;
//   final String? description;
//   final String? buttonText;
//
//   PortfolioModel({
//     this.imagePath,
//     this.category,
//     this.title,
//     this.description,
//     this.buttonText,
//   });
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../custom_view/border_container.dart';
// import '../../../custom_view/custom_text.dart';
// import '../../../model/portfolio_model.dart';
// import '../../../utils/app_text_styles.dart';
// import '../../../utils/color_file.dart';
// import '../../../utils/string_file.dart';
// import '../widget/portfolio_card_widget.dart';
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
//   final PageController _pageController = PageController(viewportFraction: 0.8);
//   int _currentPage = 0;
//   final List<String> _categories = ['All', 'Web', 'Mobile', 'Design', 'Branding'];
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController.addListener(_pageListener);
//   }
//
//   @override
//   void dispose() {
//     _pageController.removeListener(_pageListener);
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   void _pageListener() {
//     setState(() {
//       _currentPage = _pageController.page?.round() ?? 0;
//     });
//   }
//
//   void _nextPage() {
//     _pageController.nextPage(
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _prevPage() {
//     _pageController.previousPage(
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
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
//             Colors.white.withOpacity(0.95),
//             Colors.grey[50]!,
//           ],
//         ),
//       ),
//       child: Column(
//         children: [
//           _buildSectionHeader(),
//           SizedBox(height: 30.h),
//           _buildCategoryTabs(),
//           SizedBox(height: 30.h),
//           _buildPortfolioCarousel(),
//           SizedBox(height: 20.h),
//           _buildPageIndicator(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader() {
//     return Column(
//       children: [
//         CustomTextView(
//           StringFile.portfolio,
//           style: AppTextStyles.boldBlack28.copyWith(
//             fontSize: 42.sp,
//             fontWeight: FontWeight.w800,
//             color: Colors.black87,
//             letterSpacing: 1.5,
//           ),
//         ),
//         SizedBox(height: 15.h),
//         Container(
//           width: 100.w,
//           height: 5.h,
//           decoration: BoxDecoration(
//             color: ColorFile.webThemeColor,
//             borderRadius: BorderRadius.circular(5.r),
//           ),
//         ),
//         SizedBox(height: 20.h),
//         Container(
//           width: 700.w,
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: CustomTextView(
//             StringFile.portfolioDescription,
//             textAlign: TextAlign.center,
//             style: AppTextStyles.regularBlack14.copyWith(
//               fontSize: 18.sp,
//               color: Colors.black54,
//               height: 1.8,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCategoryTabs() {
//     return SizedBox(
//       height: 50.h,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: _categories.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.w),
//             child: InkWell(
//               onTap: () {
//                 // Filter portfolio items by category
//                 // You would implement this based on your data structure
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//                 decoration: BoxDecoration(
//                   color: index == 0 ? ColorFile.webThemeColor : Colors.transparent,
//                   borderRadius: BorderRadius.circular(25.r),
//                   border: Border.all(
//                     color: index == 0 ? Colors.transparent : Colors.grey[300]!,
//                     width: 1.5,
//                   ),
//                 ),
//                 child: CustomTextView(
//                   _categories[index],
//                   style: AppTextStyles.mediumBlack14.copyWith(
//                     color: index == 0 ? Colors.white : Colors.black54,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildPortfolioCarousel() {
//     return SizedBox(
//       height: 450.h,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             itemCount: widget.portfolioList.length,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPage = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               return AnimatedBuilder(
//                 animation: _pageController,
//                 builder: (context, child) {
//                   double value = 1.0;
//                   if (_pageController.position.haveDimensions) {
//                     value = _pageController.page! - index;
//                     value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
//                   }
//                   return Transform.scale(
//                     scale: value,
//                     child: Opacity(
//                       opacity: value.clamp(0.8, 1.0),
//                       child: child,
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.w),
//                   child: PortfolioCardWidget(
//                     model: widget.portfolioList[index],
//                   ),
//                 ),
//               );
//             },
//           ),
//           Positioned(
//             left: 20.w,
//             child: _buildNavigationArrow(isLeft: true),
//           ),
//           Positioned(
//             right: 20.w,
//             child: _buildNavigationArrow(isLeft: false),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPageIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         widget.portfolioList.length,
//             (index) => Container(
//           width: 10.w,
//           height: 10.w,
//           margin: EdgeInsets.symmetric(horizontal: 5.w),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: _currentPage == index
//                 ? ColorFile.webThemeColor
//                 : Colors.grey[300],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavigationArrow({required bool isLeft}) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       child: GestureDetector(
//         onTap: isLeft ? _prevPage : _nextPage,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           width: 50.w,
//           height: 50.w,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 spreadRadius: 2,
//               ),
//             ],
//           ),
//           child: Center(
//             child: Icon(
//               isLeft ? Icons.chevron_left : Icons.chevron_right,
//               size: 30.w,
//               color: ColorFile.webThemeColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class PortfolioCardWidget extends StatelessWidget {
//   final PortfolioModel model;
//
//   const PortfolioCardWidget({super.key, required this.model});
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       child: Container(
//         width: 320.w,
//         height: 420.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 20,
//               spreadRadius: 1,
//               offset: const Offset(0, 10),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image with hover effect
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
//               child: Stack(
//                 children: [
//                   SizedBox(
//                     height: 200.h,
//                     width: double.infinity,
//                     child: Image.asset(
//                       model.imagePath ?? "",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Positioned.fill(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             Colors.transparent,
//                             Colors.black.withOpacity(0.6),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 20.h,
//                     left: 20.w,
//                     child: CustomTextView(
//                       model.category!.toUpperCase(),
//                       style: AppTextStyles.regularBlack12.copyWith(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Content
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(20.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomTextView(
//                       model.title!,
//                       style: AppTextStyles.boldBlack16.copyWith(
//                         fontSize: 22.sp,
//                         fontWeight: FontWeight.w700,
//                         height: 1.3,
//                       ),
//                     ),
//                     SizedBox(height: 12.h),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: CustomTextView(
//                           model.description!,
//                           style: AppTextStyles.mediumBlack12.copyWith(
//                             fontSize: 14.sp,
//                             color: Colors.black87,
//                             height: 1.6,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: _buildButton(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildButton() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         color: ColorFile.webThemeColor,
//         borderRadius: BorderRadius.circular(25.r),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           CustomTextView(
//             model.buttonText!,
//             style: AppTextStyles.mediumBlack14.copyWith(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(width: 8.w),
//           Icon(
//             Icons.arrow_forward,
//             size: 18.w,
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }
