import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class MapLocationLoaded extends MapState {
  MapLocationLoaded(this.location);
  final LatLng location;
}

class MapPickupUpdated extends MapState {
  MapPickupUpdated(this.location, this.address);
  final LatLng location;
  final String address;
}

class MapDestinationSelected extends MapState {
  MapDestinationSelected(this.location, this.address);
  final LatLng location;
  final String address;
}

class MapRouteReady extends MapState {

  MapRouteReady({
    required this.pickup,
    required this.pickupAddr,
    required this.destination,
    required this.destAddr,
    required this.polylines,
    required this.markers,
  });
  final LatLng pickup;
  final String pickupAddr;
  final LatLng destination;
  final String destAddr;
  final Set<Polyline> polylines;
  final Set<Marker> markers;
}

class MapPickupUnlocked extends MapState {}
