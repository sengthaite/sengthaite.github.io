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

  blog("blog.svg", section: SectionType.portfolio),
  githubpf("githubpf.svg", section: SectionType.portfolio),
  gmail("gmail.svg", section: SectionType.portfolio),
  home("home.svg", section: SectionType.portfolio),
  linkedin("linkedin.svg", section: SectionType.portfolio),
  phone("phone.svg", section: SectionType.portfolio),
  telegram("telegram.svg", section: SectionType.portfolio),
  imageprof("image_prof.png", section: SectionType.portfolio),

  billpayments("bill_payment.png", section: SectionType.portfolio),
  billpaymentsKH("bill_payment_kh.png", section: SectionType.portfolio),

  candidateselection("team_building.png", section: SectionType.portfolio),
  candidateselectionKH("team_building_kh.png", section: SectionType.portfolio),

  khqrexperience("khqr.png", section: SectionType.portfolio),
  khqrexperienceKH("khqr_kh.png", section: SectionType.portfolio),

  automatedtesting("automated_testing.png", section: SectionType.portfolio),
  automatedtestingKH(
    "automated_testing_kh.png",
    section: SectionType.portfolio,
  ),

  liveness("liveness.png", section: SectionType.portfolio),
  livenessKH("liveness_kh.png", section: SectionType.portfolio),

  securitysupport("security_hardening.png", section: SectionType.portfolio),
  securitysupportKH(
    "security_hardening_kh.png",
    section: SectionType.portfolio,
  ),

  universallink("universal_link.png", section: SectionType.portfolio),
  universallinkKH("universal_link_kh.png", section: SectionType.portfolio),

  smeloan("sme.png", section: SectionType.portfolio),
  smeloanKH("sme_kh.png", section: SectionType.portfolio),

  loanRelated("loan_related.png", section: SectionType.portfolio),
  loanRelatedKH("loan_related_kh.png", section: SectionType.portfolio),

  iosDeveloper("ios_developer.png", section: SectionType.portfolio),
  iosDeveloperKH("ios_developer_kh.png", section: SectionType.portfolio),

  peermentor("peer_mentor.jpg", section: SectionType.certs),
  bachelor("bachelor_paragon.jpg", section: SectionType.certs),
  itday("it_day.jpg", section: SectionType.certs),
  volunteeryvsd("volunteer_yvsd.jpg", section: SectionType.certs);

  const AssetIcons(this.imageName, {this.section = SectionType.content});

  factory AssetIcons.fromImageName(String name) {
    String imageName = path.basenameWithoutExtension(name);
    switch (imageName.toLowerCase()) {
      case "peer_mentor":
        return AssetIcons.peermentor;
      case "bachelor_paragon":
        return AssetIcons.bachelor;
      case "it_day":
        return AssetIcons.itday;
      case "volunteer_yvsd":
        return AssetIcons.volunteeryvsd;

      case "bill_payment":
        return AssetIcons.billpayments;
      case "bill_payment_kh":
        return AssetIcons.billpaymentsKH;
      case "team_building":
        return AssetIcons.candidateselection;
      case "team_building_kh":
        return AssetIcons.candidateselectionKH;
      case "khqr":
        return AssetIcons.khqrexperience;
      case "khqr_kh":
        return AssetIcons.khqrexperienceKH;
      case "automated_testing":
        return AssetIcons.automatedtesting;
      case "automated_testing_kh":
        return AssetIcons.automatedtestingKH;
      case "liveness":
        return AssetIcons.liveness;
      case "liveness_kh":
        return AssetIcons.livenessKH;
      case "security_hardening":
        return AssetIcons.securitysupport;
      case "security_hardening_kh":
        return AssetIcons.securitysupportKH;
      case "universal_link":
        return AssetIcons.universallink;
      case "universal_link_kh":
        return AssetIcons.universallinkKH;
      case "sme":
        return AssetIcons.smeloan;
      case "sme_kh":
        return AssetIcons.smeloanKH;
      case "loan_related":
        return AssetIcons.loanRelated;
      case "loan_related_kh":
        return AssetIcons.loanRelatedKH;
      case "ios_developer":
        return AssetIcons.iosDeveloper;
      case "ios_developer_kh":
        return AssetIcons.iosDeveloperKH;

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
      case "github_pf":
        return AssetIcons.githubpf;
      case "gmail":
        return AssetIcons.gmail;
      case "home":
        return AssetIcons.home;
      case "linkedin":
        return AssetIcons.linkedin;
      case "phone":
        return AssetIcons.phone;
      case "telegram":
        return AssetIcons.telegram;
      case "image_prof":
        return AssetIcons.imageprof;
      case "tools":
        return AssetIcons.tools;
      default:
        return AssetIcons.logo;
    }
  }

  Widget imageWithStyle({Size? size, Color? color}) {
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
        break;
      default:
        break;
    }
    if (path.extension(imageName) == '.svg') {
      return SvgPicture.asset(
        "$basePath/$imageName",
        width: size?.width,
        height: size?.height,
        colorFilter: color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
      );
    }
    return Image.asset(
      "$basePath/$imageName",
      width: size?.width,
      height: size?.height,
      colorBlendMode: BlendMode.srcIn,
      color: color,
      fit: BoxFit.contain,
    );
  }

  Widget get image {
    return imageWithStyle();
  }

  Widget imageWithSize({double? width, double? height}) {
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
        width: width,
        height: height,
      );
    }
    return Image.asset("$basePath/$imageName", width: width, height: height);
  }

  final String imageName;
  final SectionType section;
}
