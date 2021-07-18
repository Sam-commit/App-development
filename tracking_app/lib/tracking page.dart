import 'dart:async';
//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {

  late StreamSubscription <Position> positionStream;
  bool loading = false;
  bool tracking = false;
   Icon icon = Icon(Icons.location_searching_outlined);

  double lat=0;
  double lng =0;

  double startlat=0;
  double startlng=0;

  PointLatLng start = PointLatLng(0, 0);
  PointLatLng end = PointLatLng(0, 0);

  Set<Polyline> _polylines={};
  Set <Marker> _marker={} ;
  List<LatLng> polylineCoordinates = [];


  late GoogleMapController _controller;


  Future initiallocation() async{

    await Location().getlocation();
    start = PointLatLng(Location().lat,Location().long);
    startlat = Location().lat;
    startlng = Location().long;

  }

  Future loadlocation() async {

      Location location = Location();
      await location.getlocation();
      lat=location.lat;
      lng=location.long;

      await updatemarkerandcamera();


  }

  Future updatemarkerandcamera() async {



      if(tracking){
        tracking = false;
        positionStream.cancel();
      }

      else {
        tracking = true;
        positionStream =
            Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high)
                .listen((Position position) {
              if (position == null)
                print('error');
              else  {
                lat = position.latitude;
                lng = position.longitude;

                end = PointLatLng(lat, lng);


                 _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target:LatLng(lat,lng),
                   zoom: 18
                ),),);

                setState(() {

                  _marker.add( Marker(
                    markerId: MarkerId("Tracking"),
                    position: LatLng(lat,lng),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),

                  ),);

                });

                setState(()  {
                  _marker.add(Marker(markerId: MarkerId("start"),
                    position: LatLng(lat+0.5,lng),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                  ));

                });

              }
            });

        await setpolylines(end);
      }

  }

  Future setpolylines(PointLatLng end)async{

    print(start);
    print(end);

      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates("AIzaSyDvfsmyHhZ-HV7lHacCOOdYyLwetTONAwQ", start, end);
      result.points.forEach((element) {

        polylineCoordinates.add(LatLng(element.latitude, element.longitude));

      });

      setState(() {
        Polyline polyline = Polyline(polylineId:PolylineId("path"),
        color: Colors.black,
          points: polylineCoordinates
        );

        _polylines.add(polyline);
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(title: Text("Tracking"),),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(lat,lng),zoom: 13.0),
          mapType: MapType.hybrid,
          markers: _marker,
          polylines: _polylines,
          onMapCreated: (GoogleMapController controller){
            _controller = controller;
          },

        ),
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

          await initiallocation();

          setState(() {
            loading = true;
          });

            await loadlocation();

            setState(() {
               loading = false;
            });

            setState(() {
              if(tracking)icon = Icon(Icons.my_location);
              else{
                icon = Icon(Icons.location_searching_outlined);
              }
            });

        },
        child: icon
      ),






    );
  }
}
