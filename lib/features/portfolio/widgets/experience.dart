import 'package:flutter/material.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/content_page.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/experience_content_page.dart';

class ExperiencePageView extends StatefulWidget {
  /// Widget ExperiencePageView : show the whole experience in pageview
  ///
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
              data: data
                  .map(
                    (content) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ExperienceWidget(data: content),
                    ),
                  )
                  .toList(),
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
