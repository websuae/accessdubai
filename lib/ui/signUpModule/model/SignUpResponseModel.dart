import 'dart:convert';

SignUpResponceModel signUpResponceModelFromJson(String str) => SignUpResponceModel.fromJson(json.decode(str));

String signUpResponceModelToJson(SignUpResponceModel data) => json.encode(data.toJson());

class SignUpResponceModel {
  SignUpResponceModel({
    this.status,
    this.registrationId,
    this.registrationEmail,
    this.message,
  });

  String? status;
  String? registrationId;
  String? registrationEmail;
  String? message;

  factory SignUpResponceModel.fromJson(Map<String, dynamic> json) => SignUpResponceModel(
    status: json["status"],
    registrationId: json["registration_id"],
    registrationEmail: json["registration_email"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "registration_id": registrationId,
    "registration_email": registrationEmail,
    "message": message,
  };
}
