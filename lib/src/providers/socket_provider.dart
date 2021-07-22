import 'package:flutter/material.dart';
import 'package:chat_pc/global/environment.dart';
import 'package:chat_pc/src/providers/auth_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus{
  Online,
  Offline,
  Connecting
}

class SocketProvider with ChangeNotifier
{
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;


  void connect() async {

    final token = await AuthProvider.getToken();

    // Dart client
    //String url = 'http://192.168.20.59:3000/'; // Local
    String url = 'https://socketio-server-pc.herokuapp.com/'; // Heroku Server
    this._socket = IO.io(Environment.socketUrl,IO.OptionBuilder()
      .setTransports(['websocket'])
      .enableAutoConnect()
      .enableForceNew()
      .setExtraHeaders({
        'x-token':token
      })
      .build()
    );

    this._socket.onConnect((_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
      //socket.emit('msg', 'test');
    });
    

    //socket.on('event', (data) => print(data));

    this._socket.onDisconnect((_) {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
    //socket.on('fromServer', (_) => print(_));

    this._socket.on('nuevo-mensaje', ( payload ) {
      print('nuevo-mensaje: $payload');
      print('nombre: ' + payload['nombre']);
      print('mensaje: ' + payload['mensaje']);
      print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'No hay Mensaje');
      print(payload['mensaje2'] ?? 'No hay Nada 2!!');
    });

  }

  void disconnect(){
    this._socket.disconnect();
  }

}