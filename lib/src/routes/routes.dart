import 'package:chat_pc/src/pages/add_user_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_pc/src/pages/chat_page.dart';
import 'package:chat_pc/src/pages/loading_page.dart';
import 'package:chat_pc/src/pages/login_page.dart';
import 'package:chat_pc/src/pages/register_page.dart';
import 'package:chat_pc/src/pages/users_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users'      : ( _ ) => UsersPage(),
  'chat'       : ( _ ) => ChatPage(),
  'loading'    : ( _ ) => LoadingPage(),
  'login'      : ( _ ) => LoginPage(),
  'register'   : ( _ ) => RegisterPage(),
  'contacts'   : ( _ ) => AddUserPage()
};