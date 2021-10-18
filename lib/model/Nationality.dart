import 'dart:convert';

List<Nationality> nationalityFromJson(String str) => List<Nationality>.from(
    json.decode(str).map((x) => Nationality.fromJson(x)));

String nationalityToJson(List<Nationality> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Nationality {
  Nationality({
    this.id,
    this.sortname,
    this.name,
    this.phonecode,
  });

  String? id;
  String? sortname;
  String? name;
  String? phonecode;

  factory Nationality.fromJson(Map<String, dynamic> json) => Nationality(
        id: json["id"],
        sortname: json["sortname"],
        name: json["name"],
        phonecode: json["phonecode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sortname": sortname,
        "name": name,
        "phonecode": phonecode,
      };
}
