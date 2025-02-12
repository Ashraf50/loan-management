import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdsHelper {
  static const bool isTest = false;

  static String testBanner = "ca-app-pub-3940256099942544/9214589741";
  static String testInterstitialAd = "ca-app-pub-3940256099942544/1033173712";

  static String debtorBanner =
      isTest ? testBanner : dotenv.env["DEBTOR_BANNER"]!;
  static String creditorBanner =
      isTest ? testBanner : dotenv.env["CREDITOR_BANNER"]!;
  static String settingBanner =
      isTest ? testBanner : dotenv.env["SETTING_BANNER"]!;
  static String interstitialAd =
      isTest ? testInterstitialAd : dotenv.env["INTERSTITIAL_AD"]!;
}
