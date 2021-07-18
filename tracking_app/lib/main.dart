import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/Constants.dart';
import 'package:tracking_app/tracking page.dart';
import 'package:tracking_app/googlesignin.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      theme: ThemeData.dark().copyWith(),
    );
  }
}

class Homepage extends StatefulWidget {


  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  String username="";
  String password="";

  void check(){
    print(username);
    print(password);
  }

  // void firestart() async{
  //   await Firebase.initializeApp();
  // }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Tracking app"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            TextField(
              decoration: kinputdecoration.copyWith(hintText: "Username"),
              onChanged: (value){
                username = value;
              },

            ),

            SizedBox(height: 15.0,),

            TextField(
              decoration: kinputdecoration.copyWith(hintText: "Password"),
              onChanged: (value){
                password = value;
                check();
              },

            ),

            SizedBox(height: 20.0),

            RawMaterialButton(onPressed:()async{

              // final user = await _auth.signInWithEmailAndPassword(email: username, password: password);

              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Tracking()),
              ) ;

            },

                constraints: BoxConstraints(minHeight: 50,minWidth: 300),
                elevation: 10,
                fillColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),

                child: Text("Sign In"),
            ),
            SizedBox(height: 10,),
            SizedBox(height: 2,child: Container(color: Colors.black,),),
            SizedBox(height: 10,),

            RawMaterialButton(onPressed:() async {

              FirebaseAuth _auth = FirebaseAuth.instance;

              Googlesignin abc = Googlesignin();

              OAuthCredential credentials = await abc.signing_in();

              await _auth.signInWithCredential(credentials);

              final user = _auth.currentUser;


              if(user!=null){

                  print(_auth.currentUser);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Tracking()));
              }
              else{

                print("error");

              }

            },

              constraints: BoxConstraints(minHeight: 50,minWidth: 300),
              elevation: 10,
              fillColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

              child: Text("Sign In with Google",
                style: TextStyle(color: Colors.black),
              ),
            ),



          ],

        ),
      ),
    );
  }
}

