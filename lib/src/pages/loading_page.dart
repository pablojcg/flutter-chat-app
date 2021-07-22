import 'package:chat_pc/src/pages/users_page.dart';
import 'package:chat_pc/src/providers/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_pc/src/providers/auth_provider.dart';



class LoadingPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final socketProvider = Provider.of<SocketProvider>(context, listen: false);
    
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
        future: checkLoginState(context, socketProvider),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
   );
  }

  Future checkLoginState(BuildContext context, SocketProvider socketProvider) async {

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final authentic = await authProvider.isLoggedIn();

    if(authentic){
      if(socketProvider.serverStatus != ServerStatus.Online) socketProvider.connect();
      Navigator.of(context).pushNamedAndRemoveUntil('users', (Route<dynamic> route) => false);
      //Navigator.pushReplacementNamed(context, 'users');
      /*
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsersPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
      */
      /*
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsersPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
      */
    }else{
      Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
    }
  }
  
}