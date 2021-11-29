//Email Validation
import 'dart:convert';
import 'dart:io';
import 'package:visa_app/model/Nationality.dart';
import 'package:flutter/services.dart' as rootBundle;

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
List<dynamic> info = [];

// Password validation
bool validatePassword(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,}$';
  RegExp regex = new RegExp(pattern);

  return regex.hasMatch(value);
}

// Phone number validation
bool isPhoneNoValid(String? phoneNo) {
  if (phoneNo == null) return false;
  final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  return regExp.hasMatch(phoneNo);
}

Future<List<Nationality>> ReadJsonData() async {
  //read json file
  final jsondata =
  await rootBundle.rootBundle.loadString('json/country.json');
  //decode json data as list
  info = json.decode(jsondata) as List<dynamic>;

  //map json and initialize using DataModel
  return info.map((e) => Nationality.fromJson(e)).toList();
}

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}
