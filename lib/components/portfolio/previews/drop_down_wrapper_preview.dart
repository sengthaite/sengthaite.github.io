import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/components/portfolio/previews/design_system_preview_theme.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/menu_button.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/overlay_dropdown.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/radio_buttons.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/table_popup.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

class SettingDropdown extends StatefulWidget {
  const SettingDropdown({super.key});

  @override
  State<SettingDropdown> createState() => _SettingDropdownState();
}

class _SettingDropdownState extends State<SettingDropdown> {
  final controller = OverlayPortalController();
  final ValueNotifier<bool> isShowing = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return OverlayPopUpDropdown(
      controller: controller,
      menuButton: MenuButton(
        text: 'SETTINGS',
        onPressed: () {
          controller.toggle();
        },
        isSelected: isShowing,
        icon: AssetIcons.home.imageWithStyle(
          size: Size(40, 40),
          color: buttonIconColor,
        ),
        selectedIcon: AssetIcons.home.imageWithStyle(
          size: Size(40, 40),
          color: buttonIconSelectedColor,
        ),
        trailIcon: Icon(Icons.keyboard_arrow_down, color: buttonIconColor),
        selectedTrailingIcon: Icon(
          Icons.keyboard_arrow_up,
          color: buttonIconSelectedColor,
        ),
      ),
      listDropdownWidget: TablePopup(
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
}

@Preview(name: "Dropdown", theme: designSystemPreviewTheme)
Widget dropdown() {
  return Scaffold(body: SettingDropdown());
}
