




// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';


ServiceModel serviceModelFromJson(String str) => ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  bool success;
  Data? data;
  dynamic error;

  ServiceModel({
    required this.success,
    required this.data,
    required this.error,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "error": error,
  };
}

class Data {
  User user;
  String message;

  Data({
    required this.user,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "message": message,
  };
}

class User {
  int userId;
  String name;
  int age;
  String profession;
  String profileImage;

  User({
    required this.userId,
    required this.name,
    required this.age,
    required this.profession,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    name: json["name"],
    age: json["age"],
    profession: json["profession"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "age": age,
    "profession": profession,
    "profile_image": profileImage,
  };
}
