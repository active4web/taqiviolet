import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }
    }else{
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
    return null;}
}