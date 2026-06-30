import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:share_plus/share_plus.dart';

class ShareButtonWidget extends StatelessWidget {
  /// Widget ShareButtonWidget : enable share the website link
  ///
  /// Deps: share_plus
  const ShareButtonWidget({super.key});

  final String site = "https://sengthaite.github.io/";

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        SharePlus.instance.share(ShareParams(uri: Uri.parse(site)));
      },
      color: context.pfTheme.buttonBgColor,
      icon: Icon(Icons.share_outlined, color: context.pfTheme.buttonFgColor),
    );
  }
}
