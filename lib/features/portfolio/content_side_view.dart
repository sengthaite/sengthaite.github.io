import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/menu_button.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/text_menu_button.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';
import 'package:sengthaite_blog/features/portfolio/content_page.dart';
import 'package:sengthaite_blog/features/portfolio/content_side_nav_view.dart';
import 'package:sengthaite_blog/features/portfolio/menu_view.dart';

// @Preview(name: "ContentSideView")
// Widget contentSidePreview() {
//   return Scaffold(body: ContentSideView());
// }

class ContentSideView extends StatefulWidget {
  const ContentSideView({super.key});

  @override
  State<ContentSideView> createState() => _ContentSideViewState();
}

class _ContentSideViewState extends State<ContentSideView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          MenuNavigation(),
          SizedBox(height: 40),
          InsideContentWidget(),
        ],
      ),
    );
  }
}

class InsideContentWidget extends StatelessWidget {
  InsideContentWidget({super.key});

  final bodyContentSideDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(color: Colors.black26),
      BoxShadow(
        offset: Offset(0, 4),
        spreadRadius: -1.0,
        blurRadius: 5.0,
        color: backgroundColor,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: bodyContentSideDecoration,
        child: Expanded(
          child: Column(
            children: [
              ContentSideNav(),
              Expanded(
                child: ContentPage(
                  data: [
                    ContentPageData(
                      roleTitle: "Mngr. Mobile Banking Development",
                      description: "Oct 2024 - May 2026 | Amret MFI",
                      skillLists: [
                        {
                          "title": Expanded(
                            child: Text(
                              "Delivery Lead",
                              maxLines: 2,
                              style: textStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          "widget": Icon(
                            Icons.groups,
                            size: 24,
                            color: buttonIconColor,
                          ),
                        },
                        {
                          "title": Expanded(
                            child: Text(
                              "Each Cycle 3 Weeks",
                              maxLines: 2,
                              style: textStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          "widget": Icon(
                            Icons.timer,
                            size: 24,
                            color: buttonIconColor,
                          ),
                        },
                      ],
                      experienceTitle:
                          "Multiple Bill Payments Integration and Configuration",
                      trailingMetricTitle: "(20 Billers)",
                      skills: "SDLC",
                      content: AssetIcons.billpayments.imageWithSize(700),
                      platforms: [
                        "Web Angular",
                        "Excel Progress Tracking",
                        "OneDrive",
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
