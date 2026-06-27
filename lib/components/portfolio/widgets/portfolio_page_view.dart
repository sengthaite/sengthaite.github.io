import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/content_page.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/content_side_nav_view.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

extension on BuildContext {
  double get svgSize => 900;
  List<ContentPageData> get experienceData => [
    ContentPageData(
      roleTitle: l10n.title_mngr_mb,
      description: l10n.mngr_desc,
      skillLists: [
        TitleWidget(title: l10n.role_delivery_lead, widget: Icons.groups),
        TitleWidget(title: l10n.duration_weeks(3, ''), widget: Icons.timer),
        TitleWidget(title: l10n.work_dynamic_setup, widget: Icons.web),
        TitleWidget(
          title: l10n.team_size(4),
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: l10n.exp_bill,
      trailingMetricTitle: "(${l10n.biller_size(20)})",
      skills: l10n.skill_bill,
      content: AssetIcons.billpayments.imageWithSize(width: svgSize),
      platforms: ["Web Angular", "Excel Progress Tracking", "OneDrive"],
    ),
    ContentPageData(
      roleTitle: l10n.title_mngr_mb,
      description: l10n.mngr_desc,
      skillLists: [
        TitleWidget(title: l10n.role_team_builder, widget: Icons.groups),
        TitleWidget(title: l10n.duration_quarter(2, ''), widget: Icons.timer),
        TitleWidget(title: l10n.work_hr_process, widget: Icons.web),
        TitleWidget(
          title: l10n.committee_size(3),
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: l10n.exp_build_team,
      trailingMetricTitle: "(${l10n.direct_report_size(8)})",
      skills: l10n.skill_build_team,
      content: AssetIcons.candidateselection.imageWithSize(width: svgSize),
      platforms: ["Web Angular", "Excel Progress Tracking", "OneDrive"],
    ),
    ContentPageData(
      roleTitle: l10n.title_mngr_mb,
      description: l10n.mngr_desc,
      skillLists: [
        TitleWidget(title: l10n.role_coordinator_support, widget: Icons.groups),
        TitleWidget(title: l10n.duration_weeks(4, ''), widget: Icons.timer),
        TitleWidget(title: l10n.work_nbc, widget: Icons.web),
        TitleWidget(
          title: l10n.team_size(3),
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: l10n.exp_khqr,
      skills: l10n.skill_khqr,
      content: AssetIcons.khqrexperience.imageWithSize(width: svgSize),
      platforms: ["Figma Design", "Bakong PG", "TestFlight", "Firebase"],
    ),
    ContentPageData(
      roleTitle: l10n.title_mngr_mb,
      description: l10n.mngr_desc,
      skillLists: [
        TitleWidget(title: l10n.role_developer_techlead, widget: Icons.groups),
        TitleWidget(title: l10n.duration_months(2, ''), widget: Icons.timer),
        TitleWidget(title: l10n.work_automated_testing, widget: Icons.web),
        TitleWidget(
          title: l10n.team_size(3),
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: l10n.exp_automate_testing,
      skills: l10n.skill_automate_testing,
      content: AssetIcons.automatedtesting.imageWithSize(width: svgSize),
      platforms: ["Katalon", "Java Groovy", "Excel Plugin"],
    ),
    ContentPageData(
      roleTitle: l10n.title_mngr_mb,
      description: l10n.mngr_desc,
      skillLists: [
        TitleWidget(title: l10n.role_coordinator_support, widget: Icons.groups),
        TitleWidget(title: l10n.duration_weeks(1, ''), widget: Icons.timer),
        TitleWidget(title: l10n.work_customer_campaign, widget: Icons.web),
        TitleWidget(
          title: l10n.team_size(3),
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: l10n.exp_universal_link,
      skills: l10n.skill_universal_link,
      content: AssetIcons.universallink.imageWithSize(width: svgSize),
      platforms: ["AppsFlyer Onelink", "Web Angular"],
    ),
    ContentPageData(
      roleTitle: l10n.title_mngr_mb,
      description: l10n.mngr_desc,
      skillLists: [
        TitleWidget(title: l10n.role_coordinator_support, widget: Icons.groups),
        TitleWidget(title: l10n.duration_weeks(1, ''), widget: Icons.timer),
        TitleWidget(title: l10n.work_security_hardening, widget: Icons.web),
        TitleWidget(
          title: l10n.team_size(3),
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: l10n.exp_hardening,
      skills: l10n.skill_hardening,
      content: AssetIcons.securitysupport.imageWithSize(width: svgSize),
      platforms: ["apksigning", "fastlane", "ironsec shield API"],
    ),
    ContentPageData(
      roleTitle: l10n.title_mngr_mb,
      description: l10n.mngr_desc,
      skillLists: [
        TitleWidget(title: l10n.role_developer, widget: Icons.groups),
        TitleWidget(title: l10n.duration_months(1, ''), widget: Icons.timer),
        TitleWidget(title: l10n.work_ai_object_detection, widget: Icons.web),
        TitleWidget(
          title: l10n.team_size(4),
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: l10n.exp_liveness,
      skills: l10n.skill_liveness,
      content: AssetIcons.liveness.imageWithSize(width: svgSize),
      platforms: ["GoogleMLKit", "CreateML", "Tensorflow"],
    ),
    ContentPageData(
      roleTitle: l10n.title_sup_frontend,
      description: l10n.sup_desc,
      skillLists: [
        TitleWidget(title: l10n.role_developer_techlead, widget: Icons.groups),
        TitleWidget(title: l10n.duration_months(2, ''), widget: Icons.timer),
        TitleWidget(title: l10n.work_loan_implementation, widget: Icons.web),
        TitleWidget(
          title: l10n.team_size(2),
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: l10n.exp_loan_implementation,
      skills: l10n.skill_loan_implementation,
      content: AssetIcons.smeloan.imageWithSize(width: svgSize),
      platforms: ["Figma", "Angular Web", "Flutter"],
    ),
    ContentPageData(
      roleTitle: l10n.title_senior_frontend,
      description: l10n.senior_desc,
      skillLists: [
        TitleWidget(title: l10n.role_developer, widget: Icons.groups),
        TitleWidget(title: "N/A", widget: Icons.timer),
        TitleWidget(title: l10n.work_development_support, widget: Icons.web),
        TitleWidget(
          title: l10n.team_size(2),
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: l10n.exp_loan_releated,
      skills: l10n.skill_loan_related,
      content: AssetIcons.otherloanenhancements.imageWithSize(width: svgSize),
      platforms: ["Figma", "Angular Web", "Flutter"],
    ),
    ContentPageData(
      roleTitle: l10n.title_ios_dev,
      description: l10n.ios_dev_desc,
      skillLists: [
        TitleWidget(title: l10n.role_developer, widget: Icons.groups),
        TitleWidget(title: "N/A", widget: Icons.timer),
        TitleWidget(title: l10n.work_development, widget: Icons.web),
        TitleWidget(
          title: l10n.team_size(2),
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: l10n.exp_z1_zpoint,
      skills: l10n.skill_z1_zpoint,
      content: AssetIcons.z1.imageWithSize(width: svgSize),
      platforms: ["iOS Swift UIKit", "XCode"],
    ),
  ];
}

class PortfolioPageView extends StatefulWidget {
  const PortfolioPageView({super.key});

  @override
  State<PortfolioPageView> createState() => _PortfolioPageViewState();
}

class _PortfolioPageViewState extends State<PortfolioPageView> {
  final PageController experiencePageController = PageController(
    initialPage: 0,
    viewportFraction: 0.95,
  );

  final PageController educationPageController = PageController(
    initialPage: 0,
    viewportFraction: 0.95,
  );

  final ValueNotifier<ContentSideSection> type = ValueNotifier(
    ContentSideSection.experience,
  );

  final ValueNotifier<int> currentPageExperience = ValueNotifier(0);

  final List<Widget> educations = [
    AssetIcons.bachelor.image,
    AssetIcons.itday.image,
    AssetIcons.peermentor.image,
    AssetIcons.volunteeryvsd.image,
  ];

  final ValueNotifier<int> currentEducation = ValueNotifier(0);

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
          children: [
            ContentSideNav(
              onSelected: (newSelectionType) => type.value = newSelectionType,
            ),
            ValueListenableBuilder(
              valueListenable: type,
              builder: (context, value, child) {
                switch (value) {
                  case ContentSideSection.experience:
                    return ExperiencePageView(
                      currentPageExperience: currentPageExperience,
                      experienceData: context.experienceData,
                      pageController: experiencePageController,
                      totalExperience: context.experienceData.length,
                    );
                  case ContentSideSection.education:
                    return EducationView(
                      currentEducation: currentEducation,
                      educations: educations,
                      educationPageController: educationPageController,
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EducationView extends StatelessWidget {
  const EducationView({
    super.key,
    required this.currentEducation,
    required this.educations,
    required this.educationPageController,
  });

  final ValueNotifier<int> currentEducation;
  final List<Widget> educations;
  final PageController educationPageController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ContentPage(
              defaultSelection: currentEducation.value,
              data: educations,
              controller: educationPageController,
              onPageChanged: (index) => currentEducation.value = index,
            ),
          ),
        ],
      ),
    );
  }
}

class ExperiencePageView extends StatelessWidget {
  const ExperiencePageView({
    super.key,
    required this.currentPageExperience,
    required this.experienceData,
    required this.pageController,
    required this.totalExperience,
  });

  final ValueNotifier<int> currentPageExperience;
  final List<ContentPageData> experienceData;
  final PageController pageController;
  final int totalExperience;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ContentPage(
              defaultSelection: currentPageExperience.value,
              data: experienceData
                  .map((content) => content.pageContentView())
                  .toList(),
              controller: pageController,
              onPageChanged: (index) => currentPageExperience.value = index,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: currentPageExperience,
            builder: (context, index, widget) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24, right: 24),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: context.l10n.page),
                        TextSpan(
                          text: " ${index + 1}",
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
              );
            },
          ),
        ],
      ),
    );
  }
}
