import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{

  late bool _darkTheme, _customTheme = false;
  ThemeData _currentTheme = ThemeData.light() ;

  ThemeChanger(int theme){
    switch(theme){
      case 1:
        this._darkTheme = false;
        this._currentTheme = ThemeData.light();
      break;

      case 2:
        this._darkTheme = true;
        this._currentTheme = ThemeData.dark().copyWith(
          //accentColor: Colors.orange,
          accentColor: Colors.blue[100]
        );
      break;

      default:
        this._darkTheme = false;
        this._currentTheme = ThemeData.light();
    }
  }

  bool get darkTheme => this._darkTheme;
  ThemeData get currentTheme => this._currentTheme;

  set darkTheme( bool value){
    this._darkTheme = value;

    if(value){
      this._currentTheme = ThemeData.dark().copyWith(
        //accentColor: Colors.orange,
        accentColor: Colors.blue[100]
      );
    }else{
      this._currentTheme = ThemeData.light();
    }

    notifyListeners();
  }

}