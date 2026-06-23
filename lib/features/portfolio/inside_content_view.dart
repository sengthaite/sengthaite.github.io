import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';
import 'package:sengthaite_blog/features/portfolio/content_page.dart';
import 'package:sengthaite_blog/features/portfolio/content_side_nav_view.dart';

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

  final double svgSize = 900;

  final PageController experiencePageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );

  final PageController educationPageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );

  final ValueNotifier<ContentSideSection> type = ValueNotifier(
    ContentSideSection.experience,
  );

  List<ContentPageData> get experienceData => [
    ContentPageData(
      roleTitle: "Mngr. Mobile Banking Development",
      description: "Oct 2024 - May 2026 | Amret MFI",
      skillLists: [
        TitleWidget(title: "Delivery Lead", widget: Icons.groups),
        TitleWidget(title: "3 Weeks per Cycle", widget: Icons.timer),
        TitleWidget(title: "Dynamic Setup", widget: Icons.web),
        TitleWidget(title: "4 Teams", widget: Icons.connect_without_contact),
      ],
      experienceTitle: "Multiple Bill Payments Integration and Configuration",
      trailingMetricTitle: "(20 Billers)",
      skills: "SDLC",
      content: AssetIcons.billpayments.imageWithSize(width: svgSize),
      platforms: ["Web Angular", "Excel Progress Tracking", "OneDrive"],
    ),
    ContentPageData(
      roleTitle: "Mngr. Mobile Banking Development",
      description: "Oct 2024 - May 2026 | Amret MFI",
      skillLists: [
        TitleWidget(title: "Team Builder", widget: Icons.groups),
        TitleWidget(title: "2 Quarters", widget: Icons.timer),
        TitleWidget(title: "HR Process", widget: Icons.web),
        TitleWidget(
          title: "3 Committees",
          widget: Icons.connect_without_contact,
        ),
      ],
      experienceTitle: "Build an Autonomous High-Performing Team",
      trailingMetricTitle: "(8 Direct Reports)",
      skills: "Candidate Selection and Interviewing Process",
      content: AssetIcons.candidateselection.imageWithSize(width: svgSize),
      platforms: ["Web Angular", "Excel Progress Tracking", "OneDrive"],
    ),
    ContentPageData(
      roleTitle: "Mngr. Mobile Banking Development",
      description: "Oct 2024 - May 2026 | Amret MFI",
      skillLists: [
        TitleWidget(title: "Coordinator & Support", widget: Icons.groups),
        TitleWidget(title: "4 Weeks", widget: Icons.timer),
        TitleWidget(title: "NBC", widget: Icons.web),
        TitleWidget(title: "3 Teams", widget: Icons.connect_without_contact),
      ],
      experienceTitle: "KHQR Dual Currency and Open Banking",
      skills:
          "SDLC, Tech Explanation, Stress Testing, Vendor Management, NBC Requirements",
      content: AssetIcons.khqrexperience.imageWithSize(width: svgSize),
      platforms: ["Figma Design", "Bakong PG", "TestFlight", "Firebase"],
    ),
    ContentPageData(
      roleTitle: "Mngr. Mobile Banking Development",
      description: "Oct 2024 - May 2026 | Amret MFI",
      skillLists: [
        TitleWidget(title: "Tech Lead & Support", widget: Icons.groups),
        TitleWidget(title: "2 Months", widget: Icons.timer),
        TitleWidget(title: "Automated Testing", widget: Icons.web),
        TitleWidget(title: "3 Teams", widget: Icons.connect_without_contact),
      ],
      experienceTitle: "Build and Guide Katalon Automated Testing and Appium",
      skills:
          "Test Cases Templates, Customized Input and Output, Test Data, Configuration",
      content: AssetIcons.automatedtesting.imageWithSize(width: svgSize),
      platforms: ["Katalon", "Java Groovy", "Excel Plugin"],
    ),
    ContentPageData(
      roleTitle: "Mngr. Mobile Banking Development",
      description: "Oct 2024 - May 2026 | Amret MFI",
      skillLists: [
        TitleWidget(title: "Coordinator & Support", widget: Icons.groups),
        TitleWidget(title: "1 Week", widget: Icons.timer),
        TitleWidget(title: "Customers Campaign", widget: Icons.web),
        TitleWidget(title: "3 Teams", widget: Icons.connect_without_contact),
      ],
      experienceTitle:
          "Universal Link AppsFlyer (Product Referral, Invite Friend, KHQR Payment)",
      skills: "Keys and Configuration, SIT/UAT/STG",
      content: AssetIcons.universallink.imageWithSize(width: svgSize),
      platforms: ["AppsFlyer Onelink", "Web Angular"],
    ),
    ContentPageData(
      roleTitle: "Mngr. Mobile Banking Development",
      description: "Oct 2024 - May 2026 | Amret MFI",
      skillLists: [
        TitleWidget(title: "Coordinator & Support", widget: Icons.groups),
        TitleWidget(title: "1 Week", widget: Icons.timer),
        TitleWidget(title: "Security Hardening", widget: Icons.web),
        TitleWidget(title: "3 Teams", widget: Icons.connect_without_contact),
      ],
      experienceTitle: "App Security Hardening (SSL Pinning, App Shield)",
      skills: "TrustKit, Transporter, Firebase App Tester",
      content: AssetIcons.securitysupport.imageWithSize(width: svgSize),
      platforms: ["apksigning", "fastlane", "ironsec shield API"],
    ),
    ContentPageData(
      roleTitle: "Mngr. Mobile Banking Development",
      description: "Oct 2024 - May 2026 | Amret MFI",
      skillLists: [
        TitleWidget(title: "Developer", widget: Icons.groups),
        TitleWidget(title: "1 Month", widget: Icons.timer),
        TitleWidget(title: "Object Detection", widget: Icons.web),
        TitleWidget(title: "4 Teams", widget: Icons.connect_without_contact),
      ],
      experienceTitle: "Liveness Quick Account (E-KYC)",
      skills:
          "Google MLKit, FaceDetection, CreateML, Object Detection with CreateML, Tensorflow, CamDX",
      content: AssetIcons.liveness.imageWithSize(width: svgSize),
      platforms: ["GoogleMLKit", "CreateML", "Tensorflow"],
    ),
    ContentPageData(
      roleTitle: "Supervisor Frontend Development",
      description: "May 2024 - Oct 2026 | Amret MFI",
      skillLists: [
        TitleWidget(title: "Developer & Tech Lead", widget: Icons.groups),
        TitleWidget(title: "2 Month", widget: Icons.timer),
        TitleWidget(title: "Loan", widget: Icons.web),
        TitleWidget(title: "2 Teams", widget: Icons.connect_without_contact),
      ],
      experienceTitle: "SME Loan Implementation (Angular, Flutter)",
      skills:
          "Flutter, Parallel and Async Computation, Data Compression, Loan Process",
      content: AssetIcons.smeloan.imageWithSize(width: svgSize),
      platforms: ["Figma", "Angular Web", "Flutter"],
    ),
    ContentPageData(
      roleTitle: "Senior Frontend Development",
      description: "Oct 2022 - May 2024 | Amret MFI",
      skillLists: [
        TitleWidget(title: "Developer", widget: Icons.groups),
        TitleWidget(title: "N/A", widget: Icons.timer),
        TitleWidget(title: "Development & Support", widget: Icons.web),
        TitleWidget(title: "2 Teams", widget: Icons.connect_without_contact),
      ],
      experienceTitle: "Loan and Related System Enhancements",
      skills: "UI/UX, BRD, Documentations",
      content: AssetIcons.otherloanenhancements.imageWithSize(width: svgSize),
      platforms: ["Figma", "Angular Web", "Flutter"],
    ),
    ContentPageData(
      roleTitle: "iOS Developer",
      description: "Jan 2020 - Oct 2022 | Z1 Flexible Solution",
      skillLists: [
        TitleWidget(title: "Developer", widget: Icons.groups),
        TitleWidget(title: "N/A", widget: Icons.timer),
        TitleWidget(title: "Development", widget: Icons.web),
        TitleWidget(title: "2 Teams", widget: Icons.connect_without_contact),
      ],
      experienceTitle: "Z1 App and ZPoint",
      skills:
          "Real Estate Features, Frameworks and Libraries, Debugging, Project Structure, Source Code Control with Git, Teamwork",
      content: AssetIcons.z1.imageWithSize(width: svgSize),
      platforms: ["iOS Swift UIKit", "XCode"],
    ),
  ];
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
        padding: EdgeInsets.all(12),
        decoration: bodyContentSideDecoration,
        child: Expanded(
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
                        experienceData: experienceData,
                        pageController: experiencePageController,
                        totalExperience: experienceData.length,
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
              return Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${index + 1} / $totalExperience",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
