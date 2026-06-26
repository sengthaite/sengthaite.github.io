import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';
import 'package:sengthaite_blog/helper/common.dart';
import 'package:styled_text/styled_text.dart';

var _profile = (
  name: "Te Sengthai",
  leadershipStyle:
      "Transformational, Visionary, Laissez-Faire, Servant, Pacesetting",
  whoami:
      "With nearly <b>6 years of experience</b> in a dynamic Fintech company, I bring 3 core values: <b>adaptability</b> in agile environments through cross-functional communication, proactive <b>collaboration</b> driving team success via initiative and innovative problem-solving, and <b>continuous growth</b> aligned with organizational vision for sustained impact.",
  phone: "+855 88 397 9644",
  contacts: {
    "linkedIn": "https://www.linkedin.com/in/te-sengthai-29b661191/",
    "github": "https://github.com/sengthaite",
    "telegram": "https://t.me/sengthaite",
    "email": "sengthaite@gmail.com",
  },
);

sealed class ProfileSideViewConstants extends StatelessWidget {
  final double professionalSummaryMaxWidth = 600;
  final iconTextPadding = EdgeInsets.fromLTRB(20, 13, 35, 13);
  ProfileSideViewConstants({super.key});
}

class ProfileSideView extends ProfileSideViewConstants {
  ProfileSideView({super.key});

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
          Text(_profile.name, style: context.pfTheme.roleTitleTextStyle),
          SizedBox(height: 8),
          Text(
            _profile.leadershipStyle,
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
              text: _profile.whoami,
              tags: {'b': StyledTextTag(style: textStyle.bold)},
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
                      Text(_profile.phone, style: context.pfTheme.textStyle),
                    ],
                  ),
                ),
              ),
              IconButton.filled(
                padding: EdgeInsets.all(4),
                onPressed: () => openLink(_profile.contacts["linkedIn"]),
                style: context.pfTheme.buttonStyle,
                icon: AssetIcons.linkedin.imageWithSize(width: 30),
              ),
              IconButton.filled(
                padding: EdgeInsets.all(4),
                onPressed: () => openLink(_profile.contacts["github"]),
                style: context.pfTheme.buttonStyle,
                icon: AssetIcons.githubpf.imageWithSize(width: 30),
              ),
              IconButton.filled(
                padding: EdgeInsets.all(4),
                onPressed: () => openLink(_profile.contacts["telegram"]),
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
                      _profile.contacts["email"] ?? '-',
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
