class AdsHelper {
  static const bool isTest = false;

  static String testBanner = "ca-app-pub-3940256099942544/9214589741";
  static String testInterstitialAd = "ca-app-pub-3940256099942544/1033173712";

  static String debtorBanner =
      isTest ? testBanner : "ca-app-pub-9223984531296789/2993085760";
  static String creditorBanner =
      isTest ? testBanner : "ca-app-pub-9223984531296789/6427002119";
  static String settingBanner =
      isTest ? testBanner : "ca-app-pub-9223984531296789/7283684567";
  static String interstitialAd =
      isTest ? testInterstitialAd : "ca-app-pub-9223984531296789/5886842418";
}
