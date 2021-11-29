// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) => PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) => json.encode(data.toJson());

class PrivacyPolicyModel {
  PrivacyPolicyModel({
    this.status,
    this.data,
  });

  bool? status;
  List<Datum>? data;

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) => PrivacyPolicyModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.privacyId,
    this.privacyName,
    this.privacyDesc,
    this.privacyDisplayOrder,
    this.privacyIsActive,
    this.privacyCreateDate,
  });

  String? privacyId;
  String? privacyName;
  String? privacyDesc;
  String? privacyDisplayOrder;
  String? privacyIsActive;
  DateTime? privacyCreateDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    privacyId: json["privacy_id"],
    privacyName: json["privacy_name"],
    privacyDesc: json["privacy_desc"],
    privacyDisplayOrder: json["privacy_display_order"],
    privacyIsActive: json["privacy_is_active"],
    privacyCreateDate: DateTime.parse(json["privacy_create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "privacy_id": privacyId,
    "privacy_name": privacyName,
    "privacy_desc": privacyDesc,
    "privacy_display_order": privacyDisplayOrder,
    "privacy_is_active": privacyIsActive,
    "privacy_create_date": privacyCreateDate!.toIso8601String(),
  };
}
