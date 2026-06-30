import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/features/portfolio/previews/design_system_preview_theme.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/radio_buttons.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/table_popup.dart';

@Preview(name: "Table Popup View", theme: designSystemPreviewTheme)
Widget popUpView() {
  return Scaffold(
    body: TablePopup(
      rows: [
        TableRowData(
          title: "LANGUAGE",
          widget: RadioButtons(
            defaultSelectedValue: "KHM",
            list: [
              RadioButtonData(text: "ភាសាខ្មែរ", value: "KHM"),
              RadioButtonData(text: "English", value: "ENG"),
            ],
          ),
        ),
        TableRowData(
          title: "DISPLAY",
          widget: RadioButtons(
            defaultSelectedValue: "L",
            list: [
              RadioButtonData(text: "Light", value: "L"),
              RadioButtonData(text: "Dark", value: "D"),
            ],
          ),
        ),
        TableRowData(title: "DEMOS"),
        TableRowData(title: "FEEDBACK"),
        TableRowData(title: "REGISTER / LOGIN"),
      ],
    ),
  );
}
