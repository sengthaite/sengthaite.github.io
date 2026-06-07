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
}
