import 'package:flutter/widgets.dart';
import 'package:sengthaite_blog/constants/enum.constants.dart';

enum AssetIcons {
  logo("logo.png"),
  android("android.png"),
  angular("angular.png"),
  csharp("c#.png"),
  database("database.png"),
  general("general.png"),
  ios("ios.png"),
  kotlin("kotlin.png"),
  llvm("llvm.png"),
  maths("maths.png"),
  os("os.png"),
  reverseEngineer("reverse_engineer.png"),
  swift("swift.png"),
  termux("termux.png"),
  tools("tools.png"),
  textEditor("text_editor.png", section: TabSection.tool);

  const AssetIcons(
    this.imageName, {
    // ignore: unused_element
    this.section = TabSection.content,
  });

  factory AssetIcons.fromImageName(String name) {
    switch (name.toLowerCase()) {
      case "logo.png":
        return AssetIcons.logo;
      case "android.png":
        return AssetIcons.android;
      case "angular.png":
        return AssetIcons.angular;
      case "c#.png":
        return AssetIcons.csharp;
      case "database.png":
        return AssetIcons.database;
      case "general.png":
        return AssetIcons.general;
      case "ios.png":
        return AssetIcons.ios;
      case "kotlin.png":
        return AssetIcons.kotlin;
      case "llvm.png":
        return AssetIcons.llvm;
      case "maths.png":
        return AssetIcons.maths;
      case "os.png":
        return AssetIcons.os;
      case "reverse_engineer.png":
        return AssetIcons.reverseEngineer;
      case "swift.png":
        return AssetIcons.swift;
      case "termux.png":
        return AssetIcons.termux;
      case "tools.png":
        return AssetIcons.tools;
      case "text_editor.png":
        return AssetIcons.textEditor;
      default:
        return AssetIcons.logo;
    }
  }

  Image get image {
    var basePath = "assets/content_icons";
    switch (section) {
      case TabSection.tool:
        basePath = "assets/tool_icons";
        break;
      case TabSection.project:
        basePath = "assets/project_icons";
        break;
      default:
        break;
    }
    return Image.asset(
      "$basePath/$imageName",
      width: 60,
      height: 60,
    );
  }

  final String imageName;
  final TabSection section;
}
