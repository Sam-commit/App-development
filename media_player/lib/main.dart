import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool playing = false;
  IconData playbutton = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;

 @override
  void initState() {

    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: Center(
            child: Title(
              color: Colors.red,
              child: Text(
                'Media Player'
              ),
            ),
          ),
        ),

        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                        image: AssetImage('assets/image.jpg'),

                    ),
                  ),
                ),

              SizedBox(
                height: 50.0,
              ),

              FloatingActionButton(
                onPressed: (
                    ){

                  if(!playing){

                    cache.play("song.mp3");
                    setState(() {
                      playbutton = Icons.pause;
                      playing=true;
                    });
                  }
                  else {
                    _player.pause();
                    setState(() {
                      playbutton = Icons.play_arrow;
                      playing=false;
                    });

                  }

                },

                  child: Icon(

                      playbutton,
                      size: 30.0,
                  ),

              ),

            ],

          ),
        ),

      ),
    );
  }
}
