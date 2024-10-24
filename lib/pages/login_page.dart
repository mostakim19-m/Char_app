import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  dynamic selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           selectedImage==null? Text('No Image Found'): Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(selectedImage),fit: BoxFit.fill),
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickImage =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickImage != null) {
                    File pickFile = File(pickImage.path);
                    setState(() {
                      selectedImage=pickFile;
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Image Is Empty',
                      backgroundColor: Colors.indigo,
                      textColor: Colors.white,
                    );
                  }
                },
                child: Text('Upload'))
          ],
        ),
      ),
    );
  }
}
