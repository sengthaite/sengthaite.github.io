import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';
import 'package:sengthaite_blog/helper/common.dart';

sealed class ProfileSideViewConstants extends StatelessWidget {
  final double professionalSummaryMaxWidth = 600;
  const ProfileSideViewConstants({super.key});
}

class ProfileSideView extends ProfileSideViewConstants {
  ProfileSideView({super.key});

  final iconTextPadding = EdgeInsets.fromLTRB(20, 13, 35, 13);

  @override
  Widget build(BuildContext context) {
    final textStyle = context.pfTheme.textStyle;

    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(child: AssetIcons.imageprof.imageWithSize(width: 350)),
          SizedBox(height: 27),
          Text("TE SENGTHAI", style: context.pfTheme.roleTitleTextStyle),
          SizedBox(height: 8),
          Text(
            "Transformational, Visionary, Laissez-Faire, Servant, Pacesetting",
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
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "With nearly", style: textStyle),
                  TextSpan(
                    text: " 6 years of experience",
                    style: textStyle.bold,
                  ),
                  TextSpan(
                    text:
                        " in a dynamic Fintech company, I bring 3 core values:",
                    style: textStyle,
                  ),
                  TextSpan(text: " adaptability", style: textStyle.bold),
                  TextSpan(
                    text:
                        " in agile environments through cross-functional communication, proactive",
                    style: textStyle,
                  ),
                  TextSpan(text: " collaboration", style: textStyle.bold),
                  TextSpan(
                    text:
                        " driving team success via initiative and innovative problem-solving, and",
                    style: textStyle,
                  ),
                  TextSpan(text: " continuous growth", style: textStyle.bold),
                  TextSpan(
                    text:
                        " aligned with organizational vision for sustained impact.",
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Wrap(
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
                      Text(
                        "+855 88 397 9644",
                        style: context.pfTheme.textStyle,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton.filled(
                onPressed: () => openLink(
                  "https://www.linkedin.com/in/te-sengthai-29b661191/",
                ),
                style: context.pfTheme.buttonStyle,
                icon: AssetIcons.linkedin.imageWithSize(width: 30),
              ),
              IconButton.filled(
                onPressed: () => openLink("https://github.com/sengthaite"),
                style: context.pfTheme.buttonStyle,
                icon: AssetIcons.githubpf.imageWithSize(width: 30),
              ),
              IconButton.filled(
                onPressed: () => openLink("https://t.me/sengthaite"),
                style: context.pfTheme.buttonStyle,
                icon: AssetIcons.telegram.imageWithStyle(
                  size: Size(30, 30),
                  color: Color(0xFF1B92D1),
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
                    Text(
                      "sengthaite@gmail.com",
                      style: context.pfTheme.textStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
