import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Stream<String> getLiveLocation() async* {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      yield "Please enable GPS";
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        yield "Permission denied";
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      yield "Permission permanently denied";
      return;
    }

    yield* Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    ).asyncMap((Position pos) async {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          pos.latitude,
          pos.longitude,
        );
        Placemark place = placemarks.first;
        return "${place.locality ?? ""}, ${place.administrativeArea ?? ""}, ${place.country ?? ""}";
      } catch (e) {
        return "Error fetching location";
      }
    });
  }
}
