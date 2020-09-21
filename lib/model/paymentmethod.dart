import 'dart:convert';
import 'cart.dart';


class PaymentMethod {
  PaymentMethod({
    this.methods,
    this.cart,
  });

  final List<Method> methods;
  final Cart cart;

  factory PaymentMethod.fromJson(String str) => PaymentMethod.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromMap(Map<String, dynamic> json) => PaymentMethod(
    methods: List<Method>.from(json["methods"].map((x) => Method.fromMap(x))),
    cart: Cart.fromMap(json["cart"]),
  );

  Map<String, dynamic> toMap() => {
    "methods": List<dynamic>.from(methods.map((x) => x.toMap())),
    "cart": cart.toMap(),
  };
}


class Method {
  Method({
    this.method,
    this.methodTitle,
    this.description,
    this.sort,
  });

  final String method;
  final String methodTitle;
  final String description;
  final String sort;

  factory Method.fromJson(String str) => Method.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Method.fromMap(Map<String, dynamic> json) => Method(
    method: json["method"],
    methodTitle: json["method_title"],
    description: json["description"],
    sort: json["sort"],
  );

  Map<String, dynamic> toMap() => {
    "method": method,
    "method_title": methodTitle,
    "description": description,
    "sort": sort,
  };
}
