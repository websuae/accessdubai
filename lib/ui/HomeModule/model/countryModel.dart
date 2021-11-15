// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

CountryResponse countryResponseFromJson(String str) => CountryResponse.fromJson(json.decode(str));

String countryResponseToJson(CountryResponse data) => json.encode(data.toJson());

class CountryResponse {
  CountryResponse({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<Country>? data;
  String? message;

  factory CountryResponse.fromJson(Map<String, dynamic> json) => CountryResponse(
    status: json["status"],
    data: List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Country {
  Country({
    this.countryId,
    this.countryName,
    this.countryDocs,
    this.countryDisplayOrder,
    this.countryIsActive,
    this.countryCreateDate,
  });

  String? countryId;
  String? countryName;
  String? countryDocs;
  String? countryDisplayOrder;
  String? countryIsActive;
  DateTime? countryCreateDate;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    countryId: json["country_id"],
    countryName: json["country_name"],
    countryDocs: json["country_docs"],
    countryDisplayOrder: json["country_display_order"],
    countryIsActive: json["country_is_active"],
    countryCreateDate: DateTime.parse(json["country_create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId,
    "country_name": countryName,
    "country_docs": countryDocs,
    "country_display_order": countryDisplayOrder,
    "country_is_active": countryIsActive,
    "country_create_date": countryCreateDate!.toIso8601String(),
  };
}





