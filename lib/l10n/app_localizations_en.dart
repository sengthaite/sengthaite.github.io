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
}
