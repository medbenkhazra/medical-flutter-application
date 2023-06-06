import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:health_app/models/PatientModel.dart';
import 'package:health_app/pages/login_page.dart';
import 'package:health_app/pages/patient/components/MenuWidgets.dart';
import 'package:health_app/pages/patient/components/body.dart';
import 'package:get/get.dart';
import 'package:health_app/pages/patient/drawerPatientScreen.dart';
import 'package:health_app/services/api_service.dart';
import 'package:http/http.dart' as http;

class PatientHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PatientHomePageState();
}

class PatientHomePageState extends State<PatientHomePage> {
  Image? image;
  bool? _loadingInProgress;
  ApiService apiService=new ApiService();
  static var userData;
  static String? ImageOfUser;
  static var idPatient;

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((_) async {
      //await this.getWeatherData();
      getActualUser().then((userData) {
        var patient = PatientModel.fromJson(userData['patient']);
        print("iiiiiisssssssssssssssss the patient id");
        print(patient.id);
        setState(() {
          DrawerPatientScreenState.idPatient = patient.id;
        });
        print(DrawerPatientScreenState.idPatient);
        DrawerPatientScreenState.idPatient = patient.id;
        print("the actual user is iiiiiisssssssssssssssss");
        print(patient.id);
        storeUser();

        setState(() {
          LoginPageState.username;
        });
      });
    });
  }
    void storeUser() async {
    await LoginPageState.storage
        .write(key: 'id', value: userData['id'].toString());
    await LoginPageState.storage.write(key: 'login', value: userData['login']);
    await LoginPageState.storage
        .write(key: 'firstName', value: userData['firstName']);
    await LoginPageState.storage
        .write(key: 'lastName', value: userData['lastName']);
    await LoginPageState.storage.write(key: 'email', value: userData['email']);
    await LoginPageState.storage
        .write(key: 'authorities', value: userData['authorities'].toString());
    var patient = PatientModel.fromJson(userData['patient']);
    await LoginPageState.storage
        .write(key: 'idPatient', value: patient.id.toString());

    LoginPageState.username = await LoginPageState.storage.read(key: 'login');
    LoginPageState.firstName =
        await LoginPageState.storage.read(key: 'firstName');
    LoginPageState.lastName =
        await LoginPageState.storage.read(key: 'lastName');
    print('this is the username ${LoginPageState.username}');
    print('this is the firstname ${LoginPageState.firstName}');
    print('this is the lastname ${LoginPageState.lastName}');
  }

  Future getActualUser() async {
    var res = await apiService.getMyProfile();
    userData = json.decode(res.body);

    return userData;
  }

  void displayImage() async {
    print("entred to displayImage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) => [
              SliverAppBar(
                  actions: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 7, 7, 0),
                      child: FloatingActionButton.small(
                        onPressed: () {},
                        child: FutureBuilder(
                          future: apiService.getPatientOfUser(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return CircularProgressIndicator();// your widget while loading
                            }

                            if (!snapshot.hasData) {
                              return Container(); //your widget when error happens
                            }

                            var res = snapshot.data; //your Map<String,dynamic>
                            var data=json.decode(res.body); 

                            return ClipOval(
                                child: Image.memory(
                              base64Decode(
                                  data['photo'].toString()),
                            )
                            ); //place your widget here
                          },
                        ),
                        /*  ClipOval(
                      child: Image.memory(
                    base64Decode(DrawerPatientScreenState.ImageOfUser!),
                  )
                  ), */
                      ),
                    ),
                  ],
                  backgroundColor: Color(0xFF0857de),
                  elevation: 0,
                  leading: MenuWidget()),
            ]),
        body: Body(),
      ),
      //body: Body(),
    );
  }
}
