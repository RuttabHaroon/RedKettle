import 'dart:convert';

class NetworkResponse {
  final bool success;
  final String message;
  final dynamic data;

  NetworkResponse({this.success, this.message, this.data});

  factory NetworkResponse.fromRawJson(String str) =>
      NetworkResponse.fromJson(json.decode(str));

  factory NetworkResponse.fromJson(Map<String, dynamic> json) =>
      NetworkResponse(success: json["success"], message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {"success":success, "message": message, "data": data};
}