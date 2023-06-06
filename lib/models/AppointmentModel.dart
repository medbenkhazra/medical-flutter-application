import 'dart:convert';
import 'package:health_app/models/PatientModel.dart';
import 'package:health_app/models/doctor_model.dart';
import 'package:time_machine/time_machine.dart' as timeMachine;

class AppointmentModel {
  int? id;
  DateTime? date;
  String? code;
  String? status;
  PatientModel? patient;
  DoctorModel? medecin;

  AppointmentModel({
    required this.id,
    required this.date,
    required this.code,
    required this.status,
    required this.patient,
    required this.medecin,
  });

  AppointmentModel copyWith({
    int? id,
    DateTime? date,
    String? code,
    String? status,
    PatientModel? patient,
    DoctorModel? medecin,
  }) =>
      AppointmentModel(
        id: id ?? this.id,
        date: date ?? this.date,
        code: code ?? this.code,
        status: status ?? this.status,
        patient: patient ?? this.patient,
        medecin: medecin ?? this.medecin,
      );

  factory AppointmentModel.fromRawJson(String str) =>
      AppointmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppointmentModel.fromJson(Map<String, dynamic> jsonParam) {
    print("///////this is the date time utc");
    //print(timeMachine.ZonedDateTime(json.decode("2022-01-01T22:41:32Z")).toDateTimeUtc());
    print("datetime now");
    print(DateTime.now());
    //print("***this is our patient***");
   // print(jsonParam["patient"]);
    return AppointmentModel(
      id: (jsonParam["id"] == null) ? null : jsonParam["id"],
      //  date: ZonedDateTime(json["date"]).toOffsetDateTime() == null ? null : json["date"],
      date: DateTime.tryParse(jsonParam["date"]) == null
          ? null
          : DateTime.tryParse(jsonParam["date"]),
      // date: timeMachine.ZonedDateTime(timeMachine.Instant.now()),
      //date: timeMachine.ZonedDateTime(json.decode(jsonParam["date"])).toDateTimeUtc(),
      //date: timeMachine.ZonedDateTime(json.decode(jsonParam["date"])).toDateTimeUtc(),
      code: jsonParam["code"] == null ? null : jsonParam["code"],
      status: jsonParam["status"] == null ? null : jsonParam["status"],
      // patient: jsonParam["patient"] == null ? null : jsonParam["patient"],
      patient: PatientModel.fromJson(jsonParam["patient"]),
      medecin:  DoctorModel.fromJson(jsonParam["medecin"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date,
        "code": code == null ? null : code,
        "status": status == null ? null : status,
        "patient": patient == null ? null : patient,
        "medecin": medecin == null ? null : medecin,
      };
}
