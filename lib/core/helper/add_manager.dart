import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loan_management/core/helper/ads_helper.dart';

class AddManager {
  InterstitialAd? _interstitialAd;
  void showInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdsHelper.interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          if (_interstitialAd != null) {
            _interstitialAd!.show();
          }
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (error) {
          print("Eror: $error");
        },
      ),
    );
  }
}
