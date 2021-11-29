// To parse this JSON data, do
//
//     final whyUsResponse = whyUsResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WhyUsResponse whyUsResponseFromJson(String str) => WhyUsResponse.fromJson(json.decode(str));

String whyUsResponseToJson(WhyUsResponse data) => json.encode(data.toJson());

class WhyUsResponse {
  WhyUsResponse({
     this.status,
     this.data,
  });

  bool? status;
  List<Datum>? data;

  factory WhyUsResponse.fromJson(Map<String, dynamic> json) => WhyUsResponse(
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
     this.cmsContentId,
     this.pageTitle,
     this.pageImg,
     this.pageContent,
     this.metaTitle,
     this.metaDesc,
     this.metaKeywords,
     this.pageActive,
     this.createDate,
  });

  String? cmsContentId;
  String? pageTitle;
  String? pageImg;
  String? pageContent;
  String? metaTitle;
  String? metaDesc;
  String? metaKeywords;
  String? pageActive;
  DateTime? createDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    cmsContentId: json["cms_content_id"],
    pageTitle: json["page_title"],
    pageImg: json["page_img"],
    pageContent: json["page_content"],
    metaTitle: json["meta_title"],
    metaDesc: json["meta_desc"],
    metaKeywords: json["meta_keywords"],
    pageActive: json["page_active"],
    createDate: DateTime.parse(json["create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "cms_content_id": cmsContentId,
    "page_title": pageTitle,
    "page_img": pageImg,
    "page_content": pageContent,
    "meta_title": metaTitle,
    "meta_desc": metaDesc,
    "meta_keywords": metaKeywords,
    "page_active": pageActive,
    "create_date": createDate!.toIso8601String(),
  };
}
