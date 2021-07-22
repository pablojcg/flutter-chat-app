import 'package:chat_pc/src/providers/chat_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_pc/src/providers/auth_provider.dart';
import 'package:chat_pc/src/providers/socket_provider.dart';
import 'package:chat_pc/src/services/users_service.dart';
import 'package:chat_pc/src/widgets/show_alert_logout_widget.dart';
import 'package:chat_pc/src/models/user_model.dart';



class UsersPage extends StatefulWidget {

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final usersProvider = new UsersService();

  List<User> usuarios = [];

  /*
  final usuarios = [
    User(online: true, email: 'maria@email.com', name: 'Maria', uid: '1'),
    User(online: false, email: 'jessika@email.com', name: 'Jessika', uid: '2'),
    User(online: true, email: 'salome@email.com', name: 'Salomé', uid: '3')
  ];
  */

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
    final socketProvider = Provider.of<SocketProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(authProvider.user!.name, style: TextStyle(color: Colors.black54),),
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54),
          onPressed: (){
            print('Click Logout');
            socketProvider.disconnect();
            showAlertLogout(context);
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            //child: ,
            child: (socketProvider.serverStatus == ServerStatus.Online) 
            ? Icon(Icons.check_circle, color: Colors.blue[400],)
            : Icon(Icons.offline_bolt, color: Colors.red,),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _listViewUsers()
      )
   );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, index) => _usuarioListTitle(usuarios[index]), 
      separatorBuilder: (_, index) => Divider(), 
      itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTitle(User usuario) {
    return ListTile(
      title: Text(usuario.name),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.name.substring(0,2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
      onTap: (){
        final chatService = Provider.of<ChatProvider>(context, listen: false);
        chatService.userTo = usuario;
        Navigator.pushNamed(context, 'chat');
        //print(usuario.email);
      },
    );
  }

  _cargarUsuarios() async {

    

    this.usuarios = await usersProvider.getUsers();
    setState(() {});
    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

}