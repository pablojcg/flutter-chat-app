import 'package:flutter/material.dart';

class LabelsLoginWidget extends StatelessWidget {

  final String route;
  final String title;
  final String titleButton;

  const LabelsLoginWidget({
    Key? key, 
    required this.route, 
    required this.title, 
    required this.titleButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.title, style: TextStyle(color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.w300),),
          SizedBox(height: 10.0,),
          GestureDetector(
            child: Text(
             this.titleButton, 
              style: TextStyle(color: Colors.blue.shade600, fontSize:  18.0, fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.pushReplacementNamed(context, this.route);
            },
          )
        ],
      ),
    );
  }
}