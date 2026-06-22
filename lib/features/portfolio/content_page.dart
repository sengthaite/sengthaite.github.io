import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

extension on List<Map<String, Widget>> {
  Column getSkillListColumn() {
    return Column(
      spacing: 5,
      children: map((e) {
        return Container(
          width: 110,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1),
            color: Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [e["widget"]!, e["title"]!],
          ),
        );
      }).toList(),
    );
  }
}

extension on List<String> {
  Row getPlatformRow() {
    return Row(
      spacing: 6,
      children: map((e) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            e,
            style: textStyle.copyWith(fontSize: 8, fontWeight: FontWeight.w400),
          ),
        );
      }).toList(),
    );
  }
}

class ContentPageData {
  final String roleTitle;
  final String description;
  final List<Map<String, Widget>> skillLists;

  final String experienceTitle;
  final String trailingMetricTitle;
  final String skills;

  final Widget content;

  final List<String> platforms;

  ContentPageData({
    required this.roleTitle,
    required this.description,
    required this.skillLists,
    required this.experienceTitle,
    required this.trailingMetricTitle,
    required this.skills,
    required this.content,
    required this.platforms,
  });

  Widget pageContentView() {
    return PageContentView(data: this);
  }

  factory ContentPageData.fromJson(Map<String, dynamic> json) {
    return ContentPageData(
      roleTitle: json['roleTitle'],
      description: json['description'],
      skillLists: [],
      experienceTitle: '',
      trailingMetricTitle: '',
      skills: '',
      content: Text(""),
      platforms: [],
    );
  }

  // 2. Convert User Object to Map
  Map<String, dynamic> toJson() {
    return {};
  }
}

class ContentPage extends StatefulWidget {
  const ContentPage({super.key, required this.data});

  final List<ContentPageData> data;

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return Center(child: Text("Empty Content", style: textStyle));
    }
    List<Widget> pageView = widget.data
        .map((content) => content.pageContentView())
        .toList();
    return PageView(
      controller: pageController,
      allowImplicitScrolling: false,
      physics: PageScrollPhysics(),
      padEnds: false,
      onPageChanged: (int page) {
        setState(() {
          currentPage = page;
        });
      },
      children: pageView,
    );
  }
}

class PageContentView extends StatelessWidget {
  const PageContentView({super.key, required this.data});

  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    final double sideSkillWidth = 140;

    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: sideSkillWidth),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.roleTitle,
                        style: textStyle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data.description,
                        style: textStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: sideSkillWidth,
                child: Container(
                  padding: EdgeInsets.only(top: 12),
                  child: data.skillLists.getSkillListColumn(),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    data.experienceTitle,
                                    maxLines: 3,
                                    style: textStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  data.trailingMetricTitle,
                                  style: textStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 8,
                              children: [
                                Icon(Icons.vpn_key, color: Color(0xFFD40004)),
                                Text(
                                  data.skills,
                                  style: textStyle.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: data.content,
                      ),

                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: Column(
                          spacing: 12,
                          children: [
                            Row(
                              spacing: 5,
                              children: [
                                Icon(
                                  size: 14,
                                  Icons.developer_board,
                                  color: buttonIconColor,
                                ),
                                Text(
                                  "Platform & Tools",
                                  style: textStyle.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            data.platforms.getPlatformRow(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
