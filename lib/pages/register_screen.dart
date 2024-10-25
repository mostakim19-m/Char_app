import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_text_field.dart';
import '../home_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuthService auth=FirebaseAuthService();
  final formKey=GlobalKey<FormState>();

  bool passChange = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conformController = TextEditingController();

  saveRegister() async {
    CollectionReference collected=FirebaseFirestore.instance.collection('SignUp Details');
    return collected.add({
      'Email':emailController.text,
      'Password':passwordController.text,
      'Conform Password':conformController.text
    }).then((value) => print('SignUp ADDED'),).onError((error, stackTrace) => print('ERROR'),);
}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    conformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Chat App',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Form(
            key: formKey,
            child:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.message,
                    size: 80,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Lets Create your account now ',style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.black
                  ),),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    labelText: 'Password',
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passChange = !passChange;
                          });
                        },
                        child: passChange
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    obscureText: passChange,
                    keyBoardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'Enter Conform Password',
                    labelText: 'Conform Password',
                    controller: conformController,
                  ),
                  const SizedBox(height: 60,),
                  CustomButton(title: 'Register Now',onTap: () {
                    registerUp();
                    saveRegister();
                    if(formKey.currentState!.validate()){
                    }
                    return;
                  },),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an Account',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                      ),),
                      const SizedBox(width: 15,),
                      InkWell(
                        onTap: () {
                          Get.to(()=>LoginPage());
                        },
                        child: Text('Login now',style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),),
                      )

                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
 void registerUp()async{
    String email=emailController.text;
    String password=passwordController.text;
    String conform=conformController.text;

    User? user=await auth.signUpWithEmailAndPassword(email, password);
    if(user!=null || password==conform){
      Fluttertoast.showToast(msg: 'Your register successfully',
          backgroundColor: Colors.indigo,textColor: Colors.white);
      Get.to(()=>LoginPage());
    }else{
      print('ERROR Some Wrong');
    }
  }
}
