import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/constants/portfolio_theme.dart';
import 'package:sengthaite_blog/extensions/locale_ext.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/content_page.dart';
import 'package:sengthaite_blog/l10n/app_localizations.dart';
import 'package:sengthaite_blog/shared/app.data.dart';
import 'package:sengthaite_blog/shared/data/appsetting.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  PortfolioTheme get pfTheme => theme.extension<PortfolioTheme>()!;

  Orientation get orientation => MediaQuery.orientationOf(this);

  AppLocalizations get l10n => AppLocalizations.of(this)!;

  Size get screenSize => MediaQuery.sizeOf(this);

  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);

  AppSettings get appSettings => AppData().appSettings!;

  Locale get currentLocale => Localizations.localeOf(this);

  List<Widget> get educationData => [
    AssetIcons.bachelor.image,
    AssetIcons.itday.image,
    AssetIcons.peermentor.image,
    AssetIcons.volunteeryvsd.image,
  ];

  double get svgSize => 1000;
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
      activityMainInformation: l10n.exp_bill,
      trailingMetricTitle: "(${l10n.biller_size(20)})",
      skills: l10n.skill_bill,
      content: currentLocale.billPayments.imageWithSize(width: svgSize),
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
      activityMainInformation: l10n.exp_build_team,
      trailingMetricTitle: "(${l10n.direct_report_size(8)})",
      skills: l10n.skill_build_team,
      content: currentLocale.candidateSelection.imageWithSize(width: svgSize),
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
      activityMainInformation: l10n.exp_khqr,
      skills: l10n.skill_khqr,
      content: currentLocale.khqrExperience.imageWithSize(width: svgSize),
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
      activityMainInformation: l10n.exp_automate_testing,
      skills: l10n.skill_automate_testing,
      content: currentLocale.automatedTesting.imageWithSize(width: svgSize),
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
      activityMainInformation: l10n.exp_universal_link,
      skills: l10n.skill_universal_link,
      content: currentLocale.universalLink.imageWithSize(width: svgSize),
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
      activityMainInformation: l10n.exp_hardening,
      skills: l10n.skill_hardening,
      content: currentLocale.securitySupport.imageWithSize(width: svgSize),
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
      activityMainInformation: l10n.exp_liveness,
      skills: l10n.skill_liveness,
      content: currentLocale.liveness.imageWithSize(width: svgSize),
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
      activityMainInformation: l10n.exp_loan_implementation,
      skills: l10n.skill_loan_implementation,
      content: currentLocale.loanImplementation.imageWithSize(width: svgSize),
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
      activityMainInformation: l10n.exp_loan_releated,
      skills: l10n.skill_loan_related,
      content: currentLocale.loanRelated.imageWithSize(width: svgSize),
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
      activityMainInformation: l10n.exp_z1_zpoint,
      skills: l10n.skill_z1_zpoint,
      content: currentLocale.iosDevZ1.imageWithSize(width: svgSize),
      platforms: ["iOS Swift UIKit", "XCode"],
    ),
  ];
}
