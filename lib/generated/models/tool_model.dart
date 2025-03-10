import 'package:flutter/material.dart';

class ToolItemModel {
  final String title;
  final int index;
  final Widget? widget;
  final Widget? image;
  final List<Widget>? actions;
  Widget Function(BuildContext)? widgetBuilder;
  FutureBuilder<dynamic>? futureBuilder;
  Function? onDispose;

  ToolItemModel({
    required this.index,
    required this.title,
    this.widget,
    this.widgetBuilder,
    this.futureBuilder,
    this.image,
    this.actions,
    this.onDispose,
  });
}
