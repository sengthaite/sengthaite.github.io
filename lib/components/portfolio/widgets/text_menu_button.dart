import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

class TextMenuButton extends StatefulWidget {
  final Widget? icon;
  final Widget? trailIcon;
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const TextMenuButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.trailIcon,
    this.isSelected = false,
  });

  @override
  State<TextMenuButton> createState() => _TextMenuButtonState();
}

class _TextMenuButtonState extends State<TextMenuButton> {
  bool isSelected = false;

  @override
  initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.bodyMedium?.merge(
      isSelected ? textMenuButtonTitleSelectedStyle : textMenuButtonTitleStyle,
    );

    return TextButton(
      onPressed: widget.onPressed,
      child: Row(
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
