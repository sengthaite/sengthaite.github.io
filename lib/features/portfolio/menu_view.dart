import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/menu_button.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/overlay_dropdown.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/radio_buttons.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/table_popup.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';

sealed class MenuNavigationConstants extends StatelessWidget {
  final iconSize = Size(40, 40);
  final Color starColor = Color(0xFFF1B100);

  MenuNavigationConstants({super.key});
}

extension on MenuNavigation {
  // Toggle state show and hide of the dropdown Setting menu button
  void _togglePopUp() {
    controller.toggle();
    isShowingOverlay.value = !isShowingOverlay.value;
    isHome.value = !isShowingOverlay.value;
  }

  // Hide the pop up and reset the style (default selected home)
  void _resetMenuButtonSelection() {
    controller.hide();
    isShowingOverlay.value = false;
    isHome.value = true;
  }

  /// Show feedback dialog
  /// TODO: Integrate with API
  void showFeedback(BuildContext context) {
    _togglePopUp();
    _resetMenuButtonSelection();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(
            "FEEDBACK",
            textAlign: TextAlign.center,
            style: context.pfTheme.menuTextStyle,
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Text(
                  "I'm actively improving this portfolio and would value your perspective - feel free to share any thoughts, no matter how small.",
                  style: context.textTheme.bodyLarge,
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
              child: Text("Cancel", style: context.textTheme.labelMedium),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Submit", style: context.textTheme.labelMedium.bold),
            ),
          ],
        );
      },
    );
  }
}

class MenuNavigation extends MenuNavigationConstants {
  MenuNavigation({super.key});

  final OverlayPortalController controller = OverlayPortalController();
  final ValueNotifier<bool> isShowingOverlay = ValueNotifier(false);
  final ValueNotifier<bool> isHome = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    isHome.value = true;
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        MenuButton(
          text: "HOME",
          icon: AssetIcons.home.imageWithStyle(
            size: iconSize,
            color: context.pfTheme.buttonFgColor,
          ),
          selectedIcon: AssetIcons.home.imageWithStyle(
            size: iconSize,
            color: context.pfTheme.buttonSelectedFgColor,
          ),
          isSelected: isHome,
          onPressed: () {},
        ),
        MenuButton(
          text: "MY BLOG",
          icon: AssetIcons.blog.imageWithStyle(
            size: iconSize,
            color: context.pfTheme.buttonFgColor,
          ),
          selectedIcon: AssetIcons.blog.imageWithStyle(
            size: iconSize,
            color: context.pfTheme.buttonSelectedFgColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/blog");
            _resetMenuButtonSelection();
          },
        ),
        OverlayPopUpDropdown(
          controller: controller,
          onTapOutside: _resetMenuButtonSelection,
          menuButton: MenuButton(
            text: 'SETTINGS',
            onPressed: _togglePopUp,
            isSelected: isShowingOverlay,
            icon: AssetIcons.home.imageWithStyle(
              size: iconSize,
              color: context.pfTheme.buttonFgColor,
            ),
            selectedIcon: AssetIcons.home.imageWithStyle(
              size: iconSize,
              color: context.pfTheme.buttonSelectedFgColor,
            ),
            trailIcon: Icon(
              Icons.keyboard_arrow_down,
              color: context.pfTheme.buttonFgColor,
            ),
            selectedTrailingIcon: Icon(
              Icons.keyboard_arrow_up,
              color: context.pfTheme.buttonSelectedFgColor,
            ),
          ),
          listDropdownWidget: TablePopup(
            rows: [
              TableRowData(
                title: "LANGUAGE",
                widget: RadioButtons(
                  defaultSelectedValue: "ENG",
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
