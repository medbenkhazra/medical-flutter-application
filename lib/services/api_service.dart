import 'dart:convert';

import 'package:health_app/helpers/constant.dart';
import 'package:health_app/models/AppointmentModel.dart';
import 'package:health_app/models/PatientModel.dart';
import 'package:health_app/models/dectectionModel.dart';
import 'package:health_app/models/doctor_model.dart';
import 'package:health_app/models/maladie.dart';
import 'package:health_app/pages/doctor/doctorHomePage.dart';
import 'package:health_app/pages/doctor/drawerDoctorScreen.dart';
import 'package:health_app/pages/login_page.dart';
import 'package:health_app/pages/patient/drawerPatientScreen.dart';
import 'package:health_app/pages/secretaire/drawerSecretaireScreen.dart';
import 'package:health_app/services/api_service.dart';
import 'package:health_app/services/apiinterceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:time_machine/time_machine.dart';

class ApiService {
  Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  Future<Response> getMyProfile() async {
    String token = await LoginPageState.storage.read(key: "token") as String;

    var myProfileUri = Uri.parse('${Constants.BASE_URL}/account');

    final res = await get(
      myProfileUri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );

    return res;
  }

  Future<Response> getUserList() async {
    var userUrl = Uri.parse('${Constants.BASE_URL}/users');
    final res = await client.get(userUrl);
    return res;
  }

  Future<Response> makeAppointement(
      DateTime dateTime, DoctorModel model) async {
    var AppUrl = Uri.parse('${Constants.BASE_URL}/rendez-vous');

    String token = await LoginPageState.storage.read(key: "token") as String;

    var idPatient = await LoginPageState.storage.read(key: 'idPatient');

    Map data = {
      'date': Instant.dateTime(dateTime).toString(),
      'status': "being_processed",
      'patient': LoginPageState.currentUserData['patient'],
      'medecin': DoctorModel(
              id: model.id,
              code: model.code,
              numEmp: model.numEmp,
              nom: model.nom,
              prenom: model.prenom,
              expertLevel: model.expertLevel,
              photo: model.photo,
              photoContentType: model.photoContentType,
              type: model.type,
              nbrPatients: model.nbrPatients,
              rating: model.rating,
              description: model.description)
          .toJson()
    };
    var body = json.encode(data);

    final res = await post(AppUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: body
        /* body: jsonEncode(<String, String>{
          //'date': Instant.dateTime(dateTime).toString(),
          'date': Instant.dateTime(dateTime).toString(),
          'status': "being processed",
          'patient': '{"id": $idPatient }',
          'medecin': '{"id": ${model.id} }'
        } */
        );

    return res;
  }

  Future<Response> getDiagnosticResult(String base64Image) async {
    print("entred to getDiagnosticResult");
    print(base64Image);
    var DetectionUrl = Uri.parse('${Constants.BASE_URL}/detections');

    String token = await LoginPageState.storage.read(key: "token") as String;
    MaladieModel maladie=MaladieModel(nom: 'brain cancer');
    DetectionModel detection=DetectionModel(id: null,photo: base64Image, photoContentType: 'image/png',maladie: maladie);

    Map<String,dynamic> dataObject=detection.toJson();
    print(dataObject);
   /*  Map data = {
      // 'date': Instant.dateTime(dateTime).toString(),
      'photo': base64Image,
      //'patient': LoginPageState.currentUserData['patient'],
      //'medecin': DoctorModel(id: model.id, code: model.code, numEmp: model.numEmp, nom: model.nom, prenom: model.prenom, expertLevel: model.expertLevel, photo: model.photo, photoContentType: model.photoContentType, type: model.type, nbrPatients: model.nbrPatients, rating: model.rating, description: model.description).toJson()
    }; */
    //var body = json.encode(data);
    var body = json.encode(dataObject);
    final res = await post(DetectionUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: body
        /* body: jsonEncode(<String, String>{
          //'date': Instant.dateTime(dateTime).toString(),
          'date': Instant.dateTime(dateTime).toString(),
          'status': "being processed",
          'patient': '{"id": $idPatient }',
          'medecin': '{"id": ${model.id} }'
        } */
        );

    return res;
  }

