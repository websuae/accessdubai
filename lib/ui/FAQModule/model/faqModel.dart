// To parse this JSON data, do
//
//     final faqResponse = faqResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FaqResponse faqResponseFromJson(String str) => FaqResponse.fromJson(json.decode(str));

String faqResponseToJson(FaqResponse data) => json.encode(data.toJson());

class FaqResponse {
  FaqResponse({
    required this.status,
    required this.data,
  });

  bool status;
  List<Datum> data;

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    @required this.fid,
    @required this.fque,
    @required this.fans,
    @required this.faqDisplayOrder,
    @required this.factive,
    @required this.creationDate,
  });

  String? fid;
  String? fque;
  String? fans;
  String? faqDisplayOrder;
  String? factive;
  DateTime? creationDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    fid: json["fid"],
    fque: json["fque"],
    fans: json["fans"],
    faqDisplayOrder: json["faq_display_order"],
    factive: json["factive"],
    creationDate: DateTime.parse(json["creation_date"]),
  );

  Map<String, dynamic> toJson() => {
    "fid": fid,
    "fque": fque,
    "fans": fans,
    "faq_display_order": faqDisplayOrder,
    "factive": factive,
    "creation_date": creationDate!.toIso8601String(),
  };
}

