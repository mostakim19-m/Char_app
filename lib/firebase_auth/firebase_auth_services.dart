import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService{
  FirebaseAuth auth =FirebaseAuth.instance;

  Future<User?>signUpWithEmailAndPassword(String email,String password)async{

    try{
      UserCredential credential =await auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e){
      if (e.code == 'email-already-in-use'){
        Fluttertoast.showToast(msg: 'The Email address is already in used',
            backgroundColor: Colors.indigo,textColor: Colors.white);
      }else{
        Fluttertoast.showToast(msg: 'Error Something',
            backgroundColor: Colors.indigo,textColor: Colors.white);
      }
    }
    return null;
  }
  Future<User?>signInWithEmailAndPassword(String email,String password)async{

    try{
      UserCredential credential =await auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException  catch (e){
      if(e.code == 'user-not-found' || e.code == 'wrong-password'){
        Fluttertoast.showToast(msg: 'Wrong Email And Password',
            backgroundColor: Colors.indigo,textColor: Colors.white);
      }else{
        Fluttertoast.showToast(msg: 'Invalid Email and Password ',
            backgroundColor: Colors.indigo,textColor: Colors.white);
      }
    }
    return null;
  }
}