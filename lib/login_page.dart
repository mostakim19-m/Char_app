import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/firebase_auth/custom_button.dart';
import 'package:firebase_practice/firebase_auth/custom_row_text.dart';
import 'package:firebase_practice/firebase_auth/custom_widgets.dart';
import 'package:firebase_practice/firebase_auth/firebase_auth_services.dart';
import 'package:firebase_practice/home_page.dart';
import 'package:firebase_practice/sign_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthService auth=FirebaseAuthService();
  final emailController=TextEditingController();
  final passController=TextEditingController();
  bool index=true;
  bool loginCentre=false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Login',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white
        ),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Login',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.indigo
          ),),
          CustomWidgets(title: 'Enter Email', label: Text('Email'),controllers:emailController ,),
          const SizedBox(height: 20,),
          CustomWidgets(title: 'Enter Password',controllers: passController,

            icon: InkWell(
              onTap: () {
                setState(() {
                  index= !index;
                });
              },
                child:index? Icon(Icons.visibility_off):Icon(Icons.visibility)),
          obscure: index,label: const Text('Password'),),
          const Align(
            alignment: Alignment.centerRight,
            child: Text('Forget Password',style: TextStyle(
              color: Colors.indigo,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
          ),
          const SizedBox(height: 20,),
          loginCentre?CircularProgressIndicator(color: Colors.white,):
          CustomButton(title: 'Login',onTap: () {
            login();
          },),
          CustomRowText(firstText: 'Do"t have Account?', secondText: 'Sign Up',onTap:
            () {
            Get.to(()=>const SignScreen());
            },)
        ],
      )
          
    );
  }
  void login() async{

    setState(() {
      loginCentre=true;
    });
    String email=emailController.text;
    String password=passController.text;

    User? user=await auth.signInWithEmailAndPassword(email, password);

    setState(() {
      loginCentre=false;
    });

    if(user!=null){
      Fluttertoast.showToast(msg: 'SigIn Your  Successfully Done',
          backgroundColor: Colors.indigo,textColor: Colors.white);
      Get.to(()=>HomePage());
    }else{
    return null;
    }
}
}
