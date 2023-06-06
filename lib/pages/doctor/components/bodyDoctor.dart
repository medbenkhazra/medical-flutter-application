import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:health_app/helpers/constant.dart';
import 'package:health_app/models/AppointmentModel.dart';
import 'package:health_app/models/data.dart';
import 'package:health_app/models/doctor_model.dart';
import 'package:health_app/pages/doctor/appointmentDetailsPage.dart';
import 'package:health_app/pages/doctor/doctorHomePage.dart';
import 'package:health_app/pages/doctor/drawerDoctorScreen.dart';
import 'package:health_app/pages/login_page.dart';
import 'package:health_app/pages/patient/PatientHomePage.dart';
import 'package:health_app/pages/patient/components/header_with_searchBox.dart';
import 'package:health_app/pages/patient/components/recommendation.dart';
import 'package:health_app/pages/patient/doctorDetails.dart';
import 'package:health_app/pages/patient/patientContent.dart';

import 'package:health_app/services/api_service.dart';
import 'package:health_app/theme/extention.dart';
import 'package:time_machine/time_machine.dart' as timeMachine;

//class Body extends StatelessWidget {
class BodyDoctor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyDoctorState();
}

class _BodyDoctorState extends State<BodyDoctor> {
  List<AppointmentModel>? appointmentDataList;
  Image? image;
  ApiService apiService = new ApiService();
  var Appointmentsdata;
  bool _isVisible = false;
  static var userData;
  @override
  void initState() {
    super.initState();
    getActualUser().then((userData) {
      var doctor = DoctorModel.fromJson(userData['medecin']);
      print("iiiiiisssssssssssssssss the doctor id");
      print(doctor.id);
      setState(() {
        DrawerDoctorScreenState.idDoctor = doctor.id;
      });
      print(DrawerDoctorScreenState.idDoctor);
      DrawerDoctorScreenState.idDoctor = doctor.id;
      print("the actual user is iiiiiisssssssssssssssss");
      print(doctor.id);
      storeUser();

      setState(() {
        LoginPageState.username;
        LoginPageState.firstName = doctor.nom;
        LoginPageState.lastName = doctor.prenom;

        DoctorHomePageState.idDoctor = doctor.id;
        print("ttttttt");
        print(doctor.id);
        print(DoctorHomePageState.idDoctor);
      });
      //get Appointments of this doctor
      getAppointments().then((Appointmentsdata) {
        print("liiiiiist 2");
        print(Appointmentsdata['rendezVous']);
        setState(() {
          appointmentDataList =
              (Appointmentsdata['rendezVous'] as List<dynamic>)
                  .map((x) => AppointmentModel.fromJson(x))
                  .toList();
          _isVisible = !_isVisible;
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
    var doctor = DoctorModel.fromJson(userData['medecin']);
    await LoginPageState.storage
        .write(key: 'idDoctor', value: doctor.id.toString());

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

  Future getAppointments() async {
    var res = await apiService.getAppointmentsOfDoctor();
    Appointmentsdata = json.decode(res.body);
    print(res.statusCode);
    // print("lisst of Appointments !!!!!!!!!!!!!!!");
    // print(Appointmentsdata);
    print("***zonedDateTime dart example***");
    print(timeMachine.ZonedDateTime(timeMachine.Instant.now()));
    print(timeMachine.Instant.now().inUtc());
    print(timeMachine.Instant.now().inLocalZone());
    print("///////this is the date time utc");

    // print(timeMachine.ZonedDateTime(json.decode("2022-01-01T22:41:32Z")).toDateTimeUtc());
    print("datetime now");
    print(DateTime.now());
    print(Appointmentsdata);
    return Appointmentsdata;
  }

  void delay() async {
    await Future.delayed(const Duration(seconds: 10), () {});
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          // TitleWithMoreBtn(title: "Doctors", press: () {}),
          //  Recomendation(),
          /*   SizedBox(
            height: 10,
          ), */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Patients", style: TextStyles.title.bold),
              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {})
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ).hP16,
          SizedBox(
            height: 20,
          ),
          getAppointmentsWidgetList(),
          /*  Container(
            child: (image != null)
                ? image
                : FlutterLogo(
                    size: 20,
                  ),
          ), */

          //SizedBox(height: Constants.kDefaultPadding),
        ],
      ),
    );
  }

  Widget getAppointmentsWidgetList() {
    return Visibility(
      visible: _isVisible,
      child: Column(
          children: (appointmentDataList != null)
              ? 
              appointmentDataList!.where((x) => x.status=="accepted").map((x) {
                  return _appointmentTile(x);
                }).toList()
              : [
                  Text('data not loaded yet'),
                  Text('data not loaded yet'),
                ]),
    );
  }

  Widget _appointmentTile(AppointmentModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                //possible colors : 5c8fe6 86acec 417ee4
                color: Color(0xFF417ee4),
              ),
              child: Image.memory(
                //attention
                base64Decode(model.patient!.photo!),
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text("${model.patient!.nom} ${model.patient!.prenom}",
              style: TextStyles.title.bold),
          /* subtitle: Text(
            model.status!,
            style: TextStyles.bodySm.subTitleColor.bold,
          ), */
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ).ripple(
        () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AppointmentDetailsPage(model: model)));
          /*   Navigator.of(context).push(MaterialPageRoute(
            builder: (_)=> AppointmentDetailsPage(model: model)
            )
            ); */
          //Navigator.pushNamed(context, "/DetailPage", arguments: model);
        },
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
