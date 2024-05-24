import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gyroscope$ = ref.watch(gyroscopeProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Giroscopio Ball'),
        ),
        body: SizedBox.expand(
          child: gyroscope$.when(
            data: (value) => MovingBall(x: value.x, y: value.y),
            error: (error, stackTrace) => Text('Error: $error'),
            loading: () => const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator.adaptive()),
          ),
        ));
  }
}

class MovingBall extends StatelessWidget {
  final double x;
  final double y;

  const MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    double screenWidth = size.width;
    double screenHeight = size.height;

    double currentYpos = ( y * 1000 );
    double currentXpos = ( x * 1000 );

    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          '''
        x: $x,
        y: $y
        ''',
          style: const TextStyle(fontSize: 30),
        ),
        AnimatedPositioned(
          left: (currentYpos - 25) + (screenWidth / 2),
          top: (currentXpos - 25) + (screenHeight / 2),
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 1000),
            child: const Ball()),
      ],
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(100)),
    );
  }
}
