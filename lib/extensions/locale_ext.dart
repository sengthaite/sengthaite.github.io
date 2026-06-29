import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';

extension LocaleExt on Locale {
  AssetIcons get billPayments => languageCode == 'en'
      ? AssetIcons.billpayments
      : AssetIcons.billpaymentskh;
  AssetIcons get candidateSelection => languageCode == 'en'
      ? AssetIcons.candidateselection
      : AssetIcons.candidateselectionkh;
  AssetIcons get khqrExperience => languageCode == 'en'
      ? AssetIcons.khqrexperience
      : AssetIcons.khqrexperiencekh;
  AssetIcons get automatedTesting => languageCode == 'en'
      ? AssetIcons.automatedtesting
      : AssetIcons.automatedtestingkh;
  AssetIcons get universalLink => languageCode == 'en'
      ? AssetIcons.universallink
      : AssetIcons.universallinkkh;
  AssetIcons get securitySupport => languageCode == 'en'
      ? AssetIcons.securitysupport
      : AssetIcons.securitysupportkh;
  AssetIcons get liveness =>
      languageCode == 'en' ? AssetIcons.liveness : AssetIcons.livenesskh;
  AssetIcons get loanImplementation =>
      languageCode == 'en' ? AssetIcons.smeloan : AssetIcons.smeloankh;
  AssetIcons get loanRelated => languageCode == 'en'
      ? AssetIcons.otherloanenhancements
      : AssetIcons.otherloanenhancementskh;
  AssetIcons get iosDevZ1 =>
      languageCode == 'en' ? AssetIcons.z1 : AssetIcons.z1kh;
}
