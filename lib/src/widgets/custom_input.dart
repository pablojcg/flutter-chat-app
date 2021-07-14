import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeHolder;
  final TextEditingController textController;
  final TextInputType keyBoardType;
  final bool isPassword;

  const CustomInput({
    Key? key, 
    required this.icon, 
    required this.placeHolder, 
    required this.textController, 
    this.keyBoardType = TextInputType.text, 
    this.isPassword = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.only(top: 5.0, left: 5.0, bottom: 5.0, right: 20.0),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keyBoardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(this.icon),
          focusedBorder: InputBorder.none, 
          border: InputBorder.none,
          hintText: this.placeHolder
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0,5),
            blurRadius: 5.0
          )
        ]
      ),
    );
  }
}