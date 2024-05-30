import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AdRewardedScreen extends ConsumerWidget {
  const AdRewardedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adRewardedAsync = ref.watch(adRewardedProvider);
    final adPoints = ref.watch(admobPointsProvider);
    ref.listen(
      adRewardedProvider,
      (previous, next) {
        if (!next.hasValue) return;
        if (next.value == null) return;
        next.value!.show(
          onUserEarnedReward: (ad, reward) {
            print('Puntos ganados: ${reward.amount}');
            ref.read(admobPointsProvider.notifier).update(
              (state) {
                final newPoints = state + reward.amount.toInt();
                return newPoints;
              },
            );
          },
        );
      },
    );

    if (adRewardedAsync.isLoading) {
      return const Scaffold(
        body: Center(
          child: Text('Loading Ad...'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Rewarded Screen'),
      ),
      body: Center(
        child: Text('Puntos actuales: $adPoints'),
      ),
    );
  }
}
