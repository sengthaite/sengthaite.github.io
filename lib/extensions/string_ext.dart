import 'package:flutter/material.dart';

extension StringExtension on String {
  String toTitle() {
    return replaceAll('_', ' ');
  }

  bool get isUrl {
    try {
      var uri = Uri.parse(this);
      var finalUrl = this;
      if (!uri.hasScheme) {
        finalUrl = "http://$this";
      }
      String pattern = r'^(http|https):\/\/([\w.]+)+(:[0-9]{1,5})?(\/.*)?$';
      RegExp regExp = RegExp(pattern);
      return regExp.hasMatch(finalUrl);
    } catch (error) {
      debugPrint("Error: $error");
      return false;
    }
  }
}
