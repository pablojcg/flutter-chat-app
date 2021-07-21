 import 'package:chat_pc/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';

 showAlertLogout(BuildContext context){  
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('¿Quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                AuthProvider.deleteToken();
                //Navigator.pushReplacementNamed(context, 'login');
                Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
              },
              child: Text('SI')
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('NO')
            )
          ],
        );
      }
    );
 }