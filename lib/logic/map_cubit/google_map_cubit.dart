// lib/logic/map_cubit/google_map_cubit.dart

// ignore_for_file: use_setters_to_change_properties

import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:cabibook/logic/map_cubit/google_map_state.dart';
import 'package:cabibook/model/place_model.dart';
import 'package:cabibook/utils/app_string.dart';
import 'package:cabibook/utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  late final GoogleMapController mapController;
  LatLng?      _initialLocation;
  LatLng?      pickup;
  String       pickupAddr      = 'My current location';
  LatLng?      destination;
  String       destinationAddr = '';
  bool         pickupLocked    = false;

  final Set<Marker>   markers   = {};
  final Set<Polyline> polylines = {};

  Timer? _debounce;
 Future<void> initLocation() async {
    final pos = await LocationHelper.determinePosition();
    if (pos == null) return;

    _initialLocation = LatLng(pos.latitude, pos.longitude);
    pickup           = _initialLocation;
    pickupAddr       = 'My current location';

    markers
      ..clear()
      ..add(Marker(
        markerId: const MarkerId('pickup'),
        position: pickup!,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
      ));

    emit(MapLocationLoaded(pickup!));
  }

   void onMapCreated(GoogleMapController ctrl) => mapController = ctrl;

  CameraPosition? _lastCameraPos;
  void onCameraMove(CameraPosition pos) {
    _lastCameraPos = pos;
  }

  void onCameraIdle() {
    if (pickupLocked) return;
    if (destination != null) return;
    if (_lastCameraPos == null) return;

    final center = _lastCameraPos!.target;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final address = await _reverseGeocode(center);
      pickup     = center;
      pickupAddr = address;

      // update marker
      markers
        ..removeWhere((m) => m.markerId.value == 'pickup')
        ..add(Marker(
          markerId: const MarkerId('pickup'),
          position: pickup!,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ));

      emit(MapPickupUpdated(pickup!, pickupAddr));
    });
  }

  Future<String> _reverseGeocode(LatLng pos) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        return [
          p.name,
          p.street,
          p.locality,
          p.administrativeArea,
          p.country
        ].where((s) => s?.isNotEmpty ?? false).join(', ');
      }
    } catch (_) { /* swallow */ }
    return 'Unknown address';
  }
 void selectPickup(PlaceSuggestion place) {
    pickup        = place.latLng;
    pickupAddr    = place.description;
    pickupLocked  = true;

    // move map & update marker
    mapController.animateCamera(
      CameraUpdate.newLatLng(pickup!),
    );
    markers
      ..removeWhere((m) => m.markerId.value == 'pickup')
      ..add(Marker(
        markerId: const MarkerId('pickup'),
        position: pickup!,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
      ));

    emit(MapPickupUpdated(pickup!, pickupAddr));
  }
 void selectDestination(PlaceSuggestion place) {
    destination     = place.latLng;
    destinationAddr = place.description;

    // add red marker
    markers
      ..removeWhere((m) => m.markerId.value == 'destination')
      ..add(Marker(
        markerId: const MarkerId('destination'),
        position: destination!,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      ));

    _drawRoute();
  }

  Future<void> _drawRoute() async {
    if (pickup == null || destination == null) return;

    final pt = PolylinePoints(apiKey: EnvoironmentVar.googleMapApiKey);
    final resp = await pt.getRouteBetweenCoordinatesV2(
      request: RoutesApiRequest(
        origin: PointLatLng(pickup!.latitude, pickup!.longitude),
        destination: PointLatLng(
          destination!.latitude,
          destination!.longitude,
        ),
      ),
    );

    if (resp.routes.isEmpty) return;
    final route = resp.routes.first;
    final pts   = route.polylinePoints ?? [];

    final coords = pts.map((p) => LatLng(p.latitude, p.longitude)).toList();
    polylines
      ..clear()
      ..add(Polyline(
        polylineId: const PolylineId('route'),
        points: coords,
        width: 5,
        color: Colors.blue,
      ));

    _zoomToBounds(coords);

    emit(MapRouteReady(
      pickup: pickup!,
      pickupAddr: pickupAddr,
      destination: destination!,
      destAddr: destinationAddr,
      polylines: polylines,
      markers: markers,
    ));
  }

  void _zoomToBounds(List<LatLng> pts) {
    if (pts.isEmpty) return;
    double minLat = pts.first.latitude;
    double maxLat = pts.first.latitude;
    double minLng = pts.first.longitude;
    double maxLng = pts.first.longitude;
    for (final p in pts) {
      if (p.latitude  < minLat) minLat = p.latitude;
      if (p.latitude  > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }
    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }
  /// Clears *only* the destination + route, leaves pickup alone.
  void clearDestination() {
    destination     = null;
    destinationAddr = '';
    markers.removeWhere((m) => m.markerId.value == 'destination');
    polylines.clear();
    if (pickup != null) {
      emit(MapPickupUpdated(pickup!, pickupAddr));
    }
  }
void clearPickup() {
    pickupLocked    = false;
    destination     = null;
    destinationAddr = '';
    polylines.clear();
    markers.clear();

    if (_initialLocation != null) {
      pickup     = _initialLocation;
      pickupAddr = 'My current location';
      markers.add(Marker(
        markerId: const MarkerId('pickup'),
        position: pickup!,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
      ));
      emit(MapLocationLoaded(pickup!));
    }
  }

   @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
