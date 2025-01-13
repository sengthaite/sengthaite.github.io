import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String get formatDateDisplay => DateFormat('MMM d, yyyy').format(this);

  int get millisecondsSinceEpoch =>
      DateTime.now().toUtc().millisecondsSinceEpoch;
}
