// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.message,
    this.users,
  });

  String? message;
  List<UserDetailsModel>? users;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        message: json["message"],
        users: List<UserDetailsModel>.from(json["users"].map((x) => UserDetailsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class UserDetailsModel {
  UserDetailsModel({
    this.id,
    this.username,
    this.owner,
    this.rent,
    this.size,
    this.address,
    this.city,
    this.apartment,
    this.phone,
    this.likes,
    this.picture,
    this.description,
    this.available,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? username;
  String? owner;
  String? rent;
  String? size;
  String? address;
  String? city;
  String? apartment;
  String? phone;
  List<String>? likes;
  String? picture;
  String? description;
  bool? available;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        id: json["_id"],
        username: json["username"],
        owner: json["owner"],
        rent: json["rent"],
        size: json["size"],
        address: json["address"],
        city: json["city"],
        apartment: json["apartment"],
        phone: json["phone"],
        likes: List<String>.from(json["likes"].map((x) => x)),
        picture: json["picture"],
        description: json["description"],
        available: json["available"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "owner": owner,
        "rent": rent,
        "size": size,
        "address": address,
        "city": city,
        "apartment": apartment,
        "phone": phone,
        "likes": List<dynamic>.from(likes!.map((x) => x)),
        "picture": picture,
        "description": description,
        "available": available,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
