import 'package:chat_pc/src/providers/auth_provider.dart';
import 'package:chat_pc/src/providers/chat_provider.dart';
import 'package:chat_pc/src/providers/socket_provider.dart';
import 'package:chat_pc/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_pc/src/routes/routes.dart';
import 'package:provider/provider.dart';

 
void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => ThemeChanger(1),
    child: MyApp()
  ));
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new AuthProvider(),),
        ChangeNotifierProvider(create: (_) => new SocketProvider(),),
        ChangeNotifierProvider(create: (_) => new ChatProvider(),),
      ],
      child: MaterialApp(
        theme: appTheme.currentTheme,
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}