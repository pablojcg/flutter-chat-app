import 'dart:io';

class Environment {

  /*
  static String apiUrl = Platform.isAndroid
  ? 'http://192.168.20.59:3000/api/'
  : 'http://localhost:3000/api/';

  static String socketUrl = Platform.isAndroid
  ? 'http://192.168.20.59:3000/'
  : 'http://localhost:3000/';
  */

  static String apiUrl = Platform.isAndroid
  ? 'https://chat-server-pc.herokuapp.com/api/'
  : 'https://chat-server-pc.herokuapp.com/api/';

  static String socketUrl = Platform.isAndroid
  ? 'https://chat-server-pc.herokuapp.com/'
  : 'https://chat-server-pc.herokuapp.com/';

}