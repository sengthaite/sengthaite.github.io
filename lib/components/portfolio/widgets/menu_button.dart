import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

class MenuButton extends StatefulWidget {
  final Widget? icon;
  final Widget? trailIcon;
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.trailIcon,
    this.isSelected = false,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool isSelected = false;

  @override
  initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.bodyMedium?.merge(
      isSelected ? menuButtonTitleSelectedStyle : menuButtonTitleStyle,
    );

    ButtonStyle buttonStyle = isSelected
        ? menuButtonSelectedStyle
        : menuButtonStyle;

    EdgeInsetsGeometry padding = widget.icon != null && widget.trailIcon == null
        ? const EdgeInsets.fromLTRB(20, 10, 35, 10)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    return IconButton.filled(
      onPressed: widget.onPressed,
      padding: padding,
      style: buttonStyle,
      isSelected: isSelected,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          ?widget.icon,
          Text(widget.text, style: style),
          ?widget.trailIcon,
        ],
      ),
    );
  }
}
