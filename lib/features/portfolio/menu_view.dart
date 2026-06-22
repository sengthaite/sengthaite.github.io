import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/menu_button.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/overlay_dropdown.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/radio_buttons.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/table_popup.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

extension on AssetIcons {
  Widget withDefaultStyle() {
    return imageWithStyle(size: Size(40, 40), color: buttonIconColor);
  }

  Widget withSelectedStyle() {
    return imageWithStyle(size: Size(40, 40), color: buttonIconSelectedColor);
  }
}

class MenuNavigation extends StatelessWidget {
  MenuNavigation({super.key});

  final OverlayPortalController controller = OverlayPortalController();
  final ValueNotifier<bool> isShowingOverlay = ValueNotifier(false);
  final ValueNotifier<bool> isHome = ValueNotifier(true);

  void togglePopUp() {
    controller.toggle();
    isShowingOverlay.value = !isShowingOverlay.value;
    isHome.value = !isShowingOverlay.value;
  }

  void resetMenuButtonSelection() {
    controller.hide();
    isShowingOverlay.value = false;
    isHome.value = true;
  }

  @override
  Widget build(BuildContext context) {
    isHome.value = true;
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        MenuButton(
          text: "HOME",
          icon: AssetIcons.home.withDefaultStyle(),
          selectedIcon: AssetIcons.home.withSelectedStyle(),
          isSelected: isHome,
          onPressed: () {},
        ),
        MenuButton(
          text: "MY BLOG",
          icon: AssetIcons.blog.withDefaultStyle(),
          selectedIcon: AssetIcons.blog.withSelectedStyle(),
          onPressed: () {
            Navigator.pushNamed(context, "/blog");
            resetMenuButtonSelection();
          },
        ),
        OverlayPopUpDropdown(
          controller: controller,
          onTapOutside: resetMenuButtonSelection,
          menuButton: MenuButton(
            text: 'SETTINGS',
            onPressed: togglePopUp,
            isSelected: isShowingOverlay,
            icon: AssetIcons.home.withDefaultStyle(),
            selectedIcon: AssetIcons.home.withSelectedStyle(),
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
        ),
      ],
    );
  }
}
