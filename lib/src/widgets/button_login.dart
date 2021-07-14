import 'package:flutter/material.dart';

class ButtonLoginWidget extends StatelessWidget {
  
  final String texto;
  final Color color;
  final double widthButton;
  final double heightButton;
  final void Function() onPressed;

  const ButtonLoginWidget({
    Key? key, 
    required this.texto, 
    required this.color, 
    required this.widthButton, 
    required this.heightButton, 
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(2.0),
        backgroundColor: MaterialStateProperty.all<Color>(this.color),
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      ),
      onPressed: this.onPressed, 
      child: Container(
        width: this.widthButton,
        height: this.heightButton,
        child: Center(
          child: Text(this.texto, style: TextStyle(color: Colors.white, fontSize: 18.0),),
        ),
      )
    );
  }
}