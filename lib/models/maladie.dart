import 'dart:convert';

class MaladieModel {
  int? id;
  String? code;
  String? nom;

  MaladieModel({
     this.id,
     this.code,
     this.nom,
  });

  MaladieModel copyWith({
    int? id,
    String? code,
    String? nom,
  }) =>
      MaladieModel(
        id: id ?? this.id,
        code: code ?? this.code,
        nom: nom ?? this.nom,
      );

  factory MaladieModel.fromRawJson(String str) =>
      MaladieModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MaladieModel.fromJson(Map<String, dynamic> json) => MaladieModel(
        id: (json["id"] == null) ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        nom: json["nom"] == null ? null : json["nom"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "nom": nom == null ? null : nom,
      };
}
