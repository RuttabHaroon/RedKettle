import 'dart:convert';

CreateAddress welcomeFromJson(String str) => CreateAddress.fromJson(json.decode(str));

String welcomeToJson(CreateAddress data) => json.encode(data.toJson());

class CreateAddress {
  CreateAddress({
    this.message,
    this.data,
  });

  String message;
  CreateAddressData data;

  factory CreateAddress.fromJson(Map<String, dynamic> json) => CreateAddress(
    message: json["message"],
    data: CreateAddressData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class CreateAddressData {
  CreateAddressData({
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

  int id;
  String firstName;
  String lastName;
  dynamic companyName;
  String address1;
  String country;
  String countryName;
  String state;
  String city;
  String postcode;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;

  factory CreateAddressData.fromJson(Map<String, dynamic> json) => CreateAddressData(
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

  Map<String, dynamic> toJson() => {
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
