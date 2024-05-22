import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uuid/v8.dart';

class TabBarNavigationTitle {
  TabBarNavigationTitle({
    required this.title,
    required this.index,
    required this.widget,
    this.titleStyle,
    this.onTap,
  });

  TextStyle? titleStyle;

  final UuidV8 id = const UuidV8();
  final int index;
  final String title;
  final Widget widget;
  Function(TabBarNavigationTitle)? onTap;

  setTitleStyle(TextStyle titleStyle) {
    this.titleStyle = titleStyle;
  }

  TextSpan get titleWidget => TextSpan(text: " < ", children: [
        TextSpan(
            text: title,
            style: titleStyle,
            recognizer: onTap != null
                ? (TapGestureRecognizer()..onTap = () => onTap!(this))
                : null)
      ]);
}
