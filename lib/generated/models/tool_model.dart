import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/enum.constants.dart';

class ToolItemModel {
  final String title;
  final int index;
  final Widget? widget;
  final Widget? image;
  final List<Widget>? actions;
  final List<CurrentPlatform>? hiddenPlatform; // hide on these platform
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
    this.hiddenPlatform,
    this.onDispose,
  });
}
