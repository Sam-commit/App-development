import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Networking {

  Networking({@required this.url});

  final String url;

  Future getdata()async {

    Response response =await get(Uri.parse(url));

    if(response.statusCode==200) {
      print(response.statusCode);
      var data = response.body;
      return jsonDecode(data);
    }
    else {
      print(response.statusCode);
    }

  }



}