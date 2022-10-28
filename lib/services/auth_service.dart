import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = '172.16.102.190:3010';
  String email = '';
  String password = '';

  Future<bool?> loginUser(String email, String password) async {
    
    print('entrando a la funcion');
    var url =
        Uri.http(_baseUrl, '/user', {'usuario': email, 'password': password});

    print('Peticion realizada a: $url');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Todo en orden pasa');
      return (true);
    }
    if (response.statusCode == 400) {
      print('User not found ');
      return (false);
    }
    return false;//ante cualquier cosa retornar false. 
  }
}
