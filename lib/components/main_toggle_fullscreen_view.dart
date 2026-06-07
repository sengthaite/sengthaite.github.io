import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

import '../shared/data/appsetting.dart';

class ToggleFullscreenView extends StatelessWidget {
  const ToggleFullscreenView({super.key, required this.onSreenStateChange});

  final Function(bool) onSreenStateChange;

  @override
  Widget build(BuildContext context) {
    AppSettings? appSettings = AppData().appSettings;
    var newScreenState = !(appSettings?.isFullScreenMode ?? false);
    return FloatingActionButton.small(
      elevation: 1,
      onPressed: () {
        onSreenStateChange(newScreenState);
        appSettings?.isFullScreenMode = newScreenState;
        AppData().saveAppSettings();
      },
      child: Icon(
        newScreenState ? MdiIcons.arrowExpand : MdiIcons.arrowExpandAll,
      ),
    );
  }
}
