import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/menu_button.dart';

class OverlayPopUpDropdown extends StatelessWidget {
  OverlayPopUpDropdown({
    super.key,
    required this.controller,
    required this.menuButton,
    required this.listDropdownWidget,
    this.onTapOutside,
  });

  final OverlayPortalController controller;
  final _groupId = "tap_group";
  final LayerLink link = LayerLink();

  final MenuButton menuButton;
  final Widget listDropdownWidget;
  final VoidCallback? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) => TapRegion(
        groupId: _groupId,
        child: UnconstrainedBox(
          child: CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: const Offset(0, 12),
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            child: listDropdownWidget,
          ),
        ),
      ),

      child: CompositedTransformTarget(
        link: link,
        child: TapRegion(
          onTapOutside: (event) => onTapOutside?.call(),
          groupId: _groupId,
          child: menuButton,
        ),
      ),
    );
  }
}
