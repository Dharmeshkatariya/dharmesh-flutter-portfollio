import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../model/portfolio_model.dart';
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
    if (_selectedCategory == 'All') return widget.portfolioList;
    return widget.portfolioList
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

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
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 60.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
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
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'My Portfolio',
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: 80.w,
          height: 4.h,
          color: Colors.blue,
        ),
        SizedBox(height: 20.h),
        SizedBox(
          width: 600.w,
          child: Text(
            'Here are some of my recent projects. Click on any project to view more details.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black54,
              height: 1.6,
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
  Widget _buildPortfolioGrid() {
    if (_filteredItems.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      padding: widget.horizontalPadding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(context),
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.h,
          childAspectRatio: _getChildAspectRatio(context),
        ),
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          return _PortfolioItemCard(item: _filteredItems[index]);
        },
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
    if (width > 1200) return 0.9;
    if (width > 800) return 0.85;
    return 0.8;
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 50.w, color: Colors.grey[400]),
          SizedBox(height: 20.h),
          Text(
            'No projects found in this category',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class _PortfolioItemCard extends StatefulWidget {
  final PortfolioModel item;

  const _PortfolioItemCard({required this.item});

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
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuint,
          transform: Matrix4.identity()
            ..scale(_isHovered ? 1.03 : 1.0)
            ..translate(0.0, _isHovered ? -8.0 : 0.0, 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section with overlay
              _buildImageSection(),
              // Content section
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and category
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.item.title ?? '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                widget.item.category ?? '',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: _getCategoryColor(widget.item.category),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Expand/collapse button
                        Obx(() => IconButton(
                          icon: Icon(
                            widget.item.isMoreExpanded.value
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            widget.item.isMoreExpanded.toggle();
                          },
                          splashRadius: 20,
                        )),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Tags
                    if (widget.item.tags != null && widget.item.tags!.isNotEmpty)
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: widget.item.tags!
                            .map((tag) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ))
                            .toList(),
                      ),
                    // Description (expandable)
                    Obx(() => AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState: widget.item.isMoreExpanded.value
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: SizedBox(height: 12.h),
                      secondChild: Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.description ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    )),
                    // Action buttons
                    Row(
                      children: [
                        // View Project button
                        Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: _isTapped
                                  ? Colors.blue[700]
                                  : Colors.blue[600],
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: _isHovered
                                  ? [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.4),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 5),
                                )
                              ]
                                  : null,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Center(
                              child: Text(
                                widget.item.buttonText ?? 'VIEW PROJECT',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Visit Site button (only shown if URL exists)
                        if (widget.item.siteUrl != null &&
                            widget.item.siteUrl!.isNotEmpty)
                          InkWell(
                            borderRadius: BorderRadius.circular(8.r),
                            onTap: () {
                              // Handle site URL tap
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.public,
                                size: 20.w,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        // Main image
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              widget.item.imagePath ?? '',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Gradient overlay
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
                stops: const [0.6, 1],
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: _getCategoryColor(widget.item.category),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Text(
              widget.item.category ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        // Featured ribbon
        if (widget.item.isFeatured ?? false)
          Positioned(
            top: 0,
            left: -5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.amber[600],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                'FEATURED',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        // Hover effect
        if (_isHovered)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutBack,
                  transform: Matrix4.identity()..scale(_isHovered ? 1.0 : 0.8),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 2)
                      ],
                    ),
                    child: Icon(
                      Icons.zoom_in,
                      size: 28.w,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Color _getCategoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'web':
        return Colors.purple[400]!;
      case 'mobile':
        return Colors.green[500]!;
      case 'design':
        return Colors.orange[500]!;
      case 'branding':
        return Colors.red[400]!;
      default:
        return Colors.blue[500]!;
    }
  }
}

// class _PortfolioItemCard extends StatefulWidget {
//   final PortfolioModel item;
//
//   const _PortfolioItemCard({required this.item});
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
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOutQuint,
//           transform: Matrix4.identity()
//             ..scale(_isHovered ? 1.03 : 1.0)
//             ..translate(
//                 0.0, _isHovered ? -8.0 : 0.0, 0.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16.r),
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
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Image with gradient overlay
//                   Expanded(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(16.r)),
//                       child: Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           Image.asset(
//                             widget.item.imagePath ?? '',
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                           // Gradient overlay
//                           Container(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   Colors.transparent,
//                                   Colors.black.withOpacity(0.7),
//                                 ],
//                                 stops: [0.6, 1],
//                               ),
//                             ),
//                           ),
//                           // Category chip
//                           Positioned(
//                             top: 16,
//                             right: 16,
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 12.w, vertical: 6.h),
//                               decoration: BoxDecoration(
//                                 color: _getCategoryColor(widget.item.category),
//                                 borderRadius: BorderRadius.circular(20.r),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.2),
//                                     blurRadius: 10,
//                                     offset: Offset(0, 4),
//                                   )
//                                 ],
//                               ),
//                               child: Text(
//                                 widget.item.category ?? '',
//                                 style: TextStyle(
//                                   fontSize: 12.sp,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // Hover effect
//                           if (_isHovered)
//                             Container(
//                               color: Colors.black.withOpacity(0.3),
//                               child: Center(
//                                 child: AnimatedContainer(
//                                   duration: const Duration(milliseconds: 400),
//                                   curve: Curves.easeOutBack,
//                                   transform: Matrix4.identity()
//                                     ..scale(_isHovered ? 1.0 : 0.8),
//                                   child: Container(
//                                     padding: EdgeInsets.all(16.w),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       shape: BoxShape.circle,
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color: Colors.black.withOpacity(0.2),
//                                             blurRadius: 20,
//                                             spreadRadius: 2)
//                                       ],
//                                     ),
//                                     child: Icon(
//                                       Icons.zoom_in,
//                                       size: 28.w,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Content section
//                   Padding(
//                     padding: EdgeInsets.all(20.w),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.item.title ?? '',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         SizedBox(height: 8.h),
//                         // Tags
//                         if (widget.item.tags != null &&
//                             widget.item.tags!.isNotEmpty)
//                           Wrap(
//                             spacing: 8.w,
//                             runSpacing: 8.h,
//                             children: widget.item.tags!
//                                 .map((tag) => Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10.w, vertical: 4.h),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius:
//                                 BorderRadius.circular(6.r),
//                               ),
//                               child: Text(
//                                 tag,
//                                 style: TextStyle(
//                                   fontSize: 11.sp,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ))
//                                 .toList(),
//                           ),
//                         SizedBox(height: 12.h),
//                         // View button
//                         AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           decoration: BoxDecoration(
//                             color: _isTapped
//                                 ? Colors.blue[700]
//                                 : Colors.blue[600],
//                             borderRadius: BorderRadius.circular(8.r),
//                             boxShadow: _isHovered
//                                 ? [
//                               BoxShadow(
//                                 color: Colors.blue.withOpacity(0.4),
//                                 blurRadius: 15,
//                                 spreadRadius: 2,
//                                 offset: Offset(0, 5),
//                               )
//                             ]
//                                 : null,
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 10.h),
//                           width: double.infinity,
//                           child: Center(
//                             child: Text(
//                               'VIEW PROJECT',
//                               style: TextStyle(
//                                 fontSize: 13.sp,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 0.5,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               // Ribbon for featured items
//               if (widget.item.isFeatured ?? false)
//                 Positioned(
//                   top: 0,
//                   left: -5,
//                   child: Container(
//                     padding:
//                     EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: Colors.amber[600],
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(16.r),
//                         bottomRight: Radius.circular(16.r),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: Offset(0, 2),
//                         )
//                       ],
//                     ),
//                     child: Text(
//                       'FEATURED',
//                       style: TextStyle(
//                         fontSize: 10.sp,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w800,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Color _getCategoryColor(String? category) {
//     switch (category?.toLowerCase()) {
//       case 'web':
//         return Colors.purple[400]!;
//       case 'mobile':
//         return Colors.green[500]!;
//       case 'design':
//         return Colors.orange[500]!;
//       case 'branding':
//         return Colors.red[400]!;
//       default:
//         return Colors.blue[500]!;
//     }
//   }
// }


