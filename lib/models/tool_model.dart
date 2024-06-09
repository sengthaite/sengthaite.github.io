import 'package:flutter/material.dart';

class ToolItemModel {
  final String title;
  final int index;
  final Widget widget;

  ToolItemModel({
    required this.index,
    required this.title,
    required this.widget,
  });
}
