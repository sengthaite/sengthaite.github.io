import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

class ProfileSideView extends StatelessWidget {
  const ProfileSideView({super.key});

  @override
  Widget build(BuildContext context) {
    final iconButtonStyle = menuButtonStyle.copyWith(
      padding: WidgetStatePropertyAll(EdgeInsets.all(13)),
    );
    final iconTextPadding = EdgeInsets.fromLTRB(20, 13, 35, 13);
    final textStyleBold = textStyle.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final textStyleDefault = textStyle.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
    final double maxWidth = 600;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(child: AssetIcons.imageprof.imageWithSize(400)),
          SizedBox(height: 27),
          Text("TE SENGTHAI", style: textStyleBold.copyWith(fontSize: 40)),
          SizedBox(height: 8),
          Text(
            "Transformational, Visionary, Laissez-Faire, Servant, Pacesetting",
            style: textStyle.copyWith(fontSize: 18),
          ),
          SizedBox(height: 30),
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            padding: EdgeInsets.symmetric(horizontal: 27, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: borderColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "With nearly", style: textStyleDefault),
                  TextSpan(
                    text: " 6 years of experience",
                    style: textStyleBold,
                  ),
                  TextSpan(
                    text:
                        " in a dynamic Fintech company, I bring 3 core values:",
                    style: textStyleDefault,
                  ),
                  TextSpan(text: " adaptability", style: textStyleBold),
                  TextSpan(
                    text:
                        " in agile environments through cross-functional communication, proactive",
                    style: textStyleDefault,
                  ),
                  TextSpan(text: " collaboration", style: textStyleBold),
                  TextSpan(
                    text:
                        " driving team success via initiative and innovative problem-solving, and",
                    style: textStyleDefault,
                  ),
                  TextSpan(text: " continuous growth", style: textStyleBold),
                  TextSpan(
                    text:
                        " aligned with organizational vision for sustained impact.",
                    style: textStyleDefault,
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
                style: menuButtonStyle,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    AssetIcons.phone.imageWithStyle(
                      size: Size(30, 30),
                      color: Color(0xFF00830F),
                    ),
                    Text(
                      "+855 88 397 9644",
                      style: menuButtonTitleStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton.filled(
                onPressed: () {},
                style: iconButtonStyle,
                icon: AssetIcons.linkedin.imageWithSize(30),
              ),
              IconButton.filled(
                onPressed: () {},
                style: iconButtonStyle,
                icon: AssetIcons.githubpf.imageWithSize(30),
              ),
              IconButton.filled(
                onPressed: () {},
                style: iconButtonStyle,
                icon: AssetIcons.telegram.imageWithStyle(
                  size: Size(30, 30),
                  color: Color(0xFF1B92D1),
                ),
              ),
              IconButton.filled(
                onPressed: () {},
                padding: iconTextPadding,
                style: menuButtonStyle,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    AssetIcons.gmail.imageWithStyle(size: Size(30, 30)),
                    Text(
                      "sengthaite@gmail.com",
                      style: menuButtonTitleStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
