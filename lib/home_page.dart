import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth=FirebaseAuthService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Home Page'),
      ),
      body: Center(child: ElevatedButton(onPressed: (){
        FirebaseAuth.instance.signOut();
        Fluttertoast.showToast(msg: 'LogOut Success.',
            backgroundColor: Colors.indigo,textColor: Colors.white);
        Get.to(()=>LoginPage());
      }, child: Text('Home Button')),),
    );
  }
}
