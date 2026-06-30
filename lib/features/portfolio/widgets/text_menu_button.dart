import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class TextMenuButton extends StatelessWidget {
  final Widget? icon;
  final Widget? trailIcon;
  final String text;
  final ValueNotifier<bool> isSelected;
  final VoidCallback? onPressed;

  /// Widget TextMenuButton : button used in portfolio tab bar
  ///
  const TextMenuButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.trailIcon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSelected,
      builder: (context, value, child) {
        TextStyle? textStyle = isSelected.value
            ? context.pfTheme.ActivityMainInformationSelectedTextStyle
            : context.pfTheme.ActivityMainInformationTextStyle;

        return TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              ?icon,
              Text(text, style: textStyle),
              ?trailIcon,
            ],
          ),
        );
      },
    );
  }
}
