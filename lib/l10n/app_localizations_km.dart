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
  String get platform_tools => 'វេទិកា និងឧបករណ៍';

  @override
  String get experience => 'បទពិសោធន៍';

  @override
  String get education => 'ការអប់រំ';

  @override
  String get feedback_title =>
      'ខ្ញុំកំពុងកែលម្អផលប័ត្រនេះយ៉ាងសកម្ម ហើយនឹងផ្តល់តម្លៃដល់ទស្សនៈរបស់អ្នក - មានអារម្មណ៍សេរីក្នុងការចែករំលែកគំនិតណាមួយ មិនថាតូចប៉ុណ្ណាក៏ដោយ។';

  @override
  String get username_email => 'ឈ្មោះអ្នកប្រើ / អ៊ីមែល';

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
}
