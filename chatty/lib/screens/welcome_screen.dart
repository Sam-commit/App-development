import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation animation;

  void firestart() async{
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    firestart();
    controller = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this
    );

    animation = ColorTween(begin: Colors.black12,end: Colors.white).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });


  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [TypewriterAnimatedText('C.H.A.T.T.Y',
                    speed: Duration(milliseconds: 200)
                    )],
                    pause: Duration(seconds: 4),

                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Button(text: 'Log in',path: 'login',color: Colors.lightBlueAccent,),
            Button(text: 'Register',path: 'reg',color: Colors.blueAccent,)
          ],
        ),
      ),
    );
  }
}


