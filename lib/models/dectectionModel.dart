import 'dart:convert';

import 'package:health_app/models/PatientModel.dart';
import 'package:health_app/models/maladie.dart';

class DetectionModel {
  int? id;
  String? photo;
  String? photoContentType;
  String? code;
  int? validation;
  String? stade;
  DateTime? date;
  String? description;
  MaladieModel? maladie;
  PatientModel? patient;

  DetectionModel({
     this.id,
     this.photo,
     this.photoContentType,
     this.code,
     this.validation,
     this.stade,
     this.date,
     this.description,
     this.maladie,
     this.patient,
  });

  DetectionModel copyWith({
    int? id,
    String? photo,
    String? photoContentType,
    String? code,
    int? validation,
    String? stade,
    DateTime? date,
    String? description,
    MaladieModel? maladie,
    PatientModel? patient,
  }) =>
      DetectionModel(
        id: id ?? this.id,
        photo: photo ?? this.photo,
        photoContentType: photoContentType ?? this.photoContentType,
        code: code ?? this.code,
        validation: validation ?? this.validation,
        stade: stade ?? this.stade,
        date: date ?? this.date,
        description: description ?? this.description,
        maladie: maladie ?? this.maladie,
        patient: patient ?? this.patient,
      );

  factory DetectionModel.fromRawJson(String str) =>
      DetectionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetectionModel.fromJson(Map<String, dynamic> json) => DetectionModel(
        id: (json["id"] == null) ? null : json["id"],
        photo: json["photo"] == null ? null : json["photo"],
        photoContentType:
            json["photoContentType"] == null ? null : json["photoContentType"],
        code: json["code"] == null ? null : json["code"],
        validation: json["validation"] == null ? null : json["validation"],
        stade: json["stade"] == null ? null : json["stade"],
        date: json["date"] == null ? null : json["date"],
        description: json["description"] == null ? null : json["description"],
        maladie: json["maladie"] == null ? null : json["maladie"],
        patient: json["patient"] == null ? null : json["patient"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "photo": photo == null ? null : photo,
        "photoContentType": photoContentType == null ? null : photoContentType,
        "code": code == null ? null : code,
        "validation": validation == null ? null : validation,
        "stade": stade == null ? null : stade,
        "date": date == null ? null : date,
        "description": description == null ? null : description,
        "maladie": maladie == null ? null : maladie,
        "patient": patient == null ? null : patient,
      };
}
