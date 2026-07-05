import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/feedback_dialog.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/menu_button.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/overlay_dropdown.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/radio_buttons.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/table_popup.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

class MenuNavigation extends StatefulWidget {
  /// Widget MenuNavigation : show the three navigation button HOME, BLOG, and SETTINGS
  ///
  /// HOME : double click scroll to top
  /// Blog : redirect to blog website
  /// SETTINGS : enable switch font, change display mode (light, dark), and provide feedback
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
        if (context.orientation == Orientation.landscape)
          getSettingDropdownButton(context),
        if (context.orientation == Orientation.portrait)
          MenuButton(
            text: context.l10n.settings.toUpperCase(),
            onPressed: () {
              showModalBottomSheet<Widget>(
                context: context,
                useSafeArea: true,
                showDragHandle: true,
                backgroundColor: context.pfTheme.containerBgColor,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: getSettingRowData(context, dismissOnChange: true),
                    ),
                  );
                },
              );
            },
            isSelected: isShowingOverlay,
            icon: AssetIcons.home.imageWithStyle(
              size: iconSize,
              color: context.pfTheme.buttonFgColor,
            ),
            selectedIcon: AssetIcons.home.imageWithStyle(
              size: iconSize,
              color: context.pfTheme.buttonSelectedFgColor,
            ),
          ),
      ],
    );
  }

  OverlayPopUpDropdown getSettingDropdownButton(BuildContext context) {
    return OverlayPopUpDropdown(
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
      listDropdownWidget: getSettingRowData(context),
    );
  }

  TablePopup getSettingRowData(
    BuildContext context, {
    bool dismissOnChange = false,
  }) {
    return TablePopup(
      rows: [
        TableRowData(
          title: context.l10n.language.toUpperCase(),
          widget: RadioButtons(
            defaultSelectedValue: context.appSettings.currentLocale.value,
            onSelectedValueChange: (newLocale) {
              if (dismissOnChange) {
                context.navState.pop();
              }
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
            defaultSelectedValue: context.appSettings.currentThemeMode.value,
            onSelectedValueChange: (themeMode) {
              if (dismissOnChange) {
                context.navState.pop();
              }
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
          onPress: () {
            if (dismissOnChange) {
              context.navState.pop();
            }
            showFeedback(context);
          },
        ),
        // TableRowData(title: "REGISTER / LOGIN"),
      ],
    );
  }
}
