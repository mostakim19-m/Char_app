import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/custom_widgets/custom_button.dart';
import 'package:firebase_practice/custom_widgets/custom_text_field.dart';
import 'package:firebase_practice/firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/home_page.dart';
import 'package:firebase_practice/pages/chat_app.dart';
import 'package:firebase_practice/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey=GlobalKey<FormState>();
  bool passChange = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuthService auth=FirebaseAuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.message,
                  size: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Welcome back, You are missed',style: TextStyle(
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
                const SizedBox(height: 60,),
                CustomButton(title: 'Login',onTap: () {
                  loginIn();
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
                    const Text('Do not have Account?',style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                    ),),
                    const SizedBox(width: 15,),
                    InkWell(
                      onTap: () {
                        Get.to(()=>RegisterScreen());
                      },
                      child: Text('Register now',style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),),
                    )

                  ],
                )
              ],
            )),
      ),
    );
  }
  void loginIn() async {
    String email=emailController.text;
    String password=passwordController.text;

    User?user=await auth.signInWithEmailAndPassword(email, password);

    if (user!=null){
      Fluttertoast.showToast(msg: 'Login Successfully Done',
          backgroundColor: Colors.indigo,textColor: Colors.white);
      Get.to(()=>ChatApp(email: emailController.text,));
    }else{
      print('Login ERROR ERROR');
    }
  }
}
