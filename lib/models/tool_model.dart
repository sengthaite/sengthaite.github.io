import 'package:flutter/material.dart';

class ToolItemModel {
  final String title;
  final int index;
  final Widget? widget;
  Widget Function(BuildContext)? widgetBuilder;

  ToolItemModel({
    required this.index,
    required this.title,
    this.widget,
    this.widgetBuilder,
  });
}
