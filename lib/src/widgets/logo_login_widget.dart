import 'package:flutter/material.dart';

class LogoLoginWidget extends StatelessWidget {

  final String title;

  const LogoLoginWidget({
    Key? key, 
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50.0),
        width: 170.0,
        child: Column(
          children: [
            Image(image: AssetImage('assets/tag-logo.png')),
            SizedBox(height: 20.0,),
            Text(this.title, style: TextStyle(fontSize: 30.0),)
          ],
        ),
      ),
    );
  }
}