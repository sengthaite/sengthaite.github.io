import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as path;
import 'package:sengthaite_blog/constants/enum.constants.dart';

enum AssetIcons {
  logo("logo.svg"),
  flutter("flutter.svg"),
  android("android.svg"),
  angular("angular.svg"),
  cambodia("cambodia.svg"),
  csharp("c#.svg"),
  database("database.svg"),
  general("general.svg"),
  ios("ios.svg"),
  kotlin("kotlin.svg"),
  llvm("llvm.svg"),
  maths("maths.svg"),
  os("os.svg"),
  reverseEngineer("reverse_engineer.svg"),
  swift("swift.svg"),
  cli("cli.svg"),
  tools("tool.svg"),
  biography("biography.svg"),
  github("github.svg", section: TabSection.tool),
  camera("camera.svg", section: TabSection.tool),
  textEditor("text_editor.svg", section: TabSection.tool),
  http("http.svg", section: TabSection.tool),
  cal("calculator.svg", section: TabSection.tool),
  qrcode("qrcode.png", section: TabSection.tool),
  apk("apk.svg", section: TabSection.portfolio),
  appstore("app-store.svg", section: TabSection.portfolio),
  appsflyer("appsflyer.png", section: TabSection.portfolio),
  blog("blog.svg", section: TabSection.portfolio),
  camdx("camdx.png", section: TabSection.portfolio),
  createml("createml.png", section: TabSection.portfolio),
  download("download.svg", section: TabSection.portfolio),
  githubpf("github.svg", section: TabSection.portfolio),
  gmail("gmail.svg", section: TabSection.portfolio),
  goal("goal.svg", section: TabSection.portfolio),
  home("home.svg", section: TabSection.portfolio),
  ipa("ipa.svg", section: TabSection.portfolio),
  khqr("khqr.png", section: TabSection.portfolio),
  linkedin("linkedin.svg", section: TabSection.portfolio),
  manager("manager.svg", section: TabSection.portfolio),
  mlkit("mlkit.png", section: TabSection.portfolio),
  mobile("mobile.svg", section: TabSection.portfolio),
  phone("phone.svg", section: TabSection.portfolio),
  planning("planning.svg", section: TabSection.portfolio),
  playstore("playstore.svg", section: TabSection.portfolio),
  process("process.svg", section: TabSection.portfolio),
  qa("qa.svg", section: TabSection.portfolio),
  security("security.svg", section: TabSection.portfolio),
  setting("setting.svg", section: TabSection.portfolio),
  share("share.svg", section: TabSection.portfolio),
  team("team.svg", section: TabSection.portfolio),
  telegram("telegram.svg", section: TabSection.portfolio),
  tensorflow("tensorflow.svg", section: TabSection.portfolio),
  testcase("testcase.svg", section: TabSection.portfolio),
  toolspf("tools.svg", section: TabSection.portfolio),
  trello("trello.svg", section: TabSection.portfolio);

  const AssetIcons(this.imageName, {this.section = TabSection.content});

  factory AssetIcons.fromImageName(String name) {
    String imageName = path.basenameWithoutExtension(name);
    switch (imageName.toLowerCase()) {
      case "flutter":
        return AssetIcons.flutter;
      case "logo":
        return AssetIcons.logo;
      case "android":
        return AssetIcons.android;
      case "angular":
        return AssetIcons.angular;
      case "cambodia":
        return AssetIcons.cambodia;
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
      case "biography":
        return AssetIcons.biography;
      case "text_editor":
        return AssetIcons.textEditor;
      case "github":
        return AssetIcons.github;
      case "apk":
        return AssetIcons.apk;
      case "app-store":
        return AssetIcons.appstore;
      case "appsflyer.png":
        return AssetIcons.appsflyer;
      case "blog":
        return AssetIcons.blog;
      case "camdx.png":
        return AssetIcons.camdx;
      case "createml.png":
        return AssetIcons.createml;
      case "download":
        return AssetIcons.download;
      case "github_pf":
        return AssetIcons.github;
      case "gmail":
        return AssetIcons.gmail;
      case "goal":
        return AssetIcons.goal;
      case "home":
        return AssetIcons.home;
      case "ipa":
        return AssetIcons.ipa;
      case "khqr":
        return AssetIcons.khqr;
      case "linkedin":
        return AssetIcons.linkedin;
      case "manager":
        return AssetIcons.manager;
      case "mlkit":
        return AssetIcons.mlkit;
      case "mobile":
        return AssetIcons.mobile;
      case "phone":
        return AssetIcons.phone;
      case "planning":
        return AssetIcons.planning;
      case "playstore":
        return AssetIcons.playstore;
      case "process":
        return AssetIcons.process;
      case "qa":
        return AssetIcons.qa;
      case "security":
        return AssetIcons.security;
      case "setting":
        return AssetIcons.setting;
      case "share":
        return AssetIcons.share;
      case "team":
        return AssetIcons.team;
      case "telegram":
        return AssetIcons.telegram;
      case "tensorflow":
        return AssetIcons.tensorflow;
      case "testcase":
        return AssetIcons.testcase;
      case "tools":
        return AssetIcons.tools;
      case "trello":
        return AssetIcons.trello;
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
      case TabSection.portfolio:
        basePath = "assets/portfolio";
        break;
      default:
        break;
    }
    if (path.extension(imageName) == '.svg') {
      return SvgPicture.asset("$basePath/$imageName", width: 60, height: 60);
    }
    return Image.asset("$basePath/$imageName", width: 60, height: 60);
  }

  Widget imageWithSize(double size) {
    var basePath = "assets/content_icons";
    switch (section) {
      case TabSection.tool:
        basePath = "assets/tool_icons";
        break;
      case TabSection.project:
        basePath = "assets/project_icons";
        break;
      case TabSection.portfolio:
        basePath = "assets/portfolio";
      default:
        break;
    }
    if (path.extension(imageName) == '.svg') {
      return SvgPicture.asset(
        "$basePath/$imageName",
        width: size,
        height: size,
      );
    }
    return Image.asset("$basePath/$imageName", width: size, height: size);
  }

  final String imageName;
  final TabSection section;
}
