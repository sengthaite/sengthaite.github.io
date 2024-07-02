import 'package:flutter/material.dart';

class AppLayout extends StatefulWidget {
  final BuildContext context;
  final Widget? defaultWidget;
  final Widget? desktopWidget;
  final Widget? desktopPortraitWidget;
  final Widget? desktopLandscapeWidget;
  final Widget? tabletWidget;
  final Widget? tabletPortraitWidget;
  final Widget? tabletLandscapeWidget;
  final Widget? mobileWidget;
  final Widget? mobilePortraitWidget;
  final Widget? mobileLandscapeWidget;

  const AppLayout({
    super.key,
    required this.context,
    this.defaultWidget,
    this.desktopWidget,
    this.mobileWidget,
    this.desktopPortraitWidget,
    this.desktopLandscapeWidget,
    this.mobilePortraitWidget,
    this.mobileLandscapeWidget,
    this.tabletWidget,
    this.tabletPortraitWidget,
    this.tabletLandscapeWidget,
  });

  @override
  State<StatefulWidget> createState() => AppLayoutState();
}

class AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final defaultWidget = widget.defaultWidget ?? const SizedBox();
    return OrientationBuilder(builder: (context, orientation) {
      switch (orientation) {
        case Orientation.portrait:
          if (screenWidth < 800) {
            return widget.mobilePortraitWidget ??
                widget.mobileWidget ??
                defaultWidget;
          } else if (screenWidth < 1280) {
            return widget.tabletPortraitWidget ??
                widget.tabletWidget ??
                defaultWidget;
          } else {
            return widget.desktopPortraitWidget ??
                widget.desktopWidget ??
                defaultWidget;
          }
        case Orientation.landscape:
          if (screenWidth < 1024) {
            return widget.mobileLandscapeWidget ??
                widget.mobileWidget ??
                defaultWidget;
          } else if (screenWidth < 1920) {
            return widget.tabletLandscapeWidget ??
                widget.tabletWidget ??
                defaultWidget;
          } else {
            return widget.desktopLandscapeWidget ??
                widget.desktopWidget ??
                defaultWidget;
          }
      }
    });
  }
}
