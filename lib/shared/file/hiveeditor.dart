import 'package:hive_ce/hive.dart';

part 'hiveeditor.g.dart'; 

@HiveType(typeId: 4)
class HiveEditor {
  @HiveField(0)
  String content;

  HiveEditor({required this.content});
}