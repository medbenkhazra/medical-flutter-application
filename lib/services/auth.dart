import 'dart:convert';

import 'package:health_app/helpers/constant.dart';
import 'package:health_app/pages/login_page.dart';
import 'package:http/http.dart';

class AuthService {
  var loginUri = Uri.parse('${Constants.BASE_URL}/authenticate');
  var registerUri = Uri.parse('${Constants.BASE_URL}/register');

  Future<Response?> login(String username, String password) async {
    print("d5uul l login");
    print(username);
    print(password);
    var res = await post(loginUri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }
        )
        );
    print("5ruuj mn login");
    return res;
  }

  Future<Response?> register(String username, String firstName, String lastName,
      String email, String password) async {
    print("enter to register");
    var res = await post(registerUri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "login": username,
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "langKey": "en"
        }));
    print("send request");
    return res;
  }
}
