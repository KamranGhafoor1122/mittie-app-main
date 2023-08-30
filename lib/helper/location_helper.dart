
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

 Future<String> getLocation() async
{

  LocationPermission permission = await Geolocator.requestPermission();
  Position position = await
  Geolocator.getCurrentPosition(desiredAccuracy:
  LocationAccuracy.high);

  List<Placemark> addresses = await
  placemarkFromCoordinates(position.latitude,position.longitude);

  var first = addresses.first;
  print("adress first  ${first.subLocality}, ${first.locality}, ${first.country}");

  return "${first.subLocality}, ${first.locality}, ${first.country}";
}