import 'dart:io';

class Environment {

  static String apiUrl = Platform.isAndroid
  ? 'http://192.168.20.59:3000/api/login/'
  : 'http://localhost:3000/api/login/';

  static String socketUrl = Platform.isAndroid
  ? 'http://192.168.20.59:3000'
  : 'http://localhost:3000';

}