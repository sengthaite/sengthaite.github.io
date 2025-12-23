import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:hive_ce/hive.dart';

part 'hiveeditor.g.dart';

@HiveType(typeId: 4)
class HiveEditor extends HiveObject {
  @HiveField(0)
  String? data;

  Future<void> saveData(Delta obj) async {
    try {
      data = jsonEncode(obj.toJson());
      await save();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Delta? formatDelta(String? rawData) {
    if (rawData == null) return null;
    try {
      return Delta.fromJson(jsonDecode(rawData));
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }
}
