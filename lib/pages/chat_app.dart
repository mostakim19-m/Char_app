import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/pages/login_page.dart';
import 'package:firebase_practice/pages/message_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChatApp extends StatefulWidget {
  final String email;
  const ChatApp({super.key, required this.email});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  final messageController=TextEditingController();
  final FirebaseFirestore firebaseFire=FirebaseFirestore.instance;
  final FirebaseAuth auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text(widget.email),
    centerTitle: true,
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal:30)
        ),
          onPressed: (){
        FirebaseAuth.instance.signOut();
        Fluttertoast.showToast(msg: 'LogOut Success.',
            backgroundColor: Colors.indigo,textColor: Colors.white);
        Get.to(()=>LoginPage());
      }, child: Text('SignOut',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
      ),))
    ],
  ),
      body: SingleChildScrollView(child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height *0.8,
            child: MessageScreen(email: widget.email,),
          ),
          Padding(padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(child:TextFormField(
                  onSaved: (value) {
                    messageController.text=value!;
                  },
                  controller: messageController,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Message',
                    filled: true,
                    fillColor: Colors.black.withOpacity(.13),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width:2
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.indigoAccent,
                        width: 3
                      )
                    )
                  ),
                ) ),
            IconButton(onPressed: (){
              if(messageController.text.isNotEmpty){
                firebaseFire.collection('Message').doc().set({
                  'message':messageController.text.trim(),
                  'time':DateTime.now(),
                  'email':widget.email
                });
                messageController.clear();
              }
            }, icon: Icon(Icons.send,color: Colors.indigoAccent,size: 32,))
          ],),),

        ],
      ),),
    );
  }
}
