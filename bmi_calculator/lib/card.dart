import 'package:flutter/material.dart';

class Cardme extends StatelessWidget {

  Cardme({@required this.colour,this.cardw});

  final Color colour;
  final Widget cardw;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: cardw,
            decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ));
  }
}
