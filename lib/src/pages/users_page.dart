import 'package:flutter/material.dart';
import 'package:chat_pc/src/models/user_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsersPage extends StatefulWidget {

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(online: true, email: 'maria@email.com', nombre: 'Maria', uid: '1'),
    Usuario(online: false, email: 'jessika@email.com', nombre: 'Jessika', uid: '2'),
    Usuario(online: true, email: 'salome@email.com', nombre: 'Salomé', uid: '3')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Nombre', style: TextStyle(color: Colors.black54),),
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54),
          onPressed: (){},
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            //child: Icon(Icons.check_circle, color: Colors.blue[400],),
            child: Icon(Icons.offline_bolt, color: Colors.red,),
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

  ListTile _usuarioListTitle(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0,2)),
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
    );
  }

  _cargarUsuarios() async {
     // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

}