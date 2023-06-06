import 'dart:convert';

import 'package:intl/intl.dart';

class PatientModel {
  int? id;
  String? code;
  String? nom;
  String? prenom;
  //i have to format this date before send it
  DateTime? dateNaissance;
  String? adresse;
  String? genre;
  String? telephone;
  double? poids;
  double? taille;
  String? photo;
  String? photoContentType;

  PatientModel({
    required this.id,
    required this.code,
    required this.nom,
    required this.prenom,
    required this.dateNaissance,
    required this.adresse,
    required this.genre,
    required this.telephone,
    required this.poids,
    required this.taille,
    required this.photo,
    required this.photoContentType,

    // required  this.userId,
    // required  this.secretaireId,
  });

  PatientModel copyWith({
    int? id,
    String? code,
    String? nom,
    String? prenom,
    DateTime? dateNaissance,
    String? adresse,
    String? genre,
    String? telephone,
    double? poids,
    double? taille,
    String? photo,
    String? photoContentType,
  }) =>
      PatientModel(
        id: id ?? this.id,
        code: code ?? this.code,
        nom: nom ?? this.nom,
        prenom: prenom ?? this.prenom,
        dateNaissance: dateNaissance ?? this.dateNaissance,
        adresse: adresse ?? this.adresse,
        genre: genre ?? this.genre,
        telephone: telephone ?? this.telephone,
        poids: poids ?? this.poids,
        taille: taille ?? this.taille,
        photo: photo ?? this.photo,
        photoContentType: photoContentType ?? this.photoContentType,
      );

  factory PatientModel.fromRawJson(String str) =>
      PatientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: (json["id"] == null) ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        nom: json["nom"] == null ? null : json["nom"],
        prenom: json["prenom"] == null ? null : json["prenom"],
        dateNaissance: DateTime.tryParse(json["dateNaissance"]) == null? null: DateTime.tryParse(json["dateNaissance"]),
             
        adresse: json["adresse"] == null ? null : json["adresse"],
        genre: json["genre"] == null ? null : json["genre"],
        photoContentType:
            json["photoContentType"] == null ? null : json["photoContentType"],
        telephone: json["telephone"] == null ? null : json["telephone"],
        poids: json["poids"] == null ? null : json["poids"],
        taille: json["taille"] == null ? null : json["taille"],
        photo: json["photo"] == null ? null : json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "nom": nom == null ? null : nom,
        "prenom": prenom == null ? null : prenom,
        "dateNaissance": dateNaissance == null ? null : dateNaissance,
        "adresse": adresse == null ? null : adresse,
        "genre": genre == null ? null : genre,
        "telephone": telephone == null ? null : telephone,
        "poids": poids == null ? null : poids,
        "taille": taille == null ? null : taille,
        "photo": photo == null ? null : photo,
        "photoContentType": photoContentType == null ? null : photoContentType,
      };
}
