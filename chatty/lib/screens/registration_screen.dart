import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  String email;
  String password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            children:<Widget> [ Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: ktextfield.copyWith(hintText: 'Enter Your Email',),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: ktextfield.copyWith(hintText: 'Enter Your Password'),
                ),
                Text('Atleast 6 characters long'),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async{
                        setState(() {
                          spinner=true;
                        });
                        try {
                          final newuser = await _auth.createUserWithEmailAndPassword(email: email, password: password);

                          if(newuser!=null){
                            Navigator.pushNamed(context, 'chat');
                          }
                          setState(() {
                            spinner=false;
                          });
                        }  catch (e) {
                          print(e);
                        }

                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
            ),],
          ),
        ),
      ),
    );
  }
}
