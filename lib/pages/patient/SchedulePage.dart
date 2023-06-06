import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_app/models/AppointmentModel.dart';
import 'package:health_app/models/doctor_model.dart';
import 'package:health_app/services/api_service.dart';

import 'package:health_app/theme/colors.dart';
import 'package:health_app/theme/styles.dart' as styles;
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  // const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

enum FilterStatus { being_processed, accepted, refused }

/* List<Map> schedules = [
  {
    'img': 'assets/doctor01.jpeg',
    'doctorName': 'Dr. Anastasya Syahid',
    'doctorTitle': 'Dental Specialist',
    'reservedDate': 'Monday, Aug 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/doctor02.png',
    'doctorName': 'Dr. Mauldya Imran',
    'doctorTitle': 'Skin Specialist',
    'reservedDate': 'Monday, Sep 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/doctor03.jpeg',
    'doctorName': 'Dr. Rihanna Garland',
    'doctorTitle': 'General Specialist',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/doctor04.jpeg',
    'doctorName': 'Dr. John Doe',
    'doctorTitle': 'Something Specialist',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Complete
  },
  {
    'img': 'assets/doctor05.jpeg',
    'doctorName': 'Dr. Sam Smithh',
    'doctorTitle': 'Other Specialist',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Cancel
  },
  {
    'img': 'assets/doctor05.jpeg',
    'doctorName': 'Dr. Sam Smithh',
    'doctorTitle': 'Other Specialist',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Cancel
  },
]; */

class _SchedulePageState extends State<SchedulePage> {
  FilterStatus status = FilterStatus.being_processed;
  Alignment _alignment = Alignment.centerLeft;
  ApiService apiService = new ApiService();
  List<AppointmentModel>? AppointmentDataList;
  var _isVisible = false;
  List<AppointmentModel>? Appointments;
  List<AppointmentModel>? filteredSchedules;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      getPatientOfUser().then((PatientOfUserData) {
        setState(() {
          Appointments = (PatientOfUserData['rendezVous'] as List)
              .map((appointment) => AppointmentModel.fromJson(appointment))
              .toList();

          print("haaaa huma les appointments diawli");
          print(Appointments);

          //.split('.').last
          print("leeeeenght of filteredSchedules?.length");
          print(filteredSchedules?.length);
        });
      });
    });
    /* getPatientOfUser().then((PatientOfUserData) {
      Appointments = (PatientOfUserData['rendezVous'] as List)
          .map((appointment) => AppointmentModel.fromJson(appointment))
          .toList();

      print("haaaa huma les appointments diawli");
      print(Appointments);
    }); */
  }

  void iterateJson(String jsonStr) {
    Map<String, dynamic> myMap = json.decode(jsonStr);
    List<dynamic> entitlements = myMap["Dependents"][0]["Entitlements"];
    entitlements.forEach((entitlement) {
      (entitlement as Map<String, dynamic>).forEach((key, value) {
        print(key);
        (value as Map<String, dynamic>).forEach((key2, value2) {
          print(key2);
          print(value2);
        });
      });
    });
  }

  Future getPatientOfUser() async {
    //get Rdvs of this Patient
    var res = await apiService.getPatientOfUser();
    print("aaaaaaaaaaaaaa ${res.statusCode}");
    var PatientOfUserData = json.decode(res.body);
    print(PatientOfUserData);
    /* Appointments = (PatientOfUserData['rendezVous'] as List)
        .map((appointment) => AppointmentModel.fromJson(appointment))
        .toList(); */

    // print("haaaa huma les appointments diawli");
    // print(Appointments);

    return PatientOfUserData;
  }

  @override
  Widget build(BuildContext context) {
    filteredSchedules = Appointments!.where((var appointment) {
      print("appointment.status : ${appointment.status}");
      print("status.toString() : ${status.toString().split('.').last}");
      return appointment.status == status.toString().split('.').last;
    }).toList();
    /*  List<Map> filteredSchedules = schedules.where((var schedule) {
      return schedule['status'] == status;
    }).toList(); */

    /* List<Map> filteredSchedules = Appointments!.where((var schedule) {
      return schedule['status'] == status;
    }).toList(); */

    /*  List<AppointmentModel> filteredSchedules =
        Appointments!.where((var appointment) {
      return appointment.status == status.toString().split('.').last;
    }).toList(); */

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus ==
                                    FilterStatus.being_processed) {
                                  status = FilterStatus.being_processed;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.accepted) {
                                  status = FilterStatus.accepted;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.refused) {
                                  status = FilterStatus.refused;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name,
                                style: styles.kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules?.length,
                //itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  var schedule = filteredSchedules?[index];
                  bool isLastElement = ((filteredSchedules?.length != null)
                              ? filteredSchedules?.length
                              : 3)! +
                          1 ==
                      index;
                  return Container(

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      margin: !isLastElement
                          ? EdgeInsets.only(bottom: 20)
                          : EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  // backgroundImage: AssetImage(_schedule['img']),
                                  child: Image.memory(
                                      base64Decode(schedule!.medecin!.photo)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dr ${schedule.medecin!.nom}',
                                      // _schedule['doctorName'],
                                      style: TextStyle(
                                        color: Color(MyColors.header01),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      schedule.medecin!.type,
                                      // _schedule['doctorTitle'],
                                      style: TextStyle(
                                        color: Color(MyColors.grey02),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(MyColors.bg03),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Color(MyColors.primary),
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat.yMMMMEEEEd()
                                            .format(schedule.date!),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(MyColors.primary),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_alarm,
                                        color: Color(MyColors.primary),
                                        size: 17,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat.jm().format(schedule.date!),
                                        style: TextStyle(
                                          color: Color(MyColors.primary),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            //DateTimeCard(schedule: schedule),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    child: Text('Cancel'),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    child: Text('Reschedule'),
                                    onPressed: () => {},
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* class DateTimeCard extends StatelessWidget {
  const DateTimeCard({
    Key? key,
    required AppointmentModel schedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                DateFormat.yMd().add_jm().format() ,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '11:00 ~ 12:10',
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
} */
