extension StringExtension on String {
  String toTitle() {
    return replaceAll('_', ' ');
  }
}
