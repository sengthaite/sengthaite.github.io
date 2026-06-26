import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';

class MenuButton extends StatefulWidget {
  final Widget? icon;
  final Widget? selectedIcon;
  final Widget? trailIcon;
  final Widget? selectedTrailingIcon;
  final String text;
  final ValueNotifier<bool>? isSelected;
  final VoidCallback? onPressed;

  const MenuButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.selectedIcon,
    this.trailIcon,
    this.selectedTrailingIcon,
    this.isSelected,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  ValueNotifier<bool> isSelected = ValueNotifier(false);

  @override
  initState() {
    isSelected = widget.isSelected ?? ValueNotifier(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelected,
      builder: (c, selected, w) {
        TextStyle? titleStyle = selected
            ? context.pfTheme.menuSelectedTextStyle
            : context.pfTheme.menuTextStyle;

        EdgeInsetsGeometry padding =
            widget.icon != null &&
                (widget.trailIcon == null ||
                    widget.selectedTrailingIcon == null)
            ? const EdgeInsets.fromLTRB(20, 10, 35, 10)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

        return IconButton.filled(
          onPressed: () {
            widget.onPressed?.call();
          },
          padding: padding,
          style: selected
              ? context.pfTheme.buttonSelectedStyle
              : context.pfTheme.buttonStyle,
          isSelected: selected,
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (selected && widget.selectedIcon != null)
                ?widget.selectedIcon
              else
                ?widget.icon,
              Text(widget.text, style: selected ? titleStyle.bold : titleStyle),
              if (selected && widget.selectedTrailingIcon != null)
                ?widget.selectedTrailingIcon
              else
                ?widget.trailIcon,
            ],
          ),
        );
      },
    );
  }
}
