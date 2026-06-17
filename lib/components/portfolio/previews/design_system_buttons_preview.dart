import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/components/portfolio/previews/design_system_preview_theme.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';

class ButtonView extends StatelessWidget {
  final Widget? icon;
  final String text;
  final VoidCallback onPressed;

  const ButtonView({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Row(
        children: [
          ?icon,
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

final class DesignSystemButtonsPreview extends MultiPreview {
  const DesignSystemButtonsPreview();

  @override
  List<Preview> get previews => [
    // Text Only Preview
    Preview(
      name: 'Text - Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'Text - Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'TextSelected - Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'TextSelected - Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'TextIcon-Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'TextIcon-Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'TextIconSelected-Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'TextIconSelected-Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
  ];

  Widget _textButtonWrapper(Widget child) => Scaffold(
    body: ButtonView(text: 'Click Me', onPressed: () {}),
  );
  Widget _textSelectedButtonWrapper(Widget child) => Scaffold(
    body: ButtonView(
      text: 'Click Me',
      onPressed: () {},
      icon: AssetIcons.cli.image,
    ),
  );
  Widget _textIconButtonWrapper(Widget child) => Scaffold(
    body: ButtonView(
      text: 'Click Me',
      onPressed: () {},
      icon: Icon(Icons.touch_app),
    ),
  );
  Widget _textIconSelectedButtonWrapper(Widget child) => Scaffold(
    body: ButtonView(
      text: 'Click Me',
      onPressed: () {},
      icon: Icon(Icons.check),
    ),
  );

  @override
  List<Preview> transform() {
    final previews = super.transform();
    return previews.map((preview) {
      final builder = preview.toBuilder();
      final name = preview.name ?? '';
      String buttonType = 'Text';
      if (name.isNotEmpty) {
        buttonType = name.split('-').first.trim();
      }
      switch (buttonType) {
        case 'Text':
          builder.wrapper = _textButtonWrapper;
        case 'TextSelected':
          builder.wrapper = _textSelectedButtonWrapper;
        case 'TextIcon':
          builder.wrapper = _textIconButtonWrapper;
        case 'TextIconSelected':
          builder.wrapper = _textIconSelectedButtonWrapper;
        default:
          builder.wrapper = _textButtonWrapper;
      }
      return builder.build();
    }).toList();
  }
}

@DesignSystemButtonsPreview()
Widget designSystemButtonsPreview() {
  return ButtonView(
    text: 'Click Me',
    onPressed: () {},
    icon: Icon(Icons.touch_app),
  );
}
