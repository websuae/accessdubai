import 'dart:convert';

TrackApplicationModel trackApplicationModelFromJson(String str) => TrackApplicationModel.fromJson(json.decode(str));
String trackApplicationModelToJson(TrackApplicationModel data) => json.encode(data.toJson());

class TrackApplicationModel {
  TrackApplicationModel({
    this.message,
    this.applicationData,
    this.applicationUser,
  });

  String? message;
  ApplicationData? applicationData;
  List<ApplicationUser>? applicationUser;

  factory TrackApplicationModel.fromJson(Map<String, dynamic> json) => TrackApplicationModel(
    message: json["message"],
    applicationData: ApplicationData.fromJson(json["applicationData"]),
    applicationUser: List<ApplicationUser>.from(json["applicationUser"].map((x) => ApplicationUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "applicationData": applicationData!.toJson(),
    "applicationUser": List<dynamic>.from(applicationUser
    !.map((x) => x.toJson())),
  };
}

class ApplicationData {
  ApplicationData({
    this.applicationId,
    this.applicationDays,
    this.applicationPerson,
    this.applicationDate,
    this.applicationStatus,
    this.applicationNumber,
    this.pay_status,
  });

  String? applicationId;
  String? applicationDays;
  String? applicationPerson;
  DateTime? applicationDate;
  String? applicationStatus;
  String? applicationNumber;
  String? pay_status;

  factory ApplicationData.fromJson(Map<String, dynamic> json) => ApplicationData(
    applicationId: json["application_id"],
    applicationDays: json["application_days"],
    applicationPerson: json["application_person"],
    applicationDate: DateTime.parse(json["application_date"]),
    applicationStatus: json["application_status"],
    applicationNumber: json["application_number"],
    pay_status: json["pay_status"],
  );

  Map<String, dynamic> toJson() => {
    "application_id": applicationId,
    "application_days": applicationDays,
    "application_person": applicationPerson,
    "application_date": applicationDate!.toIso8601String(),
    "application_status": applicationStatus,
    "application_number": applicationNumber,
    "pay_status": pay_status,
  };
}

class ApplicationUser {
  ApplicationUser({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.status,
    required this.date,
    required this.aeVisa,
    required this.aeTicket,
  });

  String title;
  String firstName;
  String lastName;
  String country;
  String status;
  String date;
  String aeVisa;
  String aeTicket;

  factory ApplicationUser.fromJson(Map<String, dynamic> json) => ApplicationUser(
    title: json["title"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    country: json["country"],
    status: json["status"],
    date: json["date"],
    aeVisa: json["ae_visa"],
    aeTicket: json["ae_ticket"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "first_name": firstName,
    "last_name": lastName,
    "country": country,
    "status": status,
    "date":date,
    "ae_visa": aeVisa,
    "ae_ticket": aeTicket,
  };
}
