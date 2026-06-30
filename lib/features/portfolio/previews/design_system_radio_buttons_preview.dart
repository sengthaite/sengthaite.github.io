import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/features/portfolio/previews/design_system_preview_theme.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/radio_buttons.dart';

final class DesignSystemRadioButtonsPreview extends MultiPreview {
  const DesignSystemRadioButtonsPreview();

  @override
  List<Preview> get previews => [
    Preview(
      name: 'DefaultSelected-Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'NoSelection-Light',
      brightness: Brightness.light,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'DefaultSelected-Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
    Preview(
      name: 'NoSelection-Dark',
      brightness: Brightness.dark,
      group: 'States',
      theme: designSystemPreviewTheme,
    ),
  ];

  Widget _defaultSelectionRadioButton(Widget child) => Scaffold(
    body: RadioButtons<Locale>(
      defaultSelectedValue: Locale('en'),
      list: [
        RadioButtonData<Locale>(text: "ភាសាខ្មែរ ", value: Locale('km')),
        RadioButtonData<Locale>(text: "English", value: Locale('en')),
      ],
    ),
  );
  Widget _noDefaultSelectionRadioButton(Widget child) => Scaffold(
    body: RadioButtons<Locale>(
      list: [
        RadioButtonData(text: "ភាសាខ្មែរ ", value: Locale('km')),
        RadioButtonData(text: "English", value: Locale('en')),
      ],
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
        case 'DefaultSelected':
          builder.wrapper = _defaultSelectionRadioButton;
          break;
        case 'NoSelection':
          builder.wrapper = _noDefaultSelectionRadioButton;
          break;
        default:
          builder.wrapper = _defaultSelectionRadioButton;
          break;
      }
      return builder.build();
    }).toList();
  }
}

@DesignSystemRadioButtonsPreview()
Widget designSystemButtonsPreview() {
  return RadioButtons(
    defaultSelectedValue: "KHM",
    list: [
      RadioButtonData(text: "ភាសាខ្មែរ ", value: "KHM"),
      RadioButtonData(text: "English", value: "ENG"),
    ],
  );
}
