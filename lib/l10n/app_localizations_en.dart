// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get profile => 'About Me';

  @override
  String get article => 'Article';

  @override
  String get tool => 'Tool';

  @override
  String get project => 'Project';

  @override
  String get settings => 'Settings';

  @override
  String save(String file) {
    return 'Save $file';
  }

  @override
  String get empty_content => 'Empty Content';

  @override
  String get platform_tools => 'Platform & Tools';

  @override
  String get experience => 'Experience';

  @override
  String get education => 'Education';

  @override
  String get feedback_title =>
      'I\'m actively improving this portfolio and would value your perspective - feel free to share any thoughts, no matter how small.';

  @override
  String get username_email => 'Username / Email';

  @override
  String get comment => 'Comment';

  @override
  String get cancel => 'Cancel';

  @override
  String get submit => 'Submit';

  @override
  String get setting => 'Setting';

  @override
  String get language => 'Language';

  @override
  String get khmer_lang => 'Khmer';

  @override
  String get english_lang => 'English';

  @override
  String get display => 'Display';

  @override
  String get light_mode => 'Light';

  @override
  String get dark_mode => 'Dark';

  @override
  String get system_mode => 'System';

  @override
  String get feedback => 'Feedback';

  @override
  String get home => 'Home';

  @override
  String get my_blog => 'My Blog';

  @override
  String publish_footer(int year) {
    return 'Published in $year';
  }

  @override
  String get title_mngr_mb => 'Mngr. Mobile Banking Development';

  @override
  String get mngr_desc => 'Oct 2024 - May 2026 | Amret MFI';

  @override
  String get title_sup_frontend => 'Supervisor Frontend Development';

  @override
  String get sup_desc => 'May 2024 - Oct 2026 | Amret MFI';

  @override
  String get title_senior_frontend => 'Senior Frontend Development';

  @override
  String get senior_desc => 'Oct 2022 - May 2024 | Amret MFI';

  @override
  String get title_ios_dev => 'iOS Developer';

  @override
  String get ios_dev_desc => 'Jan 2020 - Oct 2022 | Z1 Flexible Solution';

  @override
  String get role_delivery_lead => 'Delivery Lead';

  @override
  String get role_team_builder => 'Team Builder';

  @override
  String get role_coordinator_support => 'Coordinator & Support';

  @override
  String get role_developer => 'Developer';

  @override
  String get role_developer_techlead => 'Developer & Tech Lead';

  @override
  String duration_months(int count, String text) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Months',
      one: '1 Month',
      zero: 'N/A',
    );
    return '$_temp0$text';
  }

  @override
  String duration_weeks(int count, String text) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'count Weeks',
      one: '1 Week',
      zero: 'N/A',
    );
    return '$_temp0$text';
  }

  @override
  String duration_quarter(int count, String text) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Quarters',
      one: '1 Quarter',
      zero: 'N/A',
    );
    return '$_temp0$text';
  }

  @override
  String get work_dynamic_setup => 'Dynamic Setup';

  @override
  String get work_hr_process => 'HR Process';

  @override
  String get work_nbc => 'NBC';

  @override
  String get work_automated_testing => 'Automated Testing';

  @override
  String get work_customer_campaign => 'Customers Campaign';

  @override
  String get work_security_hardening => 'Security Hardening';

  @override
  String get work_ai_object_detection => 'Object Detection';

  @override
  String get work_loan_implementation => 'Loan Implementation';

  @override
  String get work_development_support => 'Development & Support';

  @override
  String get work_development => 'Development';

  @override
  String team_size(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Teams',
      one: '1 Team',
      zero: 'N/A',
    );
    return '$_temp0';
  }

  @override
  String committee_size(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Comittees',
      one: '1 Committee',
      zero: 'N/A',
    );
    return '$_temp0';
  }

  @override
  String get exp_bill => 'Multiple Bill Payments Integration and Configuration';

  @override
  String get skill_bill => 'SDLC';

  @override
  String get exp_build_team => 'Build an Autonomous High-Performing Team';

  @override
  String get skill_build_team => 'Candidate Selection and Interviewing Process';

  @override
  String get exp_khqr => 'KHQR Dual Currency and Open Banking';

  @override
  String get skill_khqr =>
      'Stress Testing, Vendor Management, NBC Requirements';

  @override
  String get exp_automate_testing =>
      'Build and Guide Katalon Automated Testing and Appium';

  @override
  String get skill_automate_testing =>
      'Test Cases Templates, Customized Input and Output, Test Data, Configuration';

  @override
  String get exp_universal_link =>
      'Universal Link AppsFlyer (Product Referral, Invite Friend, KHQR Payment)';

  @override
  String get skill_universal_link => 'Keys and Configuration, SIT/UAT/STG';

  @override
  String get exp_hardening =>
      'App Security Hardening (SSL Pinning, App Shield)';

  @override
  String get skill_hardening => 'TrustKit, Transporter, Firebase App Tester';

  @override
  String get exp_liveness => 'Liveness Quick Account (E-KYC)';

  @override
  String get skill_liveness =>
      'Google MLKit, FaceDetection, CreateML, Object Detection with CreateML, Tensorflow, CamDX';

  @override
  String get exp_loan_implementation =>
      'SME Loan Implementation (Angular, Flutter)';

  @override
  String get skill_loan_implementation =>
      'Parallel and Async Computation, Data Compression, Loan Process';

  @override
  String get exp_loan_releated => 'Loan and Related System Enhancements';

  @override
  String get skill_loan_related => 'UI/UX, BRD, Documentations';

  @override
  String get exp_z1_zpoint => 'Z1 App and ZPoint (Real Estate iOS App)';

  @override
  String get skill_z1_zpoint =>
      'Real Estate Features, Frameworks and Libraries, Debugging, Project Structure, Source Code Control with Git, Teamwork';

  @override
  String direct_report_size(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Direct Reports',
      one: '1 Direct Report',
      zero: 'N/A',
    );
    return '$_temp0';
  }

  @override
  String biller_size(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Billers',
      one: '1 Biller',
      zero: 'N/A',
    );
    return '$_temp0';
  }

  @override
  String get page => 'Page';
}
