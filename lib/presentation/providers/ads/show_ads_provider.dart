import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';

const showAdsKey = 'showAds';

final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});

class ShowAdsNotifier extends StateNotifier<bool> {
  ShowAdsNotifier() : super(false) {
    checkAdsState();
  }

  Future<void> checkAdsState() async {
    state = await SharedPrefsPlugin.getBool(showAdsKey) ?? true;
  }

  void showAds() {
    SharedPrefsPlugin.setBool(showAdsKey, true);
    state = true;
  }

  void removeAds() {
    SharedPrefsPlugin.setBool(showAdsKey, false);
    state = false;
  }

  void toggleAds() {
    state ? removeAds() : showAds();
  }
}
