import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscelaneos/config/config.dart';

final adBannerProvider = FutureProvider<BannerAd>((ref) async {
  // TODO: Validar si se muestran o no los ads
  final ad = await AdmobPlugin.loadBannerAd();
  return ad;
});

final adInterstitialProvider = FutureProvider.autoDispose<InterstitialAd>((ref) async {
  // TODO: Validar si se muestran o no los ads
  final ad = await AdmobPlugin.loadInterstitialAd();
  return ad;
});

final adRewardedProvider = FutureProvider.autoDispose<RewardedAd>((ref) async {
  // TODO: Validar si se muestran o no los ads
  final ad = await AdmobPlugin.loadRewardedAd();
  return ad;
});
