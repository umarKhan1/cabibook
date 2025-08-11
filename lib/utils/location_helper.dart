import 'package:geolocator/geolocator.dart';

class LocationHelper {
  
  static Future<Position?> determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied) return null;
    }
    if (perm == LocationPermission.deniedForever) return null;
    return  Geolocator.getCurrentPosition();
  }
}
