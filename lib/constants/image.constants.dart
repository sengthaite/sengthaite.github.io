import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as path;
import 'package:sengthaite_blog/constants/enum.constants.dart';

enum AssetIcons {
  logo("logo.svg"),
  android("android.svg"),
  angular("angular.svg"),
  csharp("c#.svg"),
  database("database.svg"),
  general("general.svg"),
  ios("ios.png"),
  kotlin("kotlin.png"),
  llvm("llvm.png"),
  maths("maths.svg"),
  os("os.svg"),
  reverseEngineer("reverse_engineer.svg"),
  swift("swift.png"),
  cli("cli.svg"),
  tools("tool.svg"),
  textEditor("text_editor.png", section: TabSection.tool);

  const AssetIcons(
    this.imageName, {
    // ignore: unused_element
    this.section = TabSection.content,
  });

  factory AssetIcons.fromImageName(String name) {
    String imageName = path.basenameWithoutExtension(name);
    switch (imageName.toLowerCase()) {
      case "logo":
        return AssetIcons.logo;
      case "android":
        return AssetIcons.android;
      case "angular":
        return AssetIcons.angular;
      case "c#":
        return AssetIcons.csharp;
      case "database":
        return AssetIcons.database;
      case "general":
        return AssetIcons.general;
      case "ios":
        return AssetIcons.ios;
      case "kotlin":
        return AssetIcons.kotlin;
      case "llvm":
        return AssetIcons.llvm;
      case "maths":
        return AssetIcons.maths;
      case "os":
        return AssetIcons.os;
      case "reverse_engineer":
        return AssetIcons.reverseEngineer;
      case "swift":
        return AssetIcons.swift;
      case "cli":
        return AssetIcons.cli;
      case "tool":
        return AssetIcons.tools;
      case "text_editor":
        return AssetIcons.textEditor;
      default:
        return AssetIcons.logo;
    }
  }

  Widget get image {
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
    if (path.extension(imageName) == '.svg') {
      return SvgPicture.asset(
        "$basePath/$imageName",
        width: 60,
        height: 60,
      );
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
