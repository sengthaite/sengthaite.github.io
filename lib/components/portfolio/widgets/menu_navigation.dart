import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/feedback_dialog.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/menu_button.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/overlay_dropdown.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/radio_buttons.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/table_popup.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

class MenuNavigation extends StatefulWidget {
  const MenuNavigation({super.key, this.overlayDirection});

  final OverlayDirection? overlayDirection;

  @override
  State<MenuNavigation> createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  final iconSize = Size(40, 40);

  final OverlayPortalController controller = OverlayPortalController();

  final ValueNotifier<bool> isShowingOverlay = ValueNotifier(false);

  final ValueNotifier<bool> isHome = ValueNotifier(true);

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
    showDialog<FeedbackDialog>(
      context: context,
      builder: (context) {
        return FeedbackDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MenuButton(
          text: context.l10n.home.toUpperCase(),
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
          text: context.l10n.my_blog.toUpperCase(),
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
          direction: widget.overlayDirection,
          menuButton: MenuButton(
            text: context.l10n.settings.toUpperCase(),
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
                title: context.l10n.language.toUpperCase(),
                widget: RadioButtons(
                  defaultSelectedValue: context.appSettings.currentLocale.value,
                  onSelectedValueChange: (newLocale) {
                    context.appSettings.locale = newLocale as Locale;
                    AppData().saveAppSettings();
                  },
                  list: [
                    RadioButtonData(
                      text: context.l10n.khmer_lang,
                      value: Locale('km'),
                    ),
                    RadioButtonData(
                      text: context.l10n.english_lang,
                      value: Locale('en'),
                    ),
                  ],
                ),
              ),
              TableRowData(
                title: context.l10n.display,
                widget: RadioButtons<ThemeMode>(
                  defaultSelectedValue:
                      context.appSettings.currentThemeMode.value,
                  onSelectedValueChange: (themeMode) {
                    context.appSettings.newThemeMode = themeMode;
                    AppData().saveAppSettings();
                  },
                  list: [
                    RadioButtonData(
                      text: context.l10n.light_mode,
                      value: ThemeMode.light,
                    ),
                    RadioButtonData(
                      text: context.l10n.dark_mode,
                      value: ThemeMode.dark,
                    ),
                    RadioButtonData(
                      text: context.l10n.system_mode,
                      value: ThemeMode.system,
                    ),
                  ],
                ),
              ),
              // TableRowData(title: "DEMOS"),
              TableRowData(
                title: context.l10n.feedback,
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
