import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  FirebaseAuth auth =FirebaseAuth.instance;

  Future<User?>signUpWithEmailAndPassword(String email,String password)async{

    try{
      UserCredential credential =await auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch (e){
      print('ERROR ERROR ERROR ERROR');
    }
    return null;
  }
  Future<User?>signInWithEmailAndPassword(String email,String password)async{

    try{
      UserCredential credential =await auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch (e){
      print('ERROR ERROR error occurred');
    }
    return null;
  }
}