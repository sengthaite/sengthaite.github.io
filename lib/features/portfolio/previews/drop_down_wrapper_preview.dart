import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/previews/design_system_preview_theme.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/menu_button.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/overlay_dropdown.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/radio_buttons.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/table_popup.dart';

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
        text: context.l10n.setting.toUpperCase(),
        onPressed: () {
          controller.toggle();
        },
        isSelected: isShowing,
        icon: AssetIcons.home.imageWithStyle(
          size: Size(40, 40),
          color: context.pfTheme.buttonBgColor,
        ),
        selectedIcon: AssetIcons.home.imageWithStyle(
          size: Size(40, 40),
          color: context.pfTheme.buttonSelectedBgColor,
        ),
        trailIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        selectedTrailingIcon: Icon(Icons.keyboard_arrow_up, color: Colors.red),
      ),
      listDropdownWidget: TablePopup(
        rows: [
          TableRowData(
            title: context.l10n.language.toUpperCase(),
            widget: RadioButtons(
              defaultSelectedValue: "KHM",
              list: [
                RadioButtonData(text: context.l10n.khmer_lang, value: "KHM"),
                RadioButtonData(text: context.l10n.english_lang, value: "ENG"),
              ],
            ),
          ),
          TableRowData(
            title: context.l10n.display,
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
