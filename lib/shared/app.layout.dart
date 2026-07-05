import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

enum AppLayoutType { mobile, tablet, desktop, unknown }

class AppLayout extends StatefulWidget {
  final Widget? defaultWidget;
  final Widget? portraitWidget;
  final Widget? landscapeWidget;

  static ValueNotifier<AppLayoutType> layoutType = ValueNotifier(
    AppLayoutType.unknown,
  );

  const AppLayout({
    super.key,
    this.defaultWidget,
    this.portraitWidget,
    this.landscapeWidget,
  });

  @override
  State<StatefulWidget> createState() => AppLayoutState();
}

class AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    final defaultWidget = widget.defaultWidget ?? const SizedBox();

    switch (context.orientation) {
      case Orientation.portrait:
        return widget.portraitWidget ?? defaultWidget;
      case Orientation.landscape:
        return widget.landscapeWidget ?? defaultWidget;
    }
  }
}
