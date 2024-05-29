import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class MapState {
  final bool isReady;
  final bool followUser;
  final List<Marker> markers;
  final GoogleMapController? controller;

  MapState(
      {this.isReady = false,
      this.followUser = false,
      this.markers = const [],
      this.controller});

  Set<Marker> get markerSet {
    return markers.toSet();
  }

  MapState copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) {
    return MapState(
      isReady: isReady ?? this.isReady,
      followUser: followUser ?? this.followUser,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  StreamSubscription? userLocation$;
  (double, double)? lastKnownLocation;

  MapNotifier() : super(MapState()) {
    trackUser().listen(
      (event) {
        lastKnownLocation = (event.$1, event.$2);
      },
    );
  }

  Stream<(double, double)> trackUser() async* {
    await for (final pos in Geolocator.getPositionStream()) {
      yield (pos.latitude, pos.longitude);
    }
  }

  void setMapController(GoogleMapController controller) {
    state = state.copyWith(controller: controller, isReady: true);
  }

  void goToLocation(double lat, double lng) {
    final newPostiion = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 15,
    );
    state.controller
        ?.animateCamera(CameraUpdate.newCameraPosition(newPostiion));
  }

  void toggleFollowUser() {
    state = state.copyWith(followUser: !state.followUser);
    if (state.followUser) {
      findUser();
      userLocation$ = trackUser().listen(
        (pos) {
          goToLocation(pos.$1, pos.$2);
        },
      );
    } else {
      userLocation$?.cancel();
    }
  }

  void findUser() {
    if (lastKnownLocation == null) return;
    final (lat, lng) = lastKnownLocation!;
    goToLocation(lat, lng);
    /*trackUser().take(1).listen(
      (pos) {
        goToLocation(pos.$1, pos.$2);
      },
    );*/
  }

  void addMarker(double lat, double lng, [String name = '', String body = '']) {
    final newMarker = Marker(
        markerId: MarkerId(const Uuid().v4()),
        position: LatLng(lat, lng),
        onTap: () {
          print('Tap en el marcador: $name en lat: $lat, lng: $lng');
        },
        infoWindow: InfoWindow(
          title: name,
          snippet: body,
        ));
    state = state.copyWith(markers: [...state.markers, newMarker]);
  }

  void addMarkerCurrentPosition(
      [String name = 'Por aqui paso el usuario', String body = '']) {
    if (lastKnownLocation == null) return;
    final (lat, lng) = lastKnownLocation!;
    addMarker(lat, lng, name, body);
  }
}

final mapControllerProvider =
    StateNotifierProvider.autoDispose<MapNotifier, MapState>((ref) {
  return MapNotifier();
});
