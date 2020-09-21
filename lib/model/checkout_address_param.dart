// To parse this JSON data, do
//
//     final checkoutAddress = checkoutAddressFromMap(jsonString);

import 'dart:convert';

class CheckoutAddressParam {
  CheckoutAddressParam({
    this.billing,
    this.shipping,
  });

  final Billing billing;
  final Shipping shipping;

  factory CheckoutAddressParam.fromJson(String str) => CheckoutAddressParam.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckoutAddressParam.fromMap(Map<String, dynamic> json) => CheckoutAddressParam(
    billing: Billing.fromMap(json["billing"]),
    shipping: Shipping.fromMap(json["shipping"]),
  );

  Map<String, dynamic> toMap() => {
    "billing": billing.toMap(),
    "shipping": shipping.toMap(),
  };
}

class Billing {
  Billing({
    this.useForShipping,
    this.addressId,
  });

  final bool useForShipping;
  final int addressId;

  factory Billing.fromJson(String str) => Billing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Billing.fromMap(Map<String, dynamic> json) => Billing(
    useForShipping: json["use_for_shipping"],
    addressId: json["address_id"],
  );

  Map<String, dynamic> toMap() => {
    "use_for_shipping": useForShipping,
    "address_id": addressId,
  };
}

class Shipping {
  Shipping({
    this.addressId,
  });

  final int addressId;

  factory Shipping.fromJson(String str) => Shipping.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Shipping.fromMap(Map<String, dynamic> json) => Shipping(
    addressId: json["address_id"],
  );

  Map<String, dynamic> toMap() => {
    "address_id": addressId,
  };
}
