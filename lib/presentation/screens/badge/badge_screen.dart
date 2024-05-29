import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badgeCounter = ref.watch(badgeCounterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Badge'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(badgeCounterProvider.notifier).update(
            (state) {
              final newCount = state + 1;
              AppBadgePlugin.updateBadgeCount(newCount);
              return newCount;
            },
          );
        },
        child: const Icon(Icons.plus_one),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge.count(count: badgeCounter),
            Badge(
              alignment: Alignment.lerp(
                  Alignment.topRight, Alignment.bottomRight, 0.2),
              label: Text(badgeCounter.toString()),
              child: Text(
                badgeCounter.toString(),
                style: const TextStyle(fontSize: 150),
              ),
            ),
            FilledButton.tonal(
                onPressed: () {
                  ref.invalidate(badgeCounterProvider);
                },
                child: const Text('Borrar Badge'))
          ],
        ),
      ),
    );
  }
}
