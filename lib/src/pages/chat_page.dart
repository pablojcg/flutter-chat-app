import 'dart:io';

import 'package:chat_pc/src/models/messages_response_model.dart';
import 'package:chat_pc/src/providers/auth_provider.dart';
import 'package:chat_pc/src/providers/chat_provider.dart';
import 'package:chat_pc/src/providers/socket_provider.dart';
import 'package:chat_pc/src/theme/theme.dart';
import 'package:chat_pc/src/widgets/chat_message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  List<ChatMessageWidget> _messages = [];
  bool _isTyping = false;
  late ChatProvider chatProvider;
  late SocketProvider socketProvider;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    this.chatProvider   = Provider.of<ChatProvider>(context, listen: false);
    this.socketProvider = Provider.of<SocketProvider>(context, listen: false);
    this.authProvider   = Provider.of<AuthProvider>(context, listen: false);
    this.socketProvider.socket.on('message-personal', _listenMessage);
    _loadHistoty(this.chatProvider.userTo!.uid);
  }

  void _loadHistoty(String userUid) async {
    List<Message> chat = await this.chatProvider.getChat(userUid);
    final history = chat.map((m) => new ChatMessageWidget(
      text: m.message, 
      uid: m.from, 
      animationController: new AnimationController(vsync: this, duration: Duration(milliseconds:0))..forward(),
    ));

    setState(() {
      this._messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic payload){
    //print('Tengo mensaje! $payload');
    ChatMessageWidget message = new ChatMessageWidget(
      text: payload['message'], 
      uid: payload['from'], 
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds:200))
    );

    setState(() {
      this._messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final userTo = chatProvider.userTo;
    final appTheme = Provider.of<ThemeChanger>(context);
    final currentTheme = appTheme.currentTheme;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: appTheme.darkTheme 
          ? Colors.white
          : Colors.black, //change your color here
        ),
        backgroundColor: appTheme.darkTheme
        ? currentTheme.primaryColor
        : Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              child: Text(userTo!.name.substring(0,2), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              backgroundColor: Colors.blue[100],
              maxRadius: 20.0,
            ),
            SizedBox(width: 10.0,), 
            Text(
              userTo.name, 
              style: TextStyle(
                color: appTheme.darkTheme 
                ? Colors.white
                : Colors.black87, 
                fontSize: 15.0, 
                fontWeight: FontWeight.bold
              )
            )
          ],
        ),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, index) => _messages[index],
                reverse: true,
              )
            ), 
            Divider(height: 1.0,), 
            Container(
              color: appTheme.darkTheme
              ? Colors.blueGrey[700]
              : Colors.white,
              child: _inputChat(appTheme),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat(ThemeChanger appTheme){

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto){
                  setState(() {
                    if(texto.trim().length > 0) this._isTyping = true;
                    else this._isTyping = false;
                  });
                },
                decoration: InputDecoration.collapsed(
                  fillColor: Colors.black38,
                  hintText: 'Mensaje',
                  hintStyle: TextStyle(
                    color: appTheme.darkTheme
                    ? Colors.grey
                    : Colors.black38
                  )
                ),
                focusNode: _focusNode,
              )
            ),
            //Boton Enviar
            Container(
              //color: Colors.red,
              //margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS 
              ? CupertinoButton(
                child: Text('Enviar'), 
                onPressed: (this._isTyping) 
                    ? () => _handleSubmit(_textController.text.trim())
                    : null ,
              )
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[300]),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send_rounded,),
                    onPressed: (this._isTyping) 
                    ? () => _handleSubmit(_textController.text.trim())
                    : null ,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text){
    if(text.length == 0) return;

    final newMessage = new ChatMessageWidget(
      text: text, 
      uid: authProvider.user!.uid,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      this._isTyping = false;
    });

    this.socketProvider.socket.emit('message-personal',{
      'from': this.authProvider.user!.uid,
      'to': this.chatProvider.userTo!.uid,
      'message': text
    });

    _textController.clear();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    for(ChatMessageWidget message in _messages)
    {
      message.animationController.dispose();
    }
    this.socketProvider.socket.off('message-personal');
    super.dispose();
  }
}