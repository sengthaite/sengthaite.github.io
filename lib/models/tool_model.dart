import 'package:flutter/material.dart';

class ToolItemModel {
  final String title;
  final int index;
  final Widget? widget;
  final Widget? image;
  Widget Function(BuildContext)? widgetBuilder;

  ToolItemModel({
    required this.index,
    required this.title,
    this.widget,
    this.widgetBuilder,
    this.image,
  });
}
