// To parse this JSON data, do
//
//     final address = addressFromMap(jsonString);

import 'dart:convert';

class Address {
  Address({
    this.id,
    this.firstName,
    this.lastName,
    this.companyName,
    this.address1,
    this.country,
    this.countryName,
    this.state,
    this.city,
    this.postcode,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String firstName;
  final String lastName;
  final dynamic companyName;
  final String address1;
  final String country;
  final String countryName;
  final String state;
  final String city;
  final String postcode;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    companyName: json["company_name"],
    address1: json["address1"],
    country: json["country"],
    countryName: json["country_name"],
    state: json["state"],
    city: json["city"],
    postcode: json["postcode"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "company_name": companyName,
    "address1": address1,
    "country": country,
    "country_name": countryName,
    "state": state,
    "city": city,
    "postcode": postcode,
    "phone": phone,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
