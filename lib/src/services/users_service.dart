import 'package:chat_pc/global/environment.dart';
import 'package:chat_pc/src/models/user_model.dart';
import 'package:chat_pc/src/models/users_response_model.dart';
import 'package:chat_pc/src/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class UsersService {

  Future<List<User>> getUsers() async {
    try{
      final resp = await http.get(Uri.parse('${Environment.apiUrl}users'),
        headers: {
          'Content-type':'application/json',
          'x-token': await AuthProvider.getToken()
        }
      );

      final userResponse = usersResponseFromJson(resp.body);

      return userResponse.users!;
      
    }catch(e){
      return [];
    }
  }

  Future<List<User>> getUsersByEmail(String email) async {
    try{
      final resp = await http.get(Uri.parse('${Environment.apiUrl}users/userbyid?email=$email'),
        headers: {
          'Content-type':'application/json',
          'x-token': await AuthProvider.getToken()
        }
      );

      final userResponse = usersResponseFromJson(resp.body);

      return userResponse.users!;
      
    }catch(e){
      return [];
    }
  }

}