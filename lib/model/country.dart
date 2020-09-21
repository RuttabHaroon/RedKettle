// To parse this JSON data, do
//
//     final country = countryFromMap(jsonString);

import 'dart:convert';

class Country {
  Country({
    this.id,
    this.code,
    this.name,
  });

  final int id;
  final String code;
  final String name;

  factory Country.fromJson(String str) => Country.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Country.fromMap(Map<String, dynamic> json) => Country(
    id: json["id"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "code": code,
    "name": name,
  };
}
