import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/location/user_location_provider.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPostionAsync = ref.watch(userLocationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: currentPostionAsync.when(
        data: (pos) => _MapView(pos.$1, pos.$2),
        error: (error, stackTrace) => Text('$error'),
        loading: () => const CircularProgressIndicator.adaptive(),),
    );
  }
}

class _MapView extends StatefulWidget {

  final double initialLat;
  final double initialLng;

  const _MapView(this.initialLat, this.initialLng);

  @override
  State<_MapView> createState() => __MapViewState();
}

class __MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLat, widget.initialLng)
      ),
      myLocationEnabled: true,
      onMapCreated: (controller) {
        
      },
    );
  }
}