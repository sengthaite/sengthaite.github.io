// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get profile => 'អំពីខ្ញុំ';

  @override
  String get article => 'អត្ថបទ';

  @override
  String get tool => 'ឧបករណ៍';

  @override
  String get project => 'គម្រោង';

  @override
  String get settings => 'ការកំណត់';

  @override
  String save(String file) {
    return 'រក្សាទុក $file';
  }

  @override
  String get empty_content => 'មាតិកាទទេ';

  @override
  String get platform_tools => 'ប្រព័ន្ធបច្ចេកវិទ្យានិងឧបករណ៍';

  @override
  String get experience => 'បទពិសោធន៍';

  @override
  String get education => 'ការអប់រំ';

  @override
  String get feedback_title =>
      'ខ្ញុំកំពុងកែលម្អផលប័ត្រនេះយ៉ាងសកម្ម ហើយនឹងផ្តល់តម្លៃដល់ទស្សនៈរបស់អ្នក - មានអារម្មណ៍សេរីក្នុងការចែករំលែកគំនិតណាមួយ មិនថាតូចប៉ុណ្ណាក៏ដោយ។';

  @override
  String get username_email => 'អ៊ីមែល';

  @override
  String get comment => 'មតិយោបល់';

  @override
  String get cancel => 'បោះបង់';

  @override
  String get submit => 'ដាក់ស្នើ';

  @override
  String get setting => 'ការកំណត់';

  @override
  String get language => 'ភាសា';

  @override
  String get khmer_lang => 'ភាសាខ្មែរ';

  @override
  String get english_lang => 'ភាសាអង់គ្លេស';

  @override
  String get display => 'ពន្លឺ';

  @override
  String get light_mode => 'ភ្លឺ';

  @override
  String get dark_mode => 'ងងឹត';

  @override
  String get system_mode => 'តាមប្រព័ន្ធ';

  @override
  String get feedback => 'មតិកែលម្អ';

  @override
  String get home => 'ទំព័រដើម';

  @override
  String get my_blog => 'ប្លុករបស់ខ្ញុំ';

  @override
  String publish_footer(int year) {
    return 'បានចេញផ្សាយនៅឆ្នាំ $year';
  }

  @override
  String get title_mngr_mb => 'អ្នកគ្រប់គ្រងការអភិវឌ្ឍន៍កម្មវិធីទូរស័ព្ទធនាគារ';

  @override
  String get mngr_desc => 'តុលា 2024 - ឧសភា 2026 | អម្រឹត';

  @override
  String get title_sup_frontend =>
      'អ្នកគ្រប់គ្រងកម្រិតទាបការអភិវឌ្ឍផ្នែកខាងមុខ';

  @override
  String get sup_desc => 'ឧសភា 2024 - តុលា 2026 | អម្រឹត';

  @override
  String get title_senior_frontend => 'មន្ត្រីជាន់ខ្ពស់ការអភិវឌ្ឍផ្នែកខាងមុខ';

  @override
  String get senior_desc => 'តុលា 2022 - ឧសភា 2024 | អម្រឹត';

  @override
  String get title_ios_dev => 'អ្នកអភិវឌ្ឍន៍ iOS';

  @override
  String get ios_dev_desc => 'មករា 2020 - តុលា 2022 | Z1 Flexible Solution';

  @override
  String get role_delivery_lead => 'អ្នកដឹកនាំលទ្ធផលការងារ';

  @override
  String get role_team_builder => 'អ្នកកសាងក្រុម';

  @override
  String get role_coordinator_support => 'អ្នកសម្របសម្រួលនិងជំនួយ';

  @override
  String get role_developer => 'អ្នកអភិវឌ្ឍន៍';

  @override
  String get role_developer_techlead =>
      'អ្នកអភិវឌ្ឍន៍និងអ្នកដឹកនាំបច្ចេកវិទ្យា';

  @override
  String duration_months(int count, String text) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ខែ',
      one: '1 ខែ',
      zero: 'N/A',
    );
    return '$_temp0$text';
  }

  @override
  String duration_weeks(int count, String text) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count សប្តាហ៍',
      one: '1 សប្តាហ៍',
      zero: 'N/A',
    );
    return '$_temp0$text';
  }

  @override
  String duration_quarter(int count, String text) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ត្រីមាស',
      one: '1 ត្រីមាស',
      zero: 'N/A',
    );
    return '$_temp0$text';
  }

  @override
  String get work_dynamic_setup => 'បង្កើតលក្ខណៈថាមវន្ត';

  @override
  String get work_hr_process => 'ដំណើរការធនធានមនុស្ស';

  @override
  String get work_nbc => 'ធនាគារជាតិនៃកម្ពុជា';

  @override
  String get work_automated_testing => 'ការធ្វើតេស្តស្វ័យប្រវត្តិ';

  @override
  String get work_customer_campaign => 'យុទ្ធនាការរកអតិថិជន';

  @override
  String get work_security_hardening => 'ការពង្រឹងសុវត្ថិភាព';

  @override
  String get work_ai_object_detection => 'រកវត្ថុតាមបច្ចេកវិទ្យា';

  @override
  String get work_loan_implementation => 'ការអភិវឌ្ឍន៍កម្មវិធីកម្ចី';

  @override
  String get work_development_support => 'ការអភិវឌ្ឍន៍និងការគាំទ្រ';

  @override
  String get work_development => 'ការអភិវឌ្ឍន៍';

  @override
  String team_size(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ក្រុម',
      one: '1 ក្រុម',
      zero: 'N/A',
    );
    return '$_temp0';
  }

  @override
  String committee_size(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count គណៈកម្មាធិការ',
      one: '1 គណៈកម្មាធិការ',
      zero: 'N/A',
    );
    return '$_temp0';
  }

  @override
  String get exp_bill =>
      'ការរួមបញ្ចូលនិងការកំណត់រចនាសម្ព័ន្ធការទូទាត់វិក្កយបត្រច្រើន';

  @override
  String get skill_bill => 'វដ្តនៃការអភិវឌ្ឍន៍កម្មវិធី';

  @override
  String get exp_build_team => 'បង្កើត​ក្រុម​ដែល​មាន​សមត្ថភាព​ខ្ពស់​ស្វយ័ត';

  @override
  String get skill_build_team => 'ដំណើរការជ្រើសរើសបេក្ខជននិងសម្ភាសន៍';

  @override
  String get exp_khqr => 'រូបិយប័ណ្ណពីរ KHQR និងOpen Banking';

  @override
  String get skill_khqr => 'ការធ្វើតេស្តស៊ីជម្រៅ, vendor, NBC';

  @override
  String get exp_automate_testing =>
      'បង្កើតនិងណែនាំការធ្វើតេស្តស្វ័យប្រវត្តិប្រើ Katalon និង Appium';

  @override
  String get skill_automate_testing =>
      'ទំរង់ឯកសារតេស្ត៍, ការបញ្ចូលទិន្នន័យតេស្ត៍ និងលទ្ធផល, ការបញ្ចូលទិន្នន័យគន្លឹះ';

  @override
  String get exp_universal_link =>
      'Universal Link AppsFlyer (ការណែនាំផលិតផល, អញ្ជើញមិត្ត, ការទូទាត់តាម KHQR)';

  @override
  String get skill_universal_link =>
      'ការរៀបចំគន្លឹះនិងទិន្នន័យសំខាន់ៗក្នុងប្រព័ន្ធ, SIT/UAT/STG';

  @override
  String get exp_hardening =>
      'ការពង្រឹងសុវត្ថិភាពកម្មវិធី (SSL Pinning, App Shield)';

  @override
  String get skill_hardening => 'TrustKit, Transporter, Firebase App Tester';

  @override
  String get exp_liveness => 'Liveness Quick Account (E-KYC)';

  @override
  String get skill_liveness =>
      'Google MLKit, FaceDetection, CreateML, Object Detection with CreateML, Tensorflow, CamDX';

  @override
  String get exp_loan_implementation => 'អភិវឌ្ឈការអនុវត្តប្រាក់កម្ចី SME';

  @override
  String get skill_loan_implementation =>
      'ការគណនាប៉ារ៉ាឡែលនិងអសមកាល, ការបង្ហាប់ទិន្នន័យ, ដំណើរការកម្ចី';

  @override
  String get exp_loan_releated =>
      'ការផ្តល់ប្រាក់កម្ចី និងការលើកកម្ពស់ប្រព័ន្ធពាក់ព័ន្ធ';

  @override
  String get skill_loan_related => 'UI/UX, តម្រូវការអាជីវកម្ម, ឯកសារ';

  @override
  String get exp_z1_zpoint => 'Z1 App and ZPoint (iOS App សម្រាប់អចលនទ្រព្យ)';

  @override
  String get skill_z1_zpoint =>
      'លក្ខណៈពិសេសអចលនទ្រព្យ, Framework and Libraries, ស្វែងរកកំហុសបច្ចេកទេស, រចនាសម្ព័ន្ធគម្រោង, ការគ្រប់គ្រងកូដប្រភពជាមួយ Git, ការងារជាក្រុម';

  @override
  String direct_report_size(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'កូនក្រុម $count',
      one: 'កូនក្រុម 1',
      zero: 'N/A',
    );
    return '$_temp0';
  }

  @override
  String biller_size(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ក្រុមហ៊ុន (Billers)',
      one: '1 ក្រុមហ៊ុន (Biller)',
      zero: 'N/A',
    );
    return '$_temp0';
  }

  @override
  String get page => 'ទំព័រ';

  @override
  String get author => 'តែ សេងថៃ';

  @override
  String get leadership_style =>
      'ការផ្លាស់ប្តូរដើម្បីភាពរីកចម្រើន, ចក្ខុវិស័យ, Laissez-Faire, អ្នកជួយគាំទ្រ, ភាពរហ័សរហួន';

  @override
  String get prof_summary =>
      'ជាមួយនឹងបទពិសោធន៍ជិត 6 ឆ្នាំ</b> នៅក្នុងក្រុមហ៊ុន Fintech ប្រកបដោយថាមពល ខ្ញុំនាំមកនូវគុណតម្លៃស្នូលចំនួន 3៖ <b>ការសម្របខ្លួន</b> នៅក្នុងបរិយាកាសរហ័សរហួន តាមរយៈការប្រាស្រ័យទាក់ទងគ្នាតាមមុខងារ កិច្ចសហការយ៉ាងសកម្ម <b>ការសហការ</b> ជំរុញឱ្យក្រុមទទួលបានជោគជ័យតាមរយៈការផ្តួចផ្តើម និងការដោះស្រាយបញ្ហាប្រកបដោយភាពច្នៃប្រឌិត និង <b>កំណើនជាបន្តបន្ទាប់</b> ស្របតាមចក្ខុវិស័យប្រកបដោយនិរន្តរភាព';
}
