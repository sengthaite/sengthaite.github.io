import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class SideKeyView extends StatelessWidget {
  final Widget? icon;
  final Widget? trailIcon;
  final String text;

  const SideKeyView({super.key, required this.text, this.icon, this.trailIcon});

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    );

    return IconButton.filled(
      onPressed: () {},
      padding: padding,
      isSelected: false,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      style: context.pfTheme.buttonStyle,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          ?icon,
          Text(text, style: context.pfTheme.sideMenuTitleStyle),
          ?trailIcon,
        ],
      ),
    );
  }
}