// class _PortfolioItemCard extends StatefulWidget {
//   final PortfolioModel item;
//
//   const _PortfolioItemCard({required this.item});
//
//   @override
//   State<_PortfolioItemCard> createState() => _PortfolioItemCardState();
// }
//
// class _PortfolioItemCardState extends State<_PortfolioItemCard> {
//   bool _isHovered = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.r),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(_isHovered ? 0.2 : 0.1),
//               blurRadius: _isHovered ? 20 : 10,
//               spreadRadius: _isHovered ? 2 : 1,
//               offset: Offset(0, _isHovered ? 8 : 4),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
//                 child: Stack(
//                   children: [
//                     Image.asset(
//                       widget.item.imagePath ?? '',
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                     if (_isHovered)
//                       Container(
//                         color: Colors.black.withOpacity(0.4),
//                         child: Center(
//                           child: Icon(
//                             Icons.zoom_in,
//                             size: 50.w,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(16.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.item.title ?? '',
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     widget.item.category ?? '',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
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
//   final PageController _pageController = PageController(viewportFraction: 0.8);
//   int _currentPage = 0;
//   String _selectedCategory = 'All';
//
//   final List<String> _categories = [
//     'All',
//     'Web',
//     'Mobile',
//     'Design',
//     'Branding'
//   ];
//   final Map<String, Color> _categoryColors = {
//     'All': Colors.blue,
//     'Web': Colors.purple,
//     'Mobile': Colors.green,
//     'Design': Colors.orange,
//     'Branding': Colors.red,
//   };
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
//   List<PortfolioModel> get _filteredPortfolioList {
//     if (_selectedCategory == 'All') return widget.portfolioList;
//     return widget.portfolioList
//         .where((item) => item.category == _selectedCategory)
//         .toList();
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
//           _filteredPortfolioList.isEmpty
//               ? _buildEmptyState()
//               : _buildPortfolioCarousel(),
//           if (_filteredPortfolioList.isNotEmpty) SizedBox(height: 20.h),
//           if (_filteredPortfolioList.isNotEmpty) _buildPageIndicator(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader() {
//     return Column(
//       children: [
//         Text(
//           'PORTFOLIO',
//           style: TextStyle(
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
//             color: _categoryColors[_selectedCategory] ?? Colors.blue,
//             borderRadius: BorderRadius.circular(5.r),
//           ),
//         ),
//         SizedBox(height: 20.h),
//         Container(
//           width: 700.w,
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: Text(
//             'Explore my creative works and projects across different categories. Each project represents my skills and dedication to quality.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
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
//     return Container(
//       height: 50.h,
//       margin: EdgeInsets.symmetric(horizontal: 20.w),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(25.r),
//       ),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: _categories.length,
//         itemBuilder: (context, index) {
//           final category = _categories[index];
//           final isSelected = _selectedCategory == category;
//
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   _selectedCategory = category;
//                   _currentPage = 0;
//                 });
//               },
//               borderRadius: BorderRadius.circular(20.r),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? _categoryColors[category]
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(20.r),
//                   boxShadow: isSelected
//                       ? [
//                           BoxShadow(
//                             color: _categoryColors[category]!.withOpacity(0.3),
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                           )
//                         ]
//                       : null,
//                 ),
//                 child: Center(
//                   child: Text(
//                     category,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black54,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14.sp,
//                     ),
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
//             itemCount: _filteredPortfolioList.length,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPage = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               final item = _filteredPortfolioList[index];
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
//                   child: PortfolioCard(
//                     model: item,
//                     accentColor:
//                         _categoryColors[_selectedCategory] ?? Colors.blue,
//                   ),
//                 ),
//               );
//             },
//           ),
//           if (_filteredPortfolioList.length > 1) ...[
//             Positioned(
//               left: 20.w,
//               child: _buildNavigationArrow(isLeft: true),
//             ),
//             Positioned(
//               right: 20.w,
//               child: _buildNavigationArrow(isLeft: false),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPageIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         _filteredPortfolioList.length,
//         (index) => AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           width: _currentPage == index ? 20.w : 10.w,
//           height: 10.w,
//           margin: EdgeInsets.symmetric(horizontal: 5.w),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5.r),
//             color: _currentPage == index
//                 ? _categoryColors[_selectedCategory] ?? Colors.blue
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
//               color: _categoryColors[_selectedCategory] ?? Colors.blue,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Container(
//       height: 300.h,
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.work_outline,
//             size: 60.w,
//             color: Colors.grey[400],
//           ),
//           SizedBox(height: 20.h),
//           Text(
//             'No projects in this category yet',
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: Colors.grey[600],
//             ),
//           ),
//           SizedBox(height: 10.h),
//           Text(
//             'Check back later or explore other categories',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.grey[500],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PortfolioCard extends StatelessWidget {
//   final PortfolioModel model;
//   final Color accentColor;
//
//   const PortfolioCard({
//     super.key,
//     required this.model,
//     required this.accentColor,
//   });
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
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                       decoration: BoxDecoration(
//                         color: accentColor,
//                         borderRadius: BorderRadius.circular(4.r),
//                       ),
//                       child: Text(
//                         model.category!.toUpperCase(),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 10.sp,
//                           letterSpacing: 1.5,
//                         ),
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
//                   borderRadius:
//                       BorderRadius.vertical(bottom: Radius.circular(12.r)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       model.title!,
//                       style: TextStyle(
//                         fontSize: 22.sp,
//                         fontWeight: FontWeight.w700,
//                         height: 1.3,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     SizedBox(height: 12.h),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Text(
//                           model.description!,
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: Colors.black54,
//                             height: 1.6,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: MouseRegion(
//                         cursor: SystemMouseCursors.click,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 20.w, vertical: 10.h),
//                           decoration: BoxDecoration(
//                             color: accentColor,
//                             borderRadius: BorderRadius.circular(25.r),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: accentColor.withOpacity(0.3),
//                                 blurRadius: 10,
//                                 spreadRadius: 2,
//                               )
//                             ],
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 model.buttonText!,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14.sp,
//                                 ),
//                               ),
//                               SizedBox(width: 8.w),
//                               Icon(
//                                 Icons.arrow_forward,
//                                 size: 18.w,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
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
// }

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
