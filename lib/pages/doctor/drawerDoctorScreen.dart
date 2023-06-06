import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:health_app/models/PatientModel.dart';
import 'package:health_app/pages/doctor/doctorContent.dart';
import 'package:health_app/pages/login_page.dart';
import 'package:health_app/pages/patient/menuPage.dart';
import 'package:health_app/pages/patient/patientContent.dart';
import 'package:health_app/services/api_service.dart';

class DrawerDoctorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawerDoctorScreenState();
}

class DrawerDoctorScreenState extends State<DrawerDoctorScreen> {
  MenuItem currentItem = MenuItems.home;
  static var userData;
  static String? ImageOfUser;
  static var idDoctor;

  //static var userName;

  ApiService apiService = new ApiService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   /*  WidgetsBinding.instance!.addPostFrameCallback((_) async {
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
    }); */
    
 /*  getActualUser().then((userData) {
      
      var patient = PatientModel.fromJson(userData['patient']);
      print("iiiiiisssssssssssssssss the patient id");
      print(patient.id);
      setState(() {
        DrawerPatientScreenState.idPatient=patient.id;
      });
      print(DrawerPatientScreenState.idPatient);
      DrawerPatientScreenState.idPatient=patient.id;
      print("the actual user is iiiiiisssssssssssssssss");
      print(patient.id);
      storeUser();
     
      setState(() {
        LoginPageState.username;
      });
      
      
    }); */
    
  }

/*     Future getPatientOfUser() async{
    //get Doctors of this Patient
      var res=await apiService.getPatientOfUser();
      print("aaaaaaaaaaaaaa ${res.statusCode}");
      var PatientOfUserData=json.decode(res.body);
      print(PatientOfUserData);

    return PatientOfUserData;
  } */

/*   void storeUser() async {
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
  } */

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.defaultStyle,
      borderRadius: 30,
      angle: -5,
      slideWidth: MediaQuery.of(context).size.width * 0.6,
      menuBackgroundColor: Color(0xFF0857de),
      showShadow: true,
      mainScreenScale: 0,
      mainScreen: getScreen()!,
      menuScreen: Builder(
        builder: (context) => MenuPage(
          currentItem: currentItem,
          onSelectedItem: (item) {
            setState(() {
              currentItem = item;
            });
            ZoomDrawer.of(context)!.close();
          },
        ),
      ),
    );
  }

  Widget? getScreen() {
    switch (currentItem) {
      case MenuItems.home:
        return DoctorContent();

      case MenuItems.meeting:
        DoctorContentState.selectedIndex = 1;
        return DoctorContent();
      case MenuItems.calendar:
        DoctorContentState.selectedIndex = 2;
        return DoctorContent();
      case MenuItems.profile:
        DoctorContentState.selectedIndex = 3;
        return DoctorContent();
      default:
    }
  }
}
