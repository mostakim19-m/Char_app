import 'package:flutter/material.dart';

class CustomWidgets extends StatelessWidget {
  final String title;
  final Widget ? icon;
  final Widget ? label;
  final bool?obscure;
  final TextEditingController? controllers;
  final void Function()? onTap;
  final String? Function(String?)? valid;
  const CustomWidgets({super.key, required this.title,
    this.icon, this.obscure, this.controllers, this.onTap, this.valid, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: TextFormField(
          obscureText:obscure?? false,
          onTap:onTap,
          controller: controllers,
          validator: valid,
          decoration: InputDecoration(
            hintText: title,
            label:label ,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black
            ),
            suffixIcon: icon,
            hintStyle: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black,
                width: 3
              )
            ),
            focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 3
                )
            ),
            errorBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Colors.red,
                    width: 3
                )
            )
      )
        ),
      ),
    );
  }
}
