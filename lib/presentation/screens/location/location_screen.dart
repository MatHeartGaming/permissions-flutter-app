import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/location/watch_location_provider.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLocationAsync = ref.watch(userLocationProvider);
    final watchLocation$ = ref.watch(watchLocationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicacion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ubicacion actual'),
            userLocationAsync.when(
              data: (location) => Text('$location'),
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator.adaptive(),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text('Seguimiento de Ubicacion'),
            watchLocation$.when(
              data: (location) => Text('$location'),
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
      ),
    );
  }
}
