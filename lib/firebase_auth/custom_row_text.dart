import 'package:flutter/material.dart';

class CustomRowText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final void Function()?onTap;
  const CustomRowText({super.key, required this.firstText, required this.secondText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(firstText,style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        SizedBox(width: 8,),
        InkWell(
          onTap: onTap,
          child: Text(secondText,style: TextStyle(
            color: Colors.indigoAccent,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
        ),
      ],
    );
  }
}
