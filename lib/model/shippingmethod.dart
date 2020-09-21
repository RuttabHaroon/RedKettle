// To parse this JSON data, do
//
//     final shippingMethod = shippingMethodFromMap(jsonString);

import 'dart:convert';

import 'Cart.dart';

class ShippingMethod {
  ShippingMethod({
    this.rates,
    this.cart,
  });

  final List<ShippingMethodRate> rates;
  final Cart cart;

  factory ShippingMethod.fromJson(String str) => ShippingMethod.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingMethod.fromMap(Map<String, dynamic> json) => ShippingMethod(
    rates: List<ShippingMethodRate>.from(json["rates"].map((x) => ShippingMethodRate.fromMap(x))),
    cart: Cart.fromMap(json["cart"]),
  );

  Map<String, dynamic> toMap() => {
    "rates": List<dynamic>.from(rates.map((x) => x.toMap())),
    "cart": cart.toMap(),
  };
}


class ShippingMethodRate {
  ShippingMethodRate({
    this.carrierTitle,
    this.rates,
  });

  final String carrierTitle;
  final List<RateRate> rates;

  factory ShippingMethodRate.fromJson(String str) => ShippingMethodRate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingMethodRate.fromMap(Map<String, dynamic> json) => ShippingMethodRate(
    carrierTitle: json["carrier_title"],
    rates: List<RateRate>.from(json["rates"].map((x) => RateRate.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "carrier_title": carrierTitle,
    "rates": List<dynamic>.from(rates.map((x) => x.toMap())),
  };
}

class RateRate {
  RateRate({
    this.id,
    this.carrier,
    this.carrierTitle,
    this.method,
    this.methodTitle,
    this.methodDescription,
    this.price,
    this.formatedPrice,
    this.basePrice,
    this.formatedBasePrice,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String carrier;
  final String carrierTitle;
  final String method;
  final String methodTitle;
  final String methodDescription;
  final int price;
  final String formatedPrice;
  final int basePrice;
  final String formatedBasePrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory RateRate.fromJson(String str) => RateRate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RateRate.fromMap(Map<String, dynamic> json) => RateRate(
    id: json["id"],
    carrier: json["carrier"],
    carrierTitle: json["carrier_title"],
    method: json["method"],
    methodTitle: json["method_title"],
    methodDescription: json["method_description"],
    price: json["price"],
    formatedPrice: json["formated_price"],
    basePrice: json["base_price"],
    formatedBasePrice: json["formated_base_price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "carrier": carrier,
    "carrier_title": carrierTitle,
    "method": method,
    "method_title": methodTitle,
    "method_description": methodDescription,
    "price": price,
    "formated_price": formatedPrice,
    "base_price": basePrice,
    "formated_base_price": formatedBasePrice,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
