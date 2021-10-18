// To parse this JSON data, do
//
//     final loginResponceModel = loginResponceModelFromJson(jsonString);

import 'dart:convert';

LoginResponceModel loginResponceModelFromJson(String str) => LoginResponceModel.fromJson(json.decode(str));

String loginResponceModelToJson(LoginResponceModel data) => json.encode(data.toJson());

class LoginResponceModel {
  LoginResponceModel({
    this.status,
    this.userId,
    this.userName,
    this.userEmail,
    this.message,
  });

  String? status;
  String? userId;
  String? userName;
  String? userEmail;
  String? message;

  factory LoginResponceModel.fromJson(Map<String, dynamic> json) => LoginResponceModel(
    status: json["status"],
    userId: json["user_id"],
    userName: json["user_name"],
    userEmail: json["user_email"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user_id": userId,
    "user_name": userName,
    "user_email": userEmail,
    "message": message,
  };
}
