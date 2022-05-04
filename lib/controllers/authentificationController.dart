import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class Authentification {
  static var response;
  static const API_IP = 'http://10.0.2.2:8080/api';
  //final storage = FlutterSecureStorage();
  static var storageJwt=FlutterSecureStorage();
  static var jwtAuthen;
  static Future<String?> attemptLogIn(String username, String password,bool rememberMe) async {
    print("d5ul attempt login");
    var urlLog = Uri.parse("${API_IP}/authenticate");
    print("made a parse");
    var res = await http.post(urlLog,
        headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
        );
        response=res.body;
        print("send a request");
    if (res.statusCode == 200) return res.body;
    return null;
  }

  static Future<int> attemptSignUp(String username, String password) async {
  var urlSignUp = Uri.parse("${API_IP}/register");
  var res = await http.post(
   urlSignUp,
    body: {
      "username": username,
      "password": password
    }
  );
  return res.statusCode;  
}

}
