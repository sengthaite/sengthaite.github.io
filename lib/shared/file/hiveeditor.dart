import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:hive_ce/hive.dart';

part 'hiveeditor.g.dart';

@HiveType(typeId: 4)
class HiveEditor {
  @HiveField(0)
  String? data;

  set putData(Delta obj) {
    try {
      data = jsonEncode(obj.toJson());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Delta? get getData {
    if (data == null) return null;
    try {
      return jsonDecode(data!);
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }
}
