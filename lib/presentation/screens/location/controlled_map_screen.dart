import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final watchUserLocation = ref.watch(watchLocationProvider);
    final userInitalLocation = ref.watch(userLocationProvider);
    return Scaffold(
      body: userInitalLocation.when(
        data: (data) => _MapAndControls(latitude: data.$1, longitude: data.$2),
        error: (error, stackTrace) => Text('$error'),
        loading: () => const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class _MapAndControls extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const _MapAndControls({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapControllerState = ref.watch(mapControllerProvider);
    return Stack(
      children: [
        _MapView(latitude, longitude),

        // Para salir
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back)),
        ),

        // Ir a la posicion del usuario
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () {
                ref.read(mapControllerProvider.notifier).findUser();
              },
              icon: const Icon(Icons.location_searching)),
        ),

        // Seguir el usuario
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () {
                ref.read(mapControllerProvider.notifier).toggleFollowUser();
              },
              icon: mapControllerState.followUser
                  ? const Icon(Icons.directions_run)
                  : const Icon(Icons.accessibility_new_outlined)),
        ),

        // Seguir usuario
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () {
                ref
                    .read(mapControllerProvider.notifier)
                    .addMarkerCurrentPosition();
              },
              icon: const Icon(Icons.pin_drop)),
        ),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLat;
  final double initialLng;

  const _MapView(this.initialLat, this.initialLng);

  @override
  __MapViewState createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch(mapControllerProvider);
    return GoogleMap(
      markers: mapController.markerSet,
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLat, widget.initialLng),
        zoom: 12,
      ),
      myLocationEnabled: true,
      compassEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: (controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
      onLongPress: (position) {
        ref
            .read(mapControllerProvider.notifier)
            .addMarker(position.latitude, position.longitude);
      },
    );
  }
}
