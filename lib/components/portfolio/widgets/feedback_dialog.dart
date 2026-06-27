import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: Text(
        context.l10n.feedback.toUpperCase(),
        textAlign: TextAlign.center,
        style: context.pfTheme.feedbackTitleStyle,
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Text(
              context.l10n.feedback_title,
              style: context.pfTheme.feedbackSubTitleStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: context.pfTheme.starColor, size: 56),
                Icon(Icons.star, color: context.pfTheme.starColor, size: 56),
                Icon(Icons.star, color: context.pfTheme.starColor, size: 56),
                Icon(Icons.star, color: context.pfTheme.starColor, size: 56),
                Icon(Icons.star, size: 56),
              ],
            ),
            TextField(
              obscureText: true,
              style: context.pfTheme.feedbackInputStyle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: context.l10n.username_email,
              ),
            ),
            TextField(
              maxLines: 4,
              style: context.pfTheme.feedbackInputStyle,
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
