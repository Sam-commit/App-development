import 'package:flutter/material.dart';

const TextStyle labelstyle= TextStyle(
    fontSize: 18.0,
    color: Colors.grey
);

class matter extends StatelessWidget {

  matter({this.pic,this.label});

  final IconData pic;
  final String label;

  @override

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          pic,
          size: 80.0,

        ),

        SizedBox(
          height: 15.0,
        ),

        Text(label,
          style: labelstyle )
      ],
    );
  }
}