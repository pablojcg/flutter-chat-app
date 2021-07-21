import 'package:chat_pc/src/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_pc/src/providers/auth_provider.dart';



class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
   );
  }

  Future checkLoginState(BuildContext context) async {

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final authentic = await authProvider.isLoggedIn();

    if(authentic){
      //TODO conectar al sockeservice
      //Navigator.pushReplacementNamed(context, 'users');
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsersPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
    }else{
      Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
    }
  }
}