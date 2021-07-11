import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String apikey = 'a45c5a793a2398f99e5451a680999686';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}




  class _LoadingScreenState extends State<LoadingScreen> {

    double latitude;
    double longitude;

  @override
  void initState() {
    super.initState();
    getcurrentlocationdata();
  }


  void getcurrentlocationdata() async{

    Location location= Location();
    await location.getlocation();

    latitude = location.latitude;
    longitude = location.longitude;
    
    Networking networking = Networking(url: 'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey');
    
    var weatherdata = await networking.getdata();
    print(weatherdata);


  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: (){

          },
          child: Text('Get Location')
          ,
        ),
      ),
    );
  }
}
