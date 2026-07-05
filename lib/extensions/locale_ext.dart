import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';

extension LocaleExt on Locale {
  AssetIcons get billPayments => languageCode == 'en'
      ? AssetIcons.billpayments
      : AssetIcons.billpaymentsKH;
  AssetIcons get candidateSelection => languageCode == 'en'
      ? AssetIcons.candidateselection
      : AssetIcons.candidateselectionKH;
  AssetIcons get khqrExperience => languageCode == 'en'
      ? AssetIcons.khqrexperience
      : AssetIcons.khqrexperienceKH;
  AssetIcons get automatedTesting => languageCode == 'en'
      ? AssetIcons.automatedtesting
      : AssetIcons.automatedtestingKH;
  AssetIcons get universalLink => languageCode == 'en'
      ? AssetIcons.universallink
      : AssetIcons.universallinkKH;
  AssetIcons get securitySupport => languageCode == 'en'
      ? AssetIcons.securitysupport
      : AssetIcons.securitysupportKH;
  AssetIcons get liveness =>
      languageCode == 'en' ? AssetIcons.liveness : AssetIcons.livenessKH;
  AssetIcons get loanImplementation =>
      languageCode == 'en' ? AssetIcons.smeloan : AssetIcons.smeloanKH;
  AssetIcons get loanRelated =>
      languageCode == 'en' ? AssetIcons.loanRelated : AssetIcons.loanRelatedKH;
  AssetIcons get iosDevZ1 => languageCode == 'en'
      ? AssetIcons.iosDeveloper
      : AssetIcons.iosDeveloperKH;
}
