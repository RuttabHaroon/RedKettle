// To parse this JSON data, do
//
//     final productData = productDataFromMap(jsonString);

import 'dart:convert';

class ProductData {
  ProductData({
    this.products,
    this.meta,
  });

  final List<Product> products;
  final Meta meta;

  factory ProductData.fromJson(String str) => ProductData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductData.fromMap(Map<String, dynamic> json) => ProductData(
    products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    meta: Meta.fromMap(json["_meta"]),
  );

  Map<String, dynamic> toMap() => {
    "products": List<dynamic>.from(products.map((x) => x.toMap())),
    "_meta": meta.toMap(),
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  final int currentPage;
  final String perPage;
  final int totalPages;

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    perPage: json["per_page"],
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "per_page": perPage,
    "total_pages": totalPages,
  };
}

class Product {
  Product({
    this.id,
    this.sku,
    this.name,
    this.description,
    this.urlKey,
    this.productNew,
    this.featured,
    this.status,
    this.thumbnail,
    this.price,
    this.cost,
    this.specialPrice,
    this.specialPriceFrom,
    this.specialPriceTo,
    this.weight,
    this.color,
    this.colorLabel,
    this.size,
    this.sizeLabel,
    this.createdAt,
    this.locale,
    this.channel,
    this.productId,
    this.updatedAt,
    this.parentId,
    this.visibleIndividually,
    this.minPrice,
    this.maxPrice,
    this.shortDescription,
    this.metaTitle,
    this.metaKeywords,
    this.metaDescription,
    this.width,
    this.height,
    this.depth,
  });

  final int id;
  final String sku;
  final String name;
  final String description;
  final String urlKey;
  final int productNew;
  final int featured;
  final int status;
  final dynamic thumbnail;
  final String price;
  final String cost;
  final String specialPrice;
  final dynamic specialPriceFrom;
  final dynamic specialPriceTo;
  final String weight;
  final int color;
  final String colorLabel;
  final int size;
  final String sizeLabel;
  final DateTime createdAt;
  final String locale;
  final String channel;
  final int productId;
  final DateTime updatedAt;
  final dynamic parentId;
  final int visibleIndividually;
  final String minPrice;
  final String maxPrice;
  final String shortDescription;
  final String metaTitle;
  final String metaKeywords;
  final String metaDescription;
  final String width;
  final String height;
  final String depth;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    sku: json["sku"],
    name: json["name"],
    description: json["description"],
    urlKey: json["url_key"],
    productNew: json["new"],
    featured: json["featured"],
    status: json["status"],
    thumbnail: json["thumbnail"],
    price: json["price"],
    cost: json["cost"],
    specialPrice: json["special_price"] == null ? null : json["special_price"],
    specialPriceFrom: json["special_price_from"],
    specialPriceTo: json["special_price_to"],
    weight: json["weight"],
    color: json["color"],
    colorLabel: json["color_label"],
    size: json["size"],
    sizeLabel: json["size_label"],
    createdAt: DateTime.parse(json["created_at"]),
    locale: json["locale"],
    channel: json["channel"],
    productId: json["product_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    parentId: json["parent_id"],
    visibleIndividually: json["visible_individually"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    shortDescription: json["short_description"],
    metaTitle: json["meta_title"],
    metaKeywords: json["meta_keywords"],
    metaDescription: json["meta_description"],
    width: json["width"],
    height: json["height"],
    depth: json["depth"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "sku": sku,
    "name": name,
    "description": description,
    "url_key": urlKey,
    "new": productNew,
    "featured": featured,
    "status": status,
    "thumbnail": thumbnail,
    "price": price,
    "cost": cost,
    "special_price": specialPrice == null ? null : specialPrice,
    "special_price_from": specialPriceFrom,
    "special_price_to": specialPriceTo,
    "weight": weight,
    "color": color,
    "color_label": colorLabel,
    "size": size,
    "size_label": sizeLabel,
    "created_at": createdAt.toIso8601String(),
    "locale": locale,
    "channel": channel,
    "product_id": productId,
    "updated_at": updatedAt.toIso8601String(),
    "parent_id": parentId,
    "visible_individually": visibleIndividually,
    "min_price": minPrice,
    "max_price": maxPrice,
    "short_description": shortDescription,
    "meta_title": metaTitle,
    "meta_keywords": metaKeywords,
    "meta_description": metaDescription,
    "width": width,
    "height": height,
    "depth": depth,
  };
}
