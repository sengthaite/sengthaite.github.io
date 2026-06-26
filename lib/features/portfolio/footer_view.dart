import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class FooterView extends StatelessWidget {
  const FooterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: context.pfTheme.containerBgColor,
      ),
      padding: EdgeInsets.all(16.0),
      child: Text(
        context.l10n.publish_footer(2026),
        style: context.pfTheme.textStyle,
      ),
    );
  }
}
