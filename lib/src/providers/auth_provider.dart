import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:chat_pc/src/models/login_response_model.dart';
import 'package:chat_pc/src/models/user_model.dart';
import 'package:chat_pc/global/environment.dart';


class AuthProvider with ChangeNotifier {

  //final user
  User? user;
  bool _auth = false;
  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get auth => this._auth;
  set auth(bool value){
    this._auth = value;
    notifyListeners();
  }

  //Getters del token static
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    // Read value 
    final token  = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    // delete value 
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    
    this.auth = true;

    final data = {
      'email': email,
      'password': password
    };

    final resp = await http.post(Uri.parse('${Environment.apiUrl}login'),
      body: jsonEncode(data),
      headers: {
        'Content-type':'application/json'
      }
    );

    this.auth = false;
    if(resp.statusCode == 200){
      final loginResponse = loginResonseFromJson(resp.body);
      this.user = loginResponse.user!;
      await this._saveToken(loginResponse.token!);
      return true;
    }else{
      return false;
    }
  }

  Future<LoginResonse> register(String email, String password, String name) async {

    this.auth = true;

    final data = {
      'name': name,
      'email': email,
      'password': password
    };

    final resp = await http.post(Uri.parse('${Environment.apiUrl}new'),
      body: jsonEncode(data),
      headers: {
        'Content-type':'application/json'
      }
    );

    final loginResponse = loginResonseFromJson(resp.body);
    this.auth = false;
    if(resp.statusCode == 200){
      this.user = loginResponse.user!;
      await this._saveToken(loginResponse.token!);
      return loginResponse;
    }else{
      return loginResponse;
    }

  }

  Future<bool> isLoggedIn() async {

    String? token = await this._storage.read(key: 'token');
    if(token == null){
      token = '1';
    }
    final resp = await http.get(Uri.parse('${Environment.apiUrl}renew'),
      headers: {
        'Content-type':'application/json',
        'x-token':token
      }
    );

    final loginResponse = loginResonseFromJson(resp.body);
    this.auth = false;
    if(resp.statusCode == 200){
      this.user = loginResponse.user!;
      await this._saveToken(loginResponse.token!);
      return true;
    }else{
      this.logout();
      return false;
    }

  }

  Future _saveToken(String token) async {
    // Write value 
    return await _storage.write(key: 'token', value: token); 
  }

  Future logout() async {
    // Delete value 
    await _storage.delete(key: 'token'); 
  }

}