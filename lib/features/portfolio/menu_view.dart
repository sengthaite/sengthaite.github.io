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

  void showFeedback(BuildContext context) {
    togglePopUp();
    resetMenuButtonSelection();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(
            "FEEDBACK",
            textAlign: TextAlign.center,
            style: textStyle.copyWith(fontSize: 36),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Text(
                  "I'm actively improving this portfolio and would value your perspective - feel free to share any thoughts, no matter how small.",
                  style: textStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: starColor, size: 56),
                    Icon(Icons.star, color: starColor, size: 56),
                    Icon(Icons.star, color: starColor, size: 56),
                    Icon(Icons.star, color: starColor, size: 56),
                    Icon(Icons.star, size: 56),
                  ],
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username / Email',
                  ),
                ),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Comment',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel", style: textStyle),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Submit",
                style: textStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
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
              // TableRowData(title: "DEMOS"),
              TableRowData(
                title: "FEEDBACK",
                onPress: () => showFeedback(context),
              ),
              // TableRowData(title: "REGISTER / LOGIN"),
            ],
          ),
        ),
      ],
    );
  }
}
