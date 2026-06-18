import 'package:flutter/material.dart';
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
  github("github.svg", section: SectionType.tool),
  camera("camera.svg", section: SectionType.tool),
  textEditor("text_editor.svg", section: SectionType.tool),
  http("http.svg", section: SectionType.tool),
  cal("calculator.svg", section: SectionType.tool),
  qrcode("qrcode.png", section: SectionType.tool),

  apk("apk.svg", section: SectionType.portfolio),
  appstore("app-store.svg", section: SectionType.portfolio),
  appsflyer("appsflyer.png", section: SectionType.portfolio),
  blog("blog.svg", section: SectionType.portfolio),
  camdx("camdx.png", section: SectionType.portfolio),
  createml("createml.png", section: SectionType.portfolio),
  download("download.svg", section: SectionType.portfolio),
  githubpf("githubpf.svg", section: SectionType.portfolio),
  gmail("gmail.svg", section: SectionType.portfolio),
  goal("goal.svg", section: SectionType.portfolio),
  home("home.svg", section: SectionType.portfolio),
  ipa("ipa.svg", section: SectionType.portfolio),
  khqr("khqr.png", section: SectionType.portfolio),
  linkedin("linkedin.svg", section: SectionType.portfolio),
  manager("manager.svg", section: SectionType.portfolio),
  mlkit("mlkit.png", section: SectionType.portfolio),
  mobile("mobile.svg", section: SectionType.portfolio),
  phone("phone.svg", section: SectionType.portfolio),
  planning("planning.svg", section: SectionType.portfolio),
  playstore("playstore.svg", section: SectionType.portfolio),
  process("process.svg", section: SectionType.portfolio),
  qa("qa.svg", section: SectionType.portfolio),
  securitypf("securitypf.svg", section: SectionType.portfolio),
  setting("setting.svg", section: SectionType.portfolio),
  share("share.svg", section: SectionType.portfolio),
  team("team.svg", section: SectionType.portfolio),
  telegram("telegram.svg", section: SectionType.portfolio),
  tensorflow("tensorflow.svg", section: SectionType.portfolio),
  testcase("testcase.svg", section: SectionType.portfolio),
  toolspf("tools.svg", section: SectionType.portfolio),
  trello("trello.svg", section: SectionType.portfolio),

  automatedtesting("automated_testing.svg", section: SectionType.certs),
  billpayments("bill_payment.svg", section: SectionType.certs),
  candidateselection("candidate_selection.svg", section: SectionType.certs),
  khqrexperience("khqr.svg", section: SectionType.certs),
  liveness("liveness.svg", section: SectionType.certs),
  otherloanenhancements(
    "other_loan_enhancements.svg",
    section: SectionType.certs,
  ),
  securitysupport("securityexperience.svg", section: SectionType.certs),
  smeloan("sme_loan.svg", section: SectionType.certs),
  universallink("universal_link.svg", section: SectionType.certs),
  z1("z1_zpoint.svg", section: SectionType.certs);

  const AssetIcons(this.imageName, {this.section = SectionType.content});

  factory AssetIcons.fromImageName(String name) {
    String imageName = path.basenameWithoutExtension(name);
    switch (imageName.toLowerCase()) {
      case "automated_testing":
        return AssetIcons.automatedtesting;
      case "bill_payment":
        return AssetIcons.billpayments;
      case "candidate_selection":
        return AssetIcons.candidateselection;
      case "khqrpf":
        return AssetIcons.khqrexperience;
      case "liveness":
        return AssetIcons.liveness;
      case "other_loan_enhancements":
        return AssetIcons.otherloanenhancements;
      case "securityexperience":
        return AssetIcons.securitysupport;
      case "sme_loan":
        return AssetIcons.smeloan;
      case "universal_link":
        return AssetIcons.universallink;
      case "z1_zpoint":
        return AssetIcons.z1;
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
        return AssetIcons.githubpf;
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
      case "securitypf":
        return AssetIcons.securitypf;
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

  Widget imageWithStyle({Size size = const Size(60, 60), Color? color}) {
    var basePath = "assets/content_icons";
    switch (section) {
      case SectionType.tool:
        basePath = "assets/tool_icons";
        break;
      case SectionType.project:
        basePath = "assets/project_icons";
        break;
      case SectionType.portfolio:
        basePath = "assets/portfolio";
        break;
      default:
        break;
    }
    if (path.extension(imageName) == '.svg') {
      return SvgPicture.asset(
        "$basePath/$imageName",
        width: size.width,
        height: size.height,
        colorFilter: color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
      );
    }
    return Image.asset(
      "$basePath/$imageName",
      width: size.width,
      height: size.height,
      colorBlendMode: BlendMode.srcIn,
      color: color,
    );
  }

  Widget get image {
    return imageWithStyle();
  }

  Widget imageWithSize(double size) {
    var basePath = "assets/content_icons";
    switch (section) {
      case SectionType.tool:
        basePath = "assets/tool_icons";
        break;
      case SectionType.project:
        basePath = "assets/project_icons";
        break;
      case SectionType.portfolio:
        basePath = "assets/portfolio";
      case SectionType.certs:
        basePath = "assets/certs_archivements";
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
  final SectionType section;
}
