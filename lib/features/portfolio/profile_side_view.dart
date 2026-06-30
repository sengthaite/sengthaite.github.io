import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';
import 'package:sengthaite_blog/helper/common.dart';
import 'package:styled_text/styled_text.dart';

sealed class ProfileColumnViewConstants extends StatelessWidget {
  final double professionalSummaryMaxWidth = 600;
  final iconTextPadding = EdgeInsets.fromLTRB(20, 13, 35, 13);
  final String linkedIn = "https://www.linkedin.com/in/te-sengthai-29b661191/";
  final String github = "https://github.com/sengthaite";
  final String telegram = "https://t.me/sengthaite";
  final String email = "sengthaite@gmail.com";
  final String phone = "+855 88 397 9644";

  ProfileColumnViewConstants({super.key});
}

class ProfileSideView extends StatelessWidget {
  /// Widget ProfileSideView : wrapper of the whole profile side including image, leadership, summary, and contact
  const ProfileSideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 2, child: ProfileColumnView());
  }
}

class ProfileColumnView extends ProfileColumnViewConstants {
  ProfileColumnView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = context.pfTheme.textStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(child: AssetIcons.imageprof.imageWithSize(width: 350)),
        SizedBox(height: 27),
        Text(context.l10n.author, style: context.pfTheme.roleTitleTextStyle),
        SizedBox(height: 8),
        Text(
          context.l10n.leadership_style,
          style: context.pfTheme.roleDetailTextStyle,
        ),
        SizedBox(height: 30),
        Container(
          constraints: BoxConstraints(maxWidth: professionalSummaryMaxWidth),
          padding: EdgeInsets.symmetric(horizontal: 27, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: context.colorScheme.outline),
            borderRadius: BorderRadius.circular(16),
          ),
          child: StyledText(
            style: textStyle,
            text: context.l10n.prof_summary,
            tags: {'b': StyledTextTag(style: textStyle.bold)},
          ),
        ),
        SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 14,
          children: [
            IconButton.filled(
              onPressed: () {},
              padding: iconTextPadding,
              style: context.pfTheme.buttonStyle,
              icon: InkWell(
                onTap: () {
                  final snackBar = SnackBar(
                    content: Text(
                      'Copied Phone number!',
                      style: context.pfTheme.textStyle,
                    ),
                  );
                  context.messenger.showSnackBar(snackBar);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    AssetIcons.phone.imageWithStyle(
                      size: Size(30, 30),
                      color: Color(0xFF00830F),
                    ),
                    Text(phone, style: context.pfTheme.textStyle),
                  ],
                ),
              ),
            ),
            IconButton.filled(
              onPressed: sendEmail,
              padding: iconTextPadding,
              style: context.pfTheme.buttonStyle,
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  AssetIcons.gmail.imageWithStyle(size: Size(30, 30)),
                  Text(email, style: context.pfTheme.textStyle),
                ],
              ),
            ),
            IconButton.filled(
              padding: EdgeInsets.all(12),
              onPressed: () => openLink(linkedIn),
              style: context.pfTheme.buttonStyle,
              icon: AssetIcons.linkedin.imageWithSize(width: 30),
            ),
            IconButton.filled(
              padding: EdgeInsets.all(12),
              onPressed: () => openLink(github),
              style: context.pfTheme.buttonStyle,
              icon: AssetIcons.githubpf.imageWithSize(width: 30),
            ),
            IconButton.filled(
              padding: EdgeInsets.all(12),
              onPressed: () => openLink(telegram),
              style: context.pfTheme.buttonStyle,
              icon: AssetIcons.telegram.imageWithStyle(
                size: Size(30, 30),
                color: Color(0xFF1B92D1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
