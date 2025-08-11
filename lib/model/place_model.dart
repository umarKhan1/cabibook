import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceSuggestion {

  PlaceSuggestion({
    required this.description,
    required this.lat,
    required this.lng,
  });
  final String description;
  final double lat;
  final double lng;

  LatLng get latLng => LatLng(lat, lng);
}
