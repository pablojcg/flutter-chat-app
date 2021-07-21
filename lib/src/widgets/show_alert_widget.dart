import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String title, String subTitle){
  if(Platform.isAndroid){
    return showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(subTitle),
        actions: [
          MaterialButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
            elevation: 5.0,
            textColor: Colors.blue,
          )
        ],
      ), 
    );
  }

  showCupertinoDialog(
    barrierDismissible: false,
    context: context, 
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context)
        )
      ],
    ), 

  );
  
}