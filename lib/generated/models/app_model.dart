// To parse this JSON data, do
//
//     final appModel = appModelFromJson(jsonString);

import 'dart:convert';

AppModel appModelFromJson(String str) => AppModel.fromJson(json.decode(str));

String appModelToJson(AppModel data) => json.encode(data.toJson());

class AppModel {
  final String? author;
  final DateTime? createdDate;
  final List<Datum>? data;
  final String? type;
  final String? version;

  AppModel({
    this.author,
    this.createdDate,
    this.data,
    this.type,
    this.version,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
        author: json["author"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        type: json["type"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "created_date": createdDate?.toIso8601String(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "type": type,
        "version": version,
      };
}

class Datum {
  final DateTime? createdDate;
  final List<FileElement>? files;
  final String? icon;
  final int? index;
  final String? name;
  final String? path;

  Datum({
    this.createdDate,
    this.files,
    this.icon,
    this.index,
    this.name,
    this.path,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
        icon: json["icon"],
        index: json["index"],
        name: json["name"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "created_date": createdDate?.toIso8601String(),
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
        "icon": icon,
        "index": index,
        "name": name,
        "path": path,
      };
}

class FileElement {
  final DateTime? accessDate;
  final DateTime? changeDate;
  final String? exerpt;
  final String? fullPath;
  final int? index;
  final bool? hasToc;
  final DateTime? modifiedDate;
  final String? name;
  final String? title;

  FileElement({
    this.accessDate,
    this.changeDate,
    this.exerpt,
    this.fullPath,
    this.index,
    this.hasToc,
    this.modifiedDate,
    this.name,
    this.title,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        accessDate: json["access_date"] == null
            ? null
            : DateTime.parse(json["access_date"]),
        changeDate: json["change_date"] == null
            ? null
            : DateTime.parse(json["change_date"]),
        exerpt: json["exerpt"],
        fullPath: json["full_path"],
        index: json["index"],
        hasToc: json["hasToc"],
        modifiedDate: json["modified_date"] == null
            ? null
            : DateTime.parse(json["modified_date"]),
        name: json["name"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "access_date": accessDate?.toIso8601String(),
        "change_date": changeDate?.toIso8601String(),
        "exerpt": exerpt,
        "full_path": fullPath,
        "index": index,
        "hasToc": hasToc,
        "modified_date": modifiedDate?.toIso8601String(),
        "name": name,
        "title": title,
      };
}
