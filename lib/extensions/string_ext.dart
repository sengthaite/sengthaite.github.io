extension StringExtension on String {
  String toTitle() {
    return replaceAll('_', ' ').capitalize();
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
