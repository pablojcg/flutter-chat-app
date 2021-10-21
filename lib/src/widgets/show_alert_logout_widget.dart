import 'package:chat_pc/src/providers/auth_provider.dart';
import 'package:chat_pc/src/providers/socket_provider.dart';
import 'package:chat_pc/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

 showAlertLogout(BuildContext context){

    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) {
        final appTheme = Provider.of<ThemeChanger>(context, listen: false);
        final socketProvider = Provider.of<SocketProvider>(context, listen: false);
        
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('¿Quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                AuthProvider.deleteToken();
                //Navigator.pushReplacementNamed(context, 'login');
                socketProvider.disconnect();
                appTheme.darkTheme = false;
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