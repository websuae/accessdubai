// To parse this JSON data, do
//
//     final applyVisaFirstStepModel = applyVisaFirstStepModelFromJson(jsonString);

import 'dart:convert';

ApplyVisaFirstStepModel applyVisaFirstStepModelFromJson(String str) => ApplyVisaFirstStepModel.fromJson(json.decode(str));

String applyVisaFirstStepModelToJson(ApplyVisaFirstStepModel data) => json.encode(data.toJson());

class ApplyVisaFirstStepModel {
  ApplyVisaFirstStepModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<Datum>? data;
  String? message;

  factory ApplyVisaFirstStepModel.fromJson(Map<String, dynamic> json) => ApplyVisaFirstStepModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
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
    this.price,
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
  dynamic price;
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
    price: json["price"],
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
    "price": price,
  };
}
