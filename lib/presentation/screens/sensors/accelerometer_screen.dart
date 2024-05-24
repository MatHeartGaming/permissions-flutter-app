import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acelerometerProvider$ = ref.watch(accelerometerUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acelerometro'),
      ),
      body: Center(
        child: acelerometerProvider$.when(
          data: (value) => Text('$value', style: const TextStyle(fontSize: 30),),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const CircularProgressIndicator.adaptive(),),
      ),
    );
  }
}
