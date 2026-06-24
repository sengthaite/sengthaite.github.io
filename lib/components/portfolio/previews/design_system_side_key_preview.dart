import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/components/portfolio/previews/design_system_preview_theme.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/side_key.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';

final class DesignSystemSideKeyPreview extends MultiPreview {
  const DesignSystemSideKeyPreview();

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

  Widget _textButtonWrapper(Widget child) =>
      Scaffold(body: SideKeyView(text: 'Click Me'));
  Widget _textSelectedButtonWrapper(Widget child) => Scaffold(
    body: SideKeyView(
      text: 'Click Me Now',
      icon: AssetIcons.cli.imageWithStyle(size: Size(20, 20)),
    ),
  );
  Widget _textIconButtonWrapper(Widget child) => Scaffold(
    body: SideKeyView(
      text: 'SETTINGS',
      icon: AssetIcons.home.imageWithStyle(
        size: Size(20, 20),
        color: Colors.grey,
      ),
      trailIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
    ),
  );
  Widget _textIconSelectedButtonWrapper(Widget child) => Scaffold(
    body: SideKeyView(
      text: 'Click Me',
      icon: Icon(Icons.check, color: Colors.red),
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

@DesignSystemSideKeyPreview()
Widget designSystemSideKeyPreview() {
  return SideKeyView(text: 'Click Me Now');
}
