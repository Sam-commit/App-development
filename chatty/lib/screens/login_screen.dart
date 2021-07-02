import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  String email;
  String password;
  String error='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            children:[ Column(
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
                  height: 28.0,
                ),
                Text(error,style: TextStyle(color: Colors.red),),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: ktextfield.copyWith(hintText: 'Enter Your Email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    password=value;
                  },
                  decoration: ktextfield.copyWith(hintText: 'Enter Your Password')
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async{

                        setState(() {
                          spinner=true;
                        });

                        try {
                          final user =await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(user !=null){
                            Navigator.pushNamed(context, 'chat');
                          }

                          setState(() {
                            spinner=false;
                          });
                        }  catch (e) {

                          setState(() {
                            spinner=false;
                            error='Invalid email or password';
                          });
                        }


                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                      ),
                    ),
                  ),
                ),
              ],
            ),]
          ),
        ),
      ),
    );
  }
}
