import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';

class FeedbackDialog extends StatelessWidget {
  FeedbackDialog({super.key});

  final Color starColor = Color(0xFFF1B100);

  @override
  Widget build(BuildContext context) {
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
              context.l10n.feedback_title,
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
                labelText: context.l10n.username_email,
              ),
            ),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: context.l10n.comment,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            context.l10n.cancel,
            style: context.textTheme.labelMedium,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            context.l10n.submit,
            style: context.textTheme.labelMedium.bold,
          ),
        ),
      ],
    );
  }
}
