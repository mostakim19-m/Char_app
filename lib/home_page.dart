import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/firebase_auth/custom_button.dart';
import 'package:firebase_practice/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Home Page',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
          color: Colors.white
        ),),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(title: 'LogOut',onTap: () {
            FirebaseAuth.instance.signOut();
            Fluttertoast.showToast(msg: 'LogOut Successfully done',textColor: Colors.white,backgroundColor: Colors.indigo);
            Get.to(()=>LoginPage());
          },),
        ],
      ),
    );
  }
}
