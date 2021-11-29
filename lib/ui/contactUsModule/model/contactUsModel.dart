// To parse this JSON data, do
//
//     final contactUsResponse = contactUsResponseFromJson(jsonString);

import 'dart:convert';

ContactUsResponse contactUsResponseFromJson(String str) => ContactUsResponse.fromJson(json.decode(str));

String contactUsResponseToJson(ContactUsResponse data) => json.encode(data.toJson());

class ContactUsResponse {
  ContactUsResponse({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) => ContactUsResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
