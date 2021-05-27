import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'card.dart';
import 'main.dart';
import 'matter.dart';

class Result extends StatelessWidget {

  Result({this.status,this.bmi,this.statement,this.col});

  final Color col;
 final String status;
  final String bmi;
  final String statement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF673ab7),
        title: Text(
          'RESULTS',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),

      body: Column(

        children: [
          SizedBox(height: 10,),

          Cardme(colour: Colors.white10,
          cardw: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              Center(
                child: Text(status,
                style: TextStyle(
                  fontSize: 30.0,
                  color: col,
                  fontWeight: FontWeight.w700,

                ),
                ),
              ),
              Center(
                child: Text(bmi,
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Center(
                child: Text(statement,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey
                  ),

                ),
              ),

            ],

          ),
          )  ,

          GestureDetector(

            onTap: (){
              //Navigator.pushNamed(context, 'home');
              Navigator.pop(context);
            },

            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              color: Color(0xFF673ab7),
              height: 65.0,
              child: Center(
                  child: Text(
                    'Re-Calculate',
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  )),
            ),
          ),

        ],

      ),

    );
  }
}
