import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_km.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('km'),
  ];

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get profile;

  /// No description provided for @article.
  ///
  /// In en, this message translates to:
  /// **'Article'**
  String get article;

  /// No description provided for @tool.
  ///
  /// In en, this message translates to:
  /// **'Tool'**
  String get tool;

  /// No description provided for @project.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save {file}'**
  String save(String file);

  /// No description provided for @empty_content.
  ///
  /// In en, this message translates to:
  /// **'Empty Content'**
  String get empty_content;

  /// No description provided for @platform_tools.
  ///
  /// In en, this message translates to:
  /// **'Platform & Tools'**
  String get platform_tools;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @feedback_title.
  ///
  /// In en, this message translates to:
  /// **'I\'m actively improving this portfolio and would value your perspective - feel free to share any thoughts, no matter how small.'**
  String get feedback_title;

  /// No description provided for @username_email.
  ///
  /// In en, this message translates to:
  /// **'Username / Email'**
  String get username_email;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @khmer_lang.
  ///
  /// In en, this message translates to:
  /// **'Khmer'**
  String get khmer_lang;

  /// No description provided for @english_lang.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english_lang;

  /// No description provided for @display.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get display;

  /// No description provided for @light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light_mode;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark_mode;

  /// No description provided for @system_mode.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system_mode;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @my_blog.
  ///
  /// In en, this message translates to:
  /// **'My Blog'**
  String get my_blog;

  /// No description provided for @publish_footer.
  ///
  /// In en, this message translates to:
  /// **'Published in {year}'**
  String publish_footer(int year);

  /// No description provided for @title_mngr_mb.
  ///
  /// In en, this message translates to:
  /// **'Mngr. Mobile Banking Development'**
  String get title_mngr_mb;

  /// No description provided for @mngr_desc.
  ///
  /// In en, this message translates to:
  /// **'Oct 2024 - May 2026 | Amret MFI'**
  String get mngr_desc;

  /// No description provided for @title_sup_frontend.
  ///
  /// In en, this message translates to:
  /// **'Supervisor Frontend Development'**
  String get title_sup_frontend;

  /// No description provided for @sup_desc.
  ///
  /// In en, this message translates to:
  /// **'May 2024 - Oct 2026 | Amret MFI'**
  String get sup_desc;

  /// No description provided for @title_senior_frontend.
  ///
  /// In en, this message translates to:
  /// **'Senior Frontend Development'**
  String get title_senior_frontend;

  /// No description provided for @senior_desc.
  ///
  /// In en, this message translates to:
  /// **'Oct 2022 - May 2024 | Amret MFI'**
  String get senior_desc;

  /// No description provided for @title_ios_dev.
  ///
  /// In en, this message translates to:
  /// **'iOS Developer'**
  String get title_ios_dev;

  /// No description provided for @ios_dev_desc.
  ///
  /// In en, this message translates to:
  /// **'Jan 2020 - Oct 2022 | Z1 Flexible Solution'**
  String get ios_dev_desc;

  /// No description provided for @role_delivery_lead.
  ///
  /// In en, this message translates to:
  /// **'Delivery Lead'**
  String get role_delivery_lead;

  /// No description provided for @role_team_builder.
  ///
  /// In en, this message translates to:
  /// **'Team Builder'**
  String get role_team_builder;

  /// No description provided for @role_coordinator_support.
  ///
  /// In en, this message translates to:
  /// **'Coordinator & Support'**
  String get role_coordinator_support;

  /// No description provided for @role_developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get role_developer;

  /// No description provided for @role_developer_techlead.
  ///
  /// In en, this message translates to:
  /// **'Developer & Tech Lead'**
  String get role_developer_techlead;

  /// No description provided for @duration_months.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{N/A} =1{1 Month} other{{count} Months}}{text}'**
  String duration_months(int count, String text);

  /// No description provided for @duration_weeks.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{N/A} =1{1 Week} other{{count} Weeks}}{text}'**
  String duration_weeks(int count, String text);

  /// No description provided for @duration_quarter.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{N/A} =1{1 Quarter} other{{count} Quarters}}{text}'**
  String duration_quarter(int count, String text);

  /// No description provided for @work_dynamic_setup.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Setup'**
  String get work_dynamic_setup;

  /// No description provided for @work_hr_process.
  ///
  /// In en, this message translates to:
  /// **'HR Process'**
  String get work_hr_process;

  /// No description provided for @work_nbc.
  ///
  /// In en, this message translates to:
  /// **'NBC'**
  String get work_nbc;

  /// No description provided for @work_automated_testing.
  ///
  /// In en, this message translates to:
  /// **'Automated Testing'**
  String get work_automated_testing;

  /// No description provided for @work_customer_campaign.
  ///
  /// In en, this message translates to:
  /// **'Customers Campaign'**
  String get work_customer_campaign;

  /// No description provided for @work_security_hardening.
  ///
  /// In en, this message translates to:
  /// **'Security Hardening'**
  String get work_security_hardening;

  /// No description provided for @work_ai_object_detection.
  ///
  /// In en, this message translates to:
  /// **'Object Detection'**
  String get work_ai_object_detection;

  /// No description provided for @work_loan_implementation.
  ///
  /// In en, this message translates to:
  /// **'Loan Implementation'**
  String get work_loan_implementation;

  /// No description provided for @work_development_support.
  ///
  /// In en, this message translates to:
  /// **'Development & Support'**
  String get work_development_support;

  /// No description provided for @work_development.
  ///
  /// In en, this message translates to:
  /// **'Development'**
  String get work_development;

  /// No description provided for @team_size.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{N/A} =1{1 Team} other{{count} Teams}}'**
  String team_size(int count);

  /// No description provided for @committee_size.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{N/A} =1{1 Committee} other{{count} Comittees}}'**
  String committee_size(int count);

  /// No description provided for @exp_bill.
  ///
  /// In en, this message translates to:
  /// **'Multiple Bill Payments Integration and Configuration'**
  String get exp_bill;

  /// No description provided for @skill_bill.
  ///
  /// In en, this message translates to:
  /// **'SDLC'**
  String get skill_bill;

  /// No description provided for @exp_build_team.
  ///
  /// In en, this message translates to:
  /// **'Build an Autonomous High-Performing Team'**
  String get exp_build_team;

  /// No description provided for @skill_build_team.
  ///
  /// In en, this message translates to:
  /// **'Candidate Selection and Interviewing Process'**
  String get skill_build_team;

  /// No description provided for @exp_khqr.
  ///
  /// In en, this message translates to:
  /// **'KHQR Dual Currency and Open Banking'**
  String get exp_khqr;

  /// No description provided for @skill_khqr.
  ///
  /// In en, this message translates to:
  /// **'Stress Testing, Vendor Management, NBC Requirements'**
  String get skill_khqr;

  /// No description provided for @exp_automate_testing.
  ///
  /// In en, this message translates to:
  /// **'Build and Guide Katalon Automated Testing and Appium'**
  String get exp_automate_testing;

  /// No description provided for @skill_automate_testing.
  ///
  /// In en, this message translates to:
  /// **'Test Cases Templates, Customized Input and Output, Test Data, Configuration'**
  String get skill_automate_testing;

  /// No description provided for @exp_universal_link.
  ///
  /// In en, this message translates to:
  /// **'Universal Link AppsFlyer (Product Referral, Invite Friend, KHQR Payment)'**
  String get exp_universal_link;

  /// No description provided for @skill_universal_link.
  ///
  /// In en, this message translates to:
  /// **'Keys and Configuration, SIT/UAT/STG'**
  String get skill_universal_link;

  /// No description provided for @exp_hardening.
  ///
  /// In en, this message translates to:
  /// **'App Security Hardening (SSL Pinning, App Shield)'**
  String get exp_hardening;

  /// No description provided for @skill_hardening.
  ///
  /// In en, this message translates to:
  /// **'TrustKit, Transporter, Firebase App Tester'**
  String get skill_hardening;

  /// No description provided for @exp_liveness.
  ///
  /// In en, this message translates to:
  /// **'Liveness Quick Account (E-KYC)'**
  String get exp_liveness;

  /// No description provided for @skill_liveness.
  ///
  /// In en, this message translates to:
  /// **'Google MLKit, FaceDetection, CreateML, Object Detection with CreateML, Tensorflow, CamDX'**
  String get skill_liveness;

  /// No description provided for @exp_loan_implementation.
  ///
  /// In en, this message translates to:
  /// **'SME Loan Implementation (Angular, Flutter)'**
  String get exp_loan_implementation;

  /// No description provided for @skill_loan_implementation.
  ///
  /// In en, this message translates to:
  /// **'Parallel and Async Computation, Data Compression, Loan Process'**
  String get skill_loan_implementation;

  /// No description provided for @exp_loan_releated.
  ///
  /// In en, this message translates to:
  /// **'Loan and Related System Enhancements'**
  String get exp_loan_releated;

  /// No description provided for @skill_loan_related.
  ///
  /// In en, this message translates to:
  /// **'UI/UX, BRD, Documentations'**
  String get skill_loan_related;

  /// No description provided for @exp_z1_zpoint.
  ///
  /// In en, this message translates to:
  /// **'Z1 App and ZPoint (Real Estate iOS App)'**
  String get exp_z1_zpoint;

  /// No description provided for @skill_z1_zpoint.
  ///
  /// In en, this message translates to:
  /// **'Real Estate Features, Frameworks and Libraries, Debugging, Project Structure, Source Code Control with Git, Teamwork'**
  String get skill_z1_zpoint;

  /// No description provided for @direct_report_size.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{N/A} =1{1 Direct Report} other{{count} Direct Reports}}'**
  String direct_report_size(int count);

  /// No description provided for @biller_size.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{N/A} =1{1 Biller} other{{count} Billers}}'**
  String biller_size(int count);

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Te Sengthai'**
  String get author;

  /// No description provided for @leadership_style.
  ///
  /// In en, this message translates to:
  /// **'Transformational, Visionary, Laissez-Faire, Servant, Pacesetting'**
  String get leadership_style;

  /// No description provided for @prof_summary.
  ///
  /// In en, this message translates to:
  /// **'With nearly <b>6 years of experience</b> in a dynamic Fintech company, I bring 3 core values: <b>adaptability</b> in agile environments through cross-functional communication, proactive <b>collaboration</b> driving team success via initiative and innovative problem-solving, and <b>continuous growth</b> aligned with organizational vision for sustained impact.'**
  String get prof_summary;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'km'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'km':
      return AppLocalizationsKm();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
