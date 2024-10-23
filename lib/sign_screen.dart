import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/firebase_auth/firebase_auth_services.dart';
import 'package:firebase_practice/home_page.dart';
import 'package:firebase_practice/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'firebase_auth/custom_button.dart';
import 'firebase_auth/custom_row_text.dart';
import 'firebase_auth/custom_widgets.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final FirebaseAuthService auth=FirebaseAuthService();
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final passController=TextEditingController();
  bool signCentre=false;
  
   saveData()async{
    CollectionReference collectionRef=FirebaseFirestore.instance.collection('Document');
    return collectionRef.add({
      'UserName':nameController.text,
      'Email':emailController.text,
      'Password':passController.text
    }).then((value) => print('Document Done'),).onError((error, stackTrace) => print('ERROR Some'),);
  }

  @override
  void dispose() {
  nameController.dispose();
  emailController.dispose();
  passController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        title: const Text('SignUp',style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Sign Up',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.indigo
          ),),
          CustomWidgets(title: 'Name', label: Text('User Name'),controllers:nameController,),
          const SizedBox(height: 20,),
          CustomWidgets(title: 'Enter Email', label: Text('Email'),controllers: emailController,),
          const SizedBox(height: 20,),
          CustomWidgets(title: 'Enter Password', label: Text('Password'),controllers: passController,),
          const SizedBox(height: 20,),
           signCentre?CircularProgressIndicator(color: Colors.white,): CustomButton(title: 'SignUp',onTap: () {
            saveData();
          },),
          CustomRowText(firstText: 'All ready you have Account?', secondText: 'Login',onTap:
              () {
            Get.to(()=>const LoginPage());
          },)
        ],
      ),
    );
  }
}
