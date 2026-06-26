import 'package:flutter/material.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

import '../../shared/data/appsetting.dart';

class ToggleFullscreenView extends StatelessWidget {
  const ToggleFullscreenView({super.key, required this.onSreenStateChange});

  final void Function(bool) onSreenStateChange;

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
      child: Icon(newScreenState ? Icons.zoom_out : Icons.zoom_in),
    );
  }
}
