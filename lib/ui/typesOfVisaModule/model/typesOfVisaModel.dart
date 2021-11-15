// To parse this JSON data, do
//
//     final typesOfVisa = typesOfVisaFromJson(jsonString);

import 'dart:convert';

TypesOfVisa typesOfVisaFromJson(String str) => TypesOfVisa.fromJson(json.decode(str));

String typesOfVisaToJson(TypesOfVisa data) => json.encode(data.toJson());

class TypesOfVisa {
  TypesOfVisa({
    this.status,
    this.data,
    this.imagePath,
    this.message,
  });

  bool? status;
  List<Datum>? data;
  String? imagePath;
  String? message;

  factory TypesOfVisa.fromJson(Map<String, dynamic> json) => TypesOfVisa(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    imagePath: json["imagePath"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "imagePath": imagePath,
    "message": message,
  };
}

class Datum {
  Datum({
    this.visatypeId,
    this.visatypeName,
    this.visatypeSDesc,
    this.visatypeDesc,
    this.visatypeImg,
    this.visaHomeImg,
    this.visatypeDisplayOrder,
    this.visatypeIsActive,
    this.visatypeCreateDate,
    this.descTextShowFlag=false
  });

  String? visatypeId;
  String? visatypeName;
  String? visatypeSDesc;
  String? visatypeDesc;
  String? visatypeImg;
  String? visaHomeImg;
  String? visatypeDisplayOrder;
  String? visatypeIsActive;
  DateTime? visatypeCreateDate;
  bool? descTextShowFlag ;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    visatypeId: json["visatype_id"],
    visatypeName: json["visatype_name"],
    visatypeSDesc: json["visatype_s_desc"],
    visatypeDesc: json["visatype_desc"],
    visatypeImg: json["visatype_img"],
    visaHomeImg: json["visa_home_img"],
    visatypeDisplayOrder: json["visatype_display_order"],
    visatypeIsActive: json["visatype_is_active"],
    visatypeCreateDate: DateTime.parse(json["visatype_create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "visatype_id": visatypeId,
    "visatype_name": visatypeName,
    "visatype_s_desc": visatypeSDesc,
    "visatype_desc": visatypeDesc,
    "visatype_img": visatypeImg,
    "visa_home_img": visaHomeImg,
    "visatype_display_order": visatypeDisplayOrder,
    "visatype_is_active": visatypeIsActive,
    "visatype_create_date": visatypeCreateDate!.toIso8601String(),
  };
}
