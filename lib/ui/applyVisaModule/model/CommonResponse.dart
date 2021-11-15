// To parse this JSON data, do
//
//     final commonResponce = commonResponceFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CommonResponce commonResponceFromJson(String str) => CommonResponce.fromJson(json.decode(str));

String commonResponceToJson(CommonResponce data) => json.encode(data.toJson());

class CommonResponce {
  CommonResponce({
     required this.applicationId,
     this.message,
    this.applicatioNumber,
   this.status,
  });

  int applicationId;
  String? message;
  String? applicatioNumber;
  bool? status;

  factory CommonResponce.fromJson(Map<String, dynamic> json) => CommonResponce(
    applicationId: json["applicationId"],
    message: json["message"],
    applicatioNumber: json["applicatioNumber"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "applicationId": applicationId,
    "message": message,
    "applicatioNumber": applicatioNumber,
    "status": status,
  };
}