  Future<Response> AcceptAppointement(AppointmentModel model) async {
    var AppUrl = Uri.parse('${Constants.BASE_URL}/rendez-vous/${model!.id}');

    String token = await LoginPageState.storage.read(key: "token") as String;

    final res = await patch(AppUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: jsonEncode(<String, String>{
          //'date': Instant.dateTime(dateTime).toString(),
          'id': model!.id.toString(),
          'date': Instant.dateTime(model!.date!).toString(),
          //'code': model!.code.toString(),
          'status': "accepted",
          //'patient': model!.patient!.toJson().toString(),
          // 'medecin': model!.patient!.toJson().toString(),
        }));

    return res;
  }

  Future<Response> RefuseAppointement(AppointmentModel model) async {
    var AppUrl = Uri.parse('${Constants.BASE_URL}/rendez-vous/${model!.id}');

    String token = await LoginPageState.storage.read(key: "token") as String;
    Map data = {
      'id': model!.id.toString(),
      'status': "refused",
    };
    var body = json.encode(data);

    final res = await patch(AppUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: body);

    return res;
  }

  Future<Response> AdjournAppointement(AppointmentModel model) async {
    var AppUrl = Uri.parse('${Constants.BASE_URL}/rendez-vous/${model!.id}');

    String token = await LoginPageState.storage.read(key: "token") as String;

    Map data = {
      'id': model!.id.toString(),
      'status': "adjourned",
    };
    var body = json.encode(data);

    final res = await patch(AppUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: body);

    return res;
  }

  Future<Response> getDoctors() async {
    var doctorsUrl = Uri.parse('${Constants.BASE_URL}/medecins');

    String token = await LoginPageState.storage.read(key: "token") as String;

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

  Future<Response> getPatientOfUser() async {
    var idPatient = DrawerPatientScreenState.idPatient;

    var doctorsUrl = Uri.parse('${Constants.BASE_URL}/patients/$idPatient');

    String token = await LoginPageState.storage.read(key: "token") as String;

    final res = await get(
      doctorsUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );

    var data = json.decode(res.body);

    return res;
  }

  Future<Response> getDoctorOfUser() async {
    var idDoctor = DrawerDoctorScreenState.idDoctor;

    var doctorUrl = Uri.parse('${Constants.BASE_URL}/medecins/$idDoctor');

    String token = await LoginPageState.storage.read(key: "token") as String;

    final res = await get(
      doctorUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );

    var data = json.decode(res.body);

    return res;
  }
  Future<Response> getSecretaireOfUser() async {
    var idSecretaire = DrawerSecretaireScreenState.idSecretaire;

    var secretaireUrl = Uri.parse('${Constants.BASE_URL}/secretaires/$idSecretaire');

    String token = await LoginPageState.storage.read(key: "token") as String;

    final res = await get(
      secretaireUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );

    var data = json.decode(res.body);

    return res;
  }

  Future<Response> getAppointments() async {
    var AppointmentsUrl = Uri.parse('${Constants.BASE_URL}/rendez-vous');

    String token = await LoginPageState.storage.read(key: "token") as String;

    final res = await get(
      AppointmentsUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );

    return res;
  }

  Future<Response> getAppointmentsOfDoctor() async {
    print("entred to getAppointmentsOfDoctor");
    print(DoctorHomePageState.idDoctor);
    var AppointmentsUrl = Uri.parse(
        '${Constants.BASE_URL}/medecins/${DoctorHomePageState.idDoctor}');

    String token = await LoginPageState.storage.read(key: "token") as String;

    final res = await get(
      AppointmentsUrl,
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
    var token = await LoginPageState.storage.read(key: "token");

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
