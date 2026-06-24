import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class TextMenuButton extends StatefulWidget {
  final Widget? icon;
  final Widget? trailIcon;
  final String text;
  final ValueNotifier<bool>? isSelected;
  final VoidCallback? onPressed;

  const TextMenuButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.trailIcon,
    this.isSelected,
  });

  @override
  State<TextMenuButton> createState() => _TextMenuButtonState();
}

class _TextMenuButtonState extends State<TextMenuButton> {
  ValueNotifier<bool> isSelected = ValueNotifier(false);

  @override
  initState() {
    isSelected = widget.isSelected ?? ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    isSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelected,
      builder: (context, value, child) {
        TextStyle? textStyle = isSelected.value
            ? context.pfTheme.experienceTitleSelectedTextStyle
            : context.pfTheme.experienceTitleTextStyle;

        return TextButton(
          onPressed: widget.onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              ?widget.icon,
              Text(widget.text, style: textStyle),
              ?widget.trailIcon,
            ],
          ),
        );
      },
    );
  }
}
