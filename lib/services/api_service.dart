import 'dart:convert';

import 'package:health_app/helpers/constant.dart';
import 'package:health_app/pages/login_page.dart';
import 'package:health_app/services/api_service.dart';
import 'package:health_app/services/apiinterceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class ApiService {
  Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  Future<Response> getMyProfile() async {
    print("eneted to getMyprofile funct");
    print("this is the current token");
    print(await LoginPageState.storage.read(key: "token"));
    String token = await LoginPageState.storage.read(key: "token") as String;
    print("token");
    print(token);
    var userUrl = Uri.parse('${Constants.BASE_URL}/admin/users');
    var myProfileUri = Uri.parse('${Constants.BASE_URL}/account');
    print("**********");
    print(jsonEncode(token));

    final res = await get(
      myProfileUri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    print("get request is sent");
    return res;
  }

  Future<Response> getUserList() async {
    var userUrl = Uri.parse('${Constants.BASE_URL}/users');
    final res = await client.get(userUrl);
    return res;
  }

  Future<Response> getDoctors() async {
    var doctorsUrl = Uri.parse('${Constants.BASE_URL}/medecins');
    
    String token = await LoginPageState.storage.read(key: "token") as String;
    print("haahuwa token $token");
    final res = await get(
      doctorsUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );

    return res;
  }

  Future<Response> getUserById(String id) async {
    var userUrl = Uri.parse('${Constants.BASE_URL}/users/$id');
    final res = await client.get(userUrl);
    return res;
  }

  Future<Response> addUser(int roleId, String email, String password,
      String fullname, String phone) async {
    var userUrl = Uri.parse('${Constants.BASE_URL}/users');

    final res = await client.post(userUrl, body: {
      "role_id": roleId.toString(),
      "email": email,
      "password": password,
      "fullname": fullname,
      "phone": phone
    });
    return res;
  }

  Future<Response> updateUser(String login, String firstName, String lastName,
      String email, String password) async {
    print("entred to updated");
    print("this is the current token");
    print(await LoginPageState.storage.read(key: "token"));
    var token = await LoginPageState.storage.read(key: "token");
    print("token");
    print(token);
    var userUrl = Uri.parse('${Constants.BASE_URL}/admin/users');
    final res = await put(userUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          "login": login,
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password
        }));
    print("put request sent, maybe  hhh !!");
    print('Token : ${token}');
    return res;
  }

  Future<Response> deleteUser(String id) async {
    var userUrl = Uri.parse('${Constants.BASE_URL}/users/$id');
    final res = await client.delete(userUrl);
    return res;
  }
  //For roles

  Future<Response> getRoleList() async {
    var rolerUrl = Uri.parse('${Constants.BASE_URL}/roles');
    final res = await client.get(rolerUrl);
    return res;
  }

  Future<Response> getRoleById(String id) async {
    var rolerUrl = Uri.parse('${Constants.BASE_URL}/roles/$id');
    final res = await client.get(rolerUrl);
    return res;
  }

  Future<Response> addRole(String roleName, String roleDescription) async {
    var rolerUrl = Uri.parse('${Constants.BASE_URL}/roles');
    final res = await client.post(rolerUrl,
        body: {"role_name": roleName, "role_description": roleDescription});
    return res;
  }

  Future<Response> updateRole(
      int? id, String roleName, String roleDescription) async {
    var rolerUrl = Uri.parse('${Constants.BASE_URL}/roles/$id');
    final res = await client.put(rolerUrl,
        body: {"role_name": roleName, "role_description": roleDescription});
    return res;
  }

  Future<Response> deleteRole(String id) async {
    var rolerUrl = Uri.parse('${Constants.BASE_URL}/roles/$id');
    final res = await client.delete(rolerUrl);
    return res;
  }

  Future<Response> addPermissiontoRole(int? id, List<int?> permissions) async {
    var permissionUrl =
        Uri.parse('${Constants.BASE_URL}/roles/permissions/$id');
    final res = await client
        .post(permissionUrl, body: {"permissions": jsonEncode(permissions)});
    return res;
  }
}
