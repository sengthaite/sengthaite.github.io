import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/education.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/experience.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/portfolio_tab_bar.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/share_button_site.dart';

enum ContentSideSection { experience, education }

class PortfolioPageView extends StatefulWidget {
  /// Widget PortfolioPageView : switch between the experiences, ceritificates or education
  ///
  /// The current page index is preserved when switch back and forth
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
                    PortfolioTabBar(
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
