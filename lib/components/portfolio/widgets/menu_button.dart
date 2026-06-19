import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

class SwitchableIcon {}

class MenuButton extends StatefulWidget {
  final Widget? icon;
  final Widget? selectedIcon;
  final Widget? trailIcon;
  final Widget? selectedTrailingIcon;
  final String text;
  final ValueNotifier<bool>? isSelected;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.text,
    required this.onPressed,
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
    return ListenableBuilder(
      listenable: isSelected,
      builder: (c, w) {
        TextStyle? style = Theme.of(context).textTheme.bodyMedium?.merge(
          isSelected.value
              ? menuButtonTitleSelectedStyle
              : menuButtonTitleStyle,
        );

        ButtonStyle buttonStyle = isSelected.value
            ? menuButtonSelectedStyle
            : menuButtonStyle;

        EdgeInsetsGeometry padding =
            widget.icon != null &&
                (widget.trailIcon == null ||
                    widget.selectedTrailingIcon == null)
            ? const EdgeInsets.fromLTRB(20, 10, 35, 10)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

        return IconButton.filled(
          onPressed: () {
            isSelected.value = !(widget.isSelected?.value ?? isSelected.value);
            widget.onPressed();
          },
          padding: padding,
          style: buttonStyle,
          isSelected: isSelected.value,
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (isSelected.value && widget.selectedIcon != null)
                ?widget.selectedIcon
              else
                ?widget.icon,
              Text(widget.text, style: style),
              if (isSelected.value && widget.selectedTrailingIcon != null)
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
