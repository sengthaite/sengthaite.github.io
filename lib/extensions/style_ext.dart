import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle? {
  TextStyle? get bold => this?.copyWith(fontWeight: FontWeight.bold);
  TextStyle? get semiBold => this?.copyWith(fontWeight: FontWeight.w600);
  TextStyle? get medium => this?.copyWith(fontWeight: FontWeight.w500);
}
