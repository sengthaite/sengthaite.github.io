import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:hive_ce/hive.dart';

part 'hiveeditor.g.dart';

@HiveType(typeId: 4)
class HiveEditor extends HiveObject {
  @HiveField(0)
  String? data;

  Delta? formatDelta() {
    if (data == null) return null;
    try {
      return Delta.fromJson(jsonDecode(data!) as List);
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }
}
