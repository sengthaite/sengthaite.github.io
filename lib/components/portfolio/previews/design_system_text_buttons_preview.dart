import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/components/portfolio/previews/design_system_preview_theme.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/text_menu_button.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

final class DesignSystemTextButtonsPreview extends MultiPreview {
  const DesignSystemTextButtonsPreview();

  @override
  List<Preview> get previews => [
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
      name: 'Text-Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'Text-Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'TextSelected-Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'TextSelected-Dark',
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
    body: TextMenuButton(text: 'Click Me', onPressed: () {}),
  );
  Widget _textSelectedButtonWrapper(Widget child) => Scaffold(
    body: TextMenuButton(
      text: 'Click Me Now',
      onPressed: () {},
      isSelected: true,
      icon: AssetIcons.cli.imageWithStyle(size: Size(25, 25)),
    ),
  );
  Widget _textIconButtonWrapper(Widget child) => Scaffold(
    body: TextMenuButton(text: 'SETTINGS', onPressed: () {}, isSelected: true),
  );
  Widget _textIconSelectedButtonWrapper(Widget child) => Scaffold(
    body: TextMenuButton(
      text: 'Click Me',
      onPressed: null,
      icon: Icon(Icons.check, color: buttonIconSelectedColor),
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
          break;
        case 'TextSelected':
          builder.wrapper = _textSelectedButtonWrapper;
          break;
        case 'TextIcon':
          builder.wrapper = _textIconButtonWrapper;
          break;
        case 'TextIconSelected':
          builder.wrapper = _textIconSelectedButtonWrapper;
          break;
        default:
          builder.wrapper = _textButtonWrapper;
          break;
      }
      return builder.build();
    }).toList();
  }
}

@DesignSystemTextButtonsPreview()
Widget designSystemButtonsPreview() {
  return TextMenuButton(text: 'Click Me Now');
}
