import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/menu_button.dart';

enum OverlayDirection { down, up }

class OverlayPopUpDropdown extends StatelessWidget {
  OverlayPopUpDropdown({
    super.key,
    required this.controller,
    required this.menuButton,
    required this.listDropdownWidget,
    this.onTapOutside,
    this.direction = OverlayDirection.down,
  });

  final OverlayPortalController controller;
  final _groupId = "tap_group";
  final LayerLink link = LayerLink();

  final MenuButton menuButton;
  final Widget listDropdownWidget;
  final VoidCallback? onTapOutside;
  final OverlayDirection? direction;

  @override
  Widget build(BuildContext context) {
    Offset offset = Offset(-100, -270);
    switch (direction) {
      case OverlayDirection.up:
        offset = Offset(-100, -270);
        break;
      case OverlayDirection.down:
        offset = Offset(0, 12);
        break;
      case null:
        break;
    }
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) => TapRegion(
        groupId: _groupId,
        child: UnconstrainedBox(
          child: CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: offset,
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
