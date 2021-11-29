// To parse this JSON data, do
//
//     final getCountryVisaPrice = getCountryVisaPriceFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetCountryVisaPrice getCountryVisaPriceFromJson(String str) => GetCountryVisaPrice.fromJson(json.decode(str));

String getCountryVisaPriceToJson(GetCountryVisaPrice data) => json.encode(data.toJson());

class GetCountryVisaPrice {
  GetCountryVisaPrice({
    required this.status,
    required this.data,
    required this.message,
  });

  bool status;
  Data data;
  String message;

  factory GetCountryVisaPrice.fromJson(Map<String, dynamic> json) => GetCountryVisaPrice(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    @required this.visatypeId,
    @required this.visatypeName,
    @required this.visatypeSDesc,
    @required this.visatypeDesc,
    @required this.visatypeImg,
    @required this.visaHomeImg,
    @required this.visatypeDisplayOrder,
    @required this.visatypeIsActive,
    @required this.visatypeCreateDate,
    @required this.price,
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
  String? price;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
