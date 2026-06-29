import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/content_page.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/portfolio_detail_tab_view.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/share_button_site.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

enum ContentSideSection { experience, education }

class PortfolioPageView extends StatefulWidget {
  const PortfolioPageView({super.key});

  @override
  State<PortfolioPageView> createState() => _PortfolioPageViewState();
}

class _PortfolioPageViewState extends State<PortfolioPageView> {
  ContentSideSection type = ContentSideSection.experience;
  int currentExperiencePage = 0;
  int currentEducationPage = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black26),
            BoxShadow(
              offset: Offset(0, 4),
              spreadRadius: -1.0,
              blurRadius: 5.0,
              color: context.pfTheme.containerBgColor,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PortfolioDetailTabView(
                      onSelected: (selected) => setState(() => type = selected),
                    ),
                    ShareButtonWidget(),
                  ],
                ),
              ),
            ),
            if (type == ContentSideSection.experience)
              ExperiencePageView(
                currentPageExperience: currentExperiencePage,
                onPageChanged: (page) => currentExperiencePage = page,
              ),
            if (type == ContentSideSection.education)
              EducationView(
                currentPage: currentEducationPage,
                onPageChanged: (page) => currentEducationPage = page,
              ),
          ],
        ),
      ),
    );
  }
}

class EducationView extends StatefulWidget {
  const EducationView({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
  });

  final int currentPage;
  final ValueCallback<int> onPageChanged;

  @override
  State<EducationView> createState() => _EducationViewState();
}

class _EducationViewState extends State<EducationView> {
  int currentPage = 0;
  late PageController controller;

  @override
  void initState() {
    currentPage = widget.currentPage;
    controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.95,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ContentPage(
              data: context.educationData,
              controller: controller,
              onPageChanged: (index) {
                widget.onPageChanged.call(index);
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ExperiencePageView extends StatefulWidget {
  const ExperiencePageView({
    super.key,
    required this.currentPageExperience,
    required this.onPageChanged,
  });

  final int currentPageExperience;
  final ValueCallback<int> onPageChanged;

  @override
  State<ExperiencePageView> createState() => _ExperiencePageViewState();
}

class _ExperiencePageViewState extends State<ExperiencePageView> {
  late PageController pageController;

  int currentPage = 0;

  @override
  void initState() {
    currentPage = widget.currentPageExperience;
    pageController = PageController(
      initialPage: currentPage,
      viewportFraction: 0.95,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.experienceData;
    var totalExperience = data.length;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ContentPage(
              data: data.map((content) => content.pageContentView()).toList(),
              controller: pageController,
              onPageChanged: (index) {
                widget.onPageChanged.call(index);
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24, right: 24),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: context.l10n.page),
                    TextSpan(
                      text: " ${currentPage + 1}",
                      style: context.pfTheme.textStyle.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                    TextSpan(text: " / $totalExperience"),
                  ],
                ),
                style: context.pfTheme.textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
