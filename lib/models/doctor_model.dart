import 'dart:convert';

class DoctorModel {
      int id;
      String code;
      String numEmp;
      String nom;
      String prenom;
    //  bool admin;
      int expertLevel;
      String photo;
      String photoContentType;
      String type;
      int nbrPatients;
      //double rating;
      int rating;
      String description;
    //  int userId;
    //  int secretaireId;

    DoctorModel({
      required this.id,
      required  this.code,
      required  this.numEmp,
      
      required  this.nom,
      required  this.prenom,
      //required  this.admin,
      required  this.expertLevel,
      required  this.photo,
      required  this.photoContentType,
      required  this.type,
      required  this.nbrPatients,
      required  this.rating,
      required  this.description,
     // required  this.userId,
     // required  this.secretaireId,
    });

    DoctorModel copyWith({
      int? id,
      String? code,
      String? numEmp,
      String? nom,
      String? prenom,
      //bool? admin,
      int? expertLevel,
      String? photo,
      String? photoContentType,
      String? type,
      int? nbrPatients,
     // double? rating,
      int? rating,
      String? description,
      int? userId,
      int? secretaireId,

       // String? name,
     //   String? type,
      //  String? description,
       // double? rating,
      //  double? goodReviews,
      //  double? totalScore,
      //  double? satisfaction,
      //  bool? isfavourite,
     //   String? image,
    }
    ) => 
        DoctorModel(
          id: id ?? this.id,
          code: code ?? this.code,
          numEmp: numEmp ?? this.numEmp,
          nom: nom ?? this.nom,
          prenom: prenom ?? this.prenom,
         // admin: admin ?? this.admin,
          expertLevel: expertLevel ?? this.expertLevel,
          photo: photo ?? this.photo,
          photoContentType: photoContentType ?? this.photoContentType,
          type: type ?? this.type,
          nbrPatients: nbrPatients ?? this.nbrPatients,
          rating: rating ?? this.rating,
          description: description ?? this.description,
        //  userId: userId ?? this.userId,
        //  secretaireId: secretaireId ?? this.secretaireId
      
           /*  name: name ?? this.name,
            type: type ?? this.type,
            description: description ?? this.description,
            rating: rating ?? this.rating,
            goodReviews: goodReviews ?? this.goodReviews,
            totalScore: totalScore ?? this.totalScore,
            satisfaction: satisfaction ?? this.satisfaction,
            isfavourite: isfavourite ?? this.isfavourite,
            image: image ?? this.image, */
        );

    factory DoctorModel.fromRawJson(String str) => DoctorModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());


      

    factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
      id: (json["id"] == null) ? null : json["id"],
      code: json["code"] == null ? null : json["code"],
      numEmp: json["numEmp"] == null ? null : json["numEmp"],
      nom: json["nom"] == null ? null : json["nom"],
      prenom: json["prenom"] == null ? null : json["prenom"],
     // admin: json["admin"] == null ? null : json["admin"],
      expertLevel: json["expertLevel"] == null ? null : json["expertLevel"],
      photo: json["photo"] == null ? null : json["photo"],
      photoContentType: json["photoContentType"] == null ? null : json["photoContentType"],
      type: json["type"] == null ? null : json["type"],
      nbrPatients: json["nbrPatients"] == null ? null : json["nbrPatients"],
      rating: json["rating"] == null ? null : json["rating"],
      description: json["description"] == null ? null : json["description"],
     // userId: json["userId"] == null ? null : json["userId"],
    //  secretaireId: json["secretaireId"] == null ? null : json["secretaireId"]
       /*  name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        description: json["description"] == null ? null : json["description"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        goodReviews: json["goodReviews"] == null ? null : json["goodReviews"].toDouble(),
        totalScore: json["totalScore"] == null ? null : json["totalScore"].toDouble(),
        satisfaction: json["satisfaction"] == null ? null : json["satisfaction"].toDouble(),
        isfavourite: json["isfavourite"] == null ? null : json["isfavourite"],
        image: json["image"] == null ? null : json["image"], */
    );



    Map<String, dynamic> toJson() => {
          "id": id == null ? null : id,
          "code": code == null ? null : code,
          "numEmp": numEmp == null ? null : numEmp,
          "nom": nom == null ? null : nom,
          "prenom": prenom == null ? null : prenom,
         // "admin": admin == null ? null : admin,
          "expertLevel": expertLevel == null ? null : expertLevel,
          "photo": photo == null ? null : photo,
          "photoContentType": photoContentType == null ? null : photoContentType,
          "type": type == null ? null : type,
          "nbrPatients": nbrPatients == null ? null : nbrPatients,
          "rating": rating == null ? null : rating,
          "description": description == null ? null : description,
        //  "userId": userId == null ? null : userId,
        //  "secretaireId": secretaireId == null ? null : secretaireId,
         


       /*  "name": name == null ? null : name,
        "type": type == null ? null : type,
        "description": description == null ? null : description,
        "rating": rating == null ? null : rating,
        "goodReviews": goodReviews == null ? null : goodReviews,
        "totalScore": totalScore == null ? null : totalScore,
        "satisfaction": satisfaction == null ? null : satisfaction,
        "isfavourite": isfavourite == null ? null : isfavourite,
        "image": image == null ? null : image, */
    };
}



