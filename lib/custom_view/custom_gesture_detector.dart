import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/color_file.dart';

// ignore: must_be_immutable
class CustomGestureDetector extends StatelessWidget {
  CustomGestureDetector({required this.onTap, required this.child, this.cursor = SystemMouseCursors.click, this.onEnter, this.onExit, this.semanticsLabel, super.key});
  Function()? onTap;
  Function(PointerEnterEvent)? onEnter;
  Function(PointerExitEvent)? onExit;
  SystemMouseCursor cursor;
  Widget child;
  String? semanticsLabel;
  var isFocused = false.obs;
  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        label: semanticsLabel,
        button: true,
        child: Focus(
          canRequestFocus: false,
          onFocusChange: (value) {
            isFocused.value = value;
          },
          // focusNode: FocusNode(),
          child: Obx(() => Container(
            decoration: BoxDecoration(
                border: (isFocused.value)?Border.all(width: 4.0, color: ColorFile.twitterColor):null,
                borderRadius: BorderRadius.circular(4.0)
            ),
            child: MouseRegion(
              cursor: cursor,
              onEnter: onEnter,
              onExit: onExit,
              child: InkWell(
                canRequestFocus: true,
                onTap: onTap,
                child: Semantics(
                    excludeSemantics: true,
                    child: child),
              ),
            ),
          ),),
        ),
      ),
    );
  }
}
