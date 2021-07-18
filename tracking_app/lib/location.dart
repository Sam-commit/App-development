import 'package:geolocator/geolocator.dart';

class Location {

    double lat=0;
    double long=0;

    Future<void> getlocation() async{

        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        lat = position.latitude;
        long = position.longitude;
        // Geolocator.getPositionStream()

    }



}