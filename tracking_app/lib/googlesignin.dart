import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';



class Googlesignin {

  // void firestart() async{
  //   await Firebase.initializeApp();
  // }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isSignIn =false;
  bool google =false;

  Future<OAuthCredential> signing_in() async{

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;


    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


   return credential;

  }




}