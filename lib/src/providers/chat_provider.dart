import 'package:chat_pc/global/environment.dart';
import 'package:chat_pc/src/models/messages_response_model.dart';
import 'package:chat_pc/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_pc/src/models/user_model.dart';


class ChatProvider with ChangeNotifier {

  User? userTo;

  Future<List<Message>> getChat(String userUid) async {
    final resp = await http.get(Uri.parse('${Environment.apiUrl}messages/$userUid'),
      headers: {
          'Content-type':'application/json',
          'x-token': await AuthProvider.getToken()
        }
    );

    final messagesResp = messagesResponseFromJson(resp.body);
    
    return messagesResp.messages;
  }
}