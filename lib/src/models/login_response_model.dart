// To parse this JSON data, do
//
//     final loginResonse = loginResonseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_pc/src/models/user_model.dart';

LoginResonse loginResonseFromJson(String str) => LoginResonse.fromJson(json.decode(str));

String loginResonseToJson(LoginResonse data) => json.encode(data.toJson());

class LoginResonse {
    LoginResonse({
      required  this.ok,
      required  this.msg,
      this.user,
      this.token,
    });

    bool ok;
    String msg;
    User? user;
    String? token;

    factory LoginResonse.fromJson(Map<String, dynamic> json) {
      
      if(json.containsKey('user')){
        return LoginResonse(
          ok: json["ok"],
          msg: json["msg"],
          user: User.fromJson(json["user"]),
          token: json["token"],
        );
      }

      return LoginResonse(
        ok: json["ok"],
        msg: json["msg"]
      );
      
    }

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "user": user!.toJson(),
        "token": token,
    };
}


