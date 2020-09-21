// To parse this JSON data, do
//
//     final cart = cartFromMap(jsonString);

import 'dart:convert';

class Cart {
  Cart({
    this.id,
    this.customerEmail,
    this.customerFirstName,
    this.customerLastName,
    this.shippingMethod,
    this.couponCode,
    this.isGift,
    this.itemsCount,
    this.itemsQty,
    this.exchangeRate,
    this.globalCurrencyCode,
    this.baseCurrencyCode,
    this.channelCurrencyCode,
    this.cartCurrencyCode,
    this.grandTotal,
    this.formatedGrandTotal,
    this.baseGrandTotal,
    this.formatedBaseGrandTotal,
    this.subTotal,
    this.formatedSubTotal,
    this.baseSubTotal,
    this.formatedBaseSubTotal,
    this.taxTotal,
    this.formatedTaxTotal,
    this.baseTaxTotal,
    this.formatedBaseTaxTotal,
    this.discount,
    this.formatedDiscount,
    this.baseDiscount,
    this.formatedBaseDiscount,
    this.checkoutMethod,
    this.isGuest,
    this.isActive,
    this.conversionTime,
    this.customer,
    this.channel,
    this.items,
    this.selectedShippingRate,
    this.payment,
    this.billingAddress,
    this.shippingAddress,
    this.createdAt,
    this.updatedAt,
    this.taxes,
    this.formatedTaxes,
    this.baseTaxes,
    this.formatedBaseTaxes,
  });

  final int id;
  final String customerEmail;
  final String customerFirstName;
  final String customerLastName;
  final String shippingMethod;
  final dynamic couponCode;
  final int isGift;
  final int itemsCount;
  final String itemsQty;
  final dynamic exchangeRate;
  final String globalCurrencyCode;
  final String baseCurrencyCode;
  final String channelCurrencyCode;
  final String cartCurrencyCode;
  final String grandTotal;
  final String formatedGrandTotal;
  final String baseGrandTotal;
  final String formatedBaseGrandTotal;
  final String subTotal;
  final String formatedSubTotal;
  final String baseSubTotal;
  final String formatedBaseSubTotal;
  final String taxTotal;
  final String formatedTaxTotal;
  final String baseTaxTotal;
  final String formatedBaseTaxTotal;
  final String discount;
  final String formatedDiscount;
  final String baseDiscount;
  final String formatedBaseDiscount;
  final dynamic checkoutMethod;
  final int isGuest;
  final int isActive;
  final dynamic conversionTime;
  final dynamic customer;
  final dynamic channel;
  final List<Item> items;
  final SelectedShippingRate selectedShippingRate;
  final Payment payment;
  final IngAddress billingAddress;
  final IngAddress shippingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String taxes;
  final String formatedTaxes;
  final String baseTaxes;
  final String formatedBaseTaxes;

  factory Cart.fromJson(String str) => Cart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cart.fromMap(Map<String, dynamic> json) => Cart(
    id: json["id"],
    customerEmail: json["customer_email"],
    customerFirstName: json["customer_first_name"],
    customerLastName: json["customer_last_name"],
    shippingMethod: json["shipping_method"],
    couponCode: json["coupon_code"],
    isGift: json["is_gift"],
    itemsCount: json["items_count"],
    itemsQty: json["items_qty"],
    exchangeRate: json["exchange_rate"],
    globalCurrencyCode: json["global_currency_code"],
    baseCurrencyCode: json["base_currency_code"],
    channelCurrencyCode: json["channel_currency_code"],
    cartCurrencyCode: json["cart_currency_code"],
    grandTotal: json["grand_total"],
    formatedGrandTotal: json["formated_grand_total"],
    baseGrandTotal: json["base_grand_total"],
    formatedBaseGrandTotal: json["formated_base_grand_total"],
    subTotal: json["sub_total"],
    formatedSubTotal: json["formated_sub_total"],
    baseSubTotal: json["base_sub_total"],
    formatedBaseSubTotal: json["formated_base_sub_total"],
    taxTotal: json["tax_total"],
    formatedTaxTotal: json["formated_tax_total"],
    baseTaxTotal: json["base_tax_total"],
    formatedBaseTaxTotal: json["formated_base_tax_total"],
    discount: json["discount"],
    formatedDiscount: json["formated_discount"],
    baseDiscount: json["base_discount"],
    formatedBaseDiscount: json["formated_base_discount"],
    checkoutMethod: json["checkout_method"],
    isGuest: json["is_guest"],
    isActive: json["is_active"],
    conversionTime: json["conversion_time"],
    customer: json["customer"],
    channel: json["channel"],
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
    selectedShippingRate: json["selected_shipping_rate"] == null ? null : SelectedShippingRate.fromMap(json["selected_shipping_rate"]),
    payment: json["payment"] == null ? null : Payment.fromMap(json["payment"]),
    billingAddress: json["billing_address"] == null ? null : IngAddress.fromMap(json["billing_address"]),
    shippingAddress: json["shipping_address"] == null ? null : IngAddress.fromMap(json["shipping_address"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    taxes: json["taxes"],
    formatedTaxes: json["formated_taxes"],
    baseTaxes: json["base_taxes"],
    formatedBaseTaxes: json["formated_base_taxes"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customer_email": customerEmail,
    "customer_first_name": customerFirstName,
    "customer_last_name": customerLastName,
    "shipping_method": shippingMethod,
    "coupon_code": couponCode,
    "is_gift": isGift,
    "items_count": itemsCount,
    "items_qty": itemsQty,
    "exchange_rate": exchangeRate,
    "global_currency_code": globalCurrencyCode,
    "base_currency_code": baseCurrencyCode,
    "channel_currency_code": channelCurrencyCode,
    "cart_currency_code": cartCurrencyCode,
    "grand_total": grandTotal,
    "formated_grand_total": formatedGrandTotal,
    "base_grand_total": baseGrandTotal,
    "formated_base_grand_total": formatedBaseGrandTotal,
    "sub_total": subTotal,
    "formated_sub_total": formatedSubTotal,
    "base_sub_total": baseSubTotal,
    "formated_base_sub_total": formatedBaseSubTotal,
    "tax_total": taxTotal,
    "formated_tax_total": formatedTaxTotal,
    "base_tax_total": baseTaxTotal,
    "formated_base_tax_total": formatedBaseTaxTotal,
    "discount": discount,
    "formated_discount": formatedDiscount,
    "base_discount": baseDiscount,
    "formated_base_discount": formatedBaseDiscount,
    "checkout_method": checkoutMethod,
    "is_guest": isGuest,
    "is_active": isActive,
    "conversion_time": conversionTime,
    "customer": customer,
    "channel": channel,
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
    "selected_shipping_rate": selectedShippingRate.toMap(),
    "payment": payment.toMap(),
    "billing_address": billingAddress.toMap(),
    "shipping_address": shippingAddress.toMap(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "taxes": taxes,
    "formated_taxes": formatedTaxes,
    "base_taxes": baseTaxes,
    "formated_base_taxes": formatedBaseTaxes,
  };
}

class IngAddress {
  IngAddress({
    this.id,
    this.firstName,
    this.lastName,
    this.name,
    this.email,
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
  final String name;
  final dynamic email;
  final String address1;
  final String country;
  final String countryName;
  final String state;
  final String city;
  final String postcode;
  final dynamic phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory IngAddress.fromJson(String str) => IngAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IngAddress.fromMap(Map<String, dynamic> json) => IngAddress(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    name: json["name"],
    email: json["email"],
    address1: json["address1"] ?? '',
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
    "name": name,
    "email": email,
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

class Item {
  Item({
    this.id,
    this.quantity,
    this.sku,
    this.type,
    this.name,
    this.couponCode,
    this.weight,
    this.totalWeight,
    this.baseTotalWeight,
    this.price,
    this.formatedPrice,
    this.basePrice,
    this.formatedBasePrice,
    this.customPrice,
    this.formatedCustomPrice,
    this.total,
    this.formatedTotal,
    this.baseTotal,
    this.formatedBaseTotal,
    this.taxPercent,
    this.taxAmount,
    this.formatedTaxAmount,
    this.baseTaxAmount,
    this.formatedBaseTaxAmount,
    this.discountPercent,
    this.discountAmount,
    this.formatedDiscountAmount,
    this.baseDiscountAmount,
    this.formatedBaseDiscountAmount,
    this.additional,
    this.child,
    this.product,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int quantity;
  final String sku;
  final String type;
  final String name;
  final dynamic couponCode;
  final String weight;
  final String totalWeight;
  final String baseTotalWeight;
  final String price;
  final String formatedPrice;
  final String basePrice;
  final String formatedBasePrice;
  final dynamic customPrice;
  final String formatedCustomPrice;
  final String total;
  final String formatedTotal;
  final String baseTotal;
  final String formatedBaseTotal;
  final String taxPercent;
  final String taxAmount;
  final String formatedTaxAmount;
  final String baseTaxAmount;
  final String formatedBaseTaxAmount;
  final String discountPercent;
  final String discountAmount;
  final String formatedDiscountAmount;
  final String baseDiscountAmount;
  final String formatedBaseDiscountAmount;
  final Additional additional;
  final dynamic child;
  final Product product;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    id: json["id"],
    quantity: json["quantity"],
    sku: json["sku"],
    type: json["type"],
    name: json["name"],
    couponCode: json["coupon_code"],
    weight: json["weight"],
    totalWeight: json["total_weight"],
    baseTotalWeight: json["base_total_weight"],
    price: json["price"],
    formatedPrice: json["formated_price"],
    basePrice: json["base_price"],
    formatedBasePrice: json["formated_base_price"],
    customPrice: json["custom_price"],
    formatedCustomPrice: json["formated_custom_price"],
    total: json["total"],
    formatedTotal: json["formated_total"],
    baseTotal: json["base_total"],
    formatedBaseTotal: json["formated_base_total"],
    taxPercent: json["tax_percent"],
    taxAmount: json["tax_amount"],
    formatedTaxAmount: json["formated_tax_amount"],
    baseTaxAmount: json["base_tax_amount"],
    formatedBaseTaxAmount: json["formated_base_tax_amount"],
    discountPercent: json["discount_percent"],
    discountAmount: json["discount_amount"],
    formatedDiscountAmount: json["formated_discount_amount"],
    baseDiscountAmount: json["base_discount_amount"],
    formatedBaseDiscountAmount: json["formated_base_discount_amount"],
    additional: Additional.fromMap(json["additional"]),
    child: json["child"],
    product: Product.fromMap(json["product"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "quantity": quantity,
    "sku": sku,
    "type": type,
    "name": name,
    "coupon_code": couponCode,
    "weight": weight,
    "total_weight": totalWeight,
    "base_total_weight": baseTotalWeight,
    "price": price,
    "formated_price": formatedPrice,
    "base_price": basePrice,
    "formated_base_price": formatedBasePrice,
    "custom_price": customPrice,
    "formated_custom_price": formatedCustomPrice,
    "total": total,
    "formated_total": formatedTotal,
    "base_total": baseTotal,
    "formated_base_total": formatedBaseTotal,
    "tax_percent": taxPercent,
    "tax_amount": taxAmount,
    "formated_tax_amount": formatedTaxAmount,
    "base_tax_amount": baseTaxAmount,
    "formated_base_tax_amount": formatedBaseTaxAmount,
    "discount_percent": discountPercent,
    "discount_amount": discountAmount,
    "formated_discount_amount": formatedDiscountAmount,
    "base_discount_amount": baseDiscountAmount,
    "formated_base_discount_amount": formatedBaseDiscountAmount,
    "additional": additional.toMap(),
    "child": child,
    "product": product.toMap(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Additional {
  Additional({
    this.quantity,
    this.productId,
    this.isConfigurable,
  });

  final int quantity;
  final String productId;
  final String isConfigurable;

  factory Additional.fromJson(String str) => Additional.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Additional.fromMap(Map<String, dynamic> json) => Additional(
    quantity: json["quantity"],
    productId: json["product_id"],
    isConfigurable: json["is_configurable"],
  );

  Map<String, dynamic> toMap() => {
    "quantity": quantity,
    "product_id": productId,
    "is_configurable": isConfigurable,
  };
}

class Product {
  Product({
    this.id,
    this.type,
    this.name,
    this.urlKey,
    this.price,
    this.formatedPrice,
    this.shortDescription,
    this.description,
    this.sku,
    this.images,
    this.baseImage,
    this.variants,
    this.inStock,
    this.reviews,
    this.isSaved,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String type;
  final String name;
  final String urlKey;
  final String price;
  final String formatedPrice;
  final String shortDescription;
  final String description;
  final String sku;
  final List<Image> images;
  final BaseImage baseImage;
  final List<dynamic> variants;
  final bool inStock;
  final Reviews reviews;
  final bool isSaved;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    urlKey: json["url_key"],
    price: json["price"],
    formatedPrice: json["formated_price"],
    shortDescription: json["short_description"],
    description: json["description"],
    sku: json["sku"],
    images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
    baseImage: BaseImage.fromMap(json["base_image"]),
    variants: List<dynamic>.from(json["variants"].map((x) => x)),
    inStock: json["in_stock"],
    reviews: Reviews.fromMap(json["reviews"]),
    isSaved: json["is_saved"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "type": type,
    "name": name,
    "url_key": urlKey,
    "price": price,
    "formated_price": formatedPrice,
    "short_description": shortDescription,
    "description": description,
    "sku": sku,
    "images": List<dynamic>.from(images.map((x) => x.toMap())),
    "base_image": baseImage.toMap(),
    "variants": List<dynamic>.from(variants.map((x) => x)),
    "in_stock": inStock,
    "reviews": reviews.toMap(),
    "is_saved": isSaved,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class BaseImage {
  BaseImage({
    this.smallImageUrl,
    this.mediumImageUrl,
    this.largeImageUrl,
    this.originalImageUrl,
  });

  final String smallImageUrl;
  final String mediumImageUrl;
  final String largeImageUrl;
  final String originalImageUrl;

  factory BaseImage.fromJson(String str) => BaseImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BaseImage.fromMap(Map<String, dynamic> json) => BaseImage(
    smallImageUrl: json["small_image_url"],
    mediumImageUrl: json["medium_image_url"],
    largeImageUrl: json["large_image_url"],
    originalImageUrl: json["original_image_url"],
  );

  Map<String, dynamic> toMap() => {
    "small_image_url": smallImageUrl,
    "medium_image_url": mediumImageUrl,
    "large_image_url": largeImageUrl,
    "original_image_url": originalImageUrl,
  };
}

class Image {
  Image({
    this.id,
    this.path,
    this.url,
    this.originalImageUrl,
    this.smallImageUrl,
    this.mediumImageUrl,
    this.largeImageUrl,
  });

  final int id;
  final String path;
  final String url;
  final String originalImageUrl;
  final String smallImageUrl;
  final String mediumImageUrl;
  final String largeImageUrl;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    id: json["id"],
    path: json["path"],
    url: json["url"],
    originalImageUrl: json["original_image_url"],
    smallImageUrl: json["small_image_url"],
    mediumImageUrl: json["medium_image_url"],
    largeImageUrl: json["large_image_url"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "path": path,
    "url": url,
    "original_image_url": originalImageUrl,
    "small_image_url": smallImageUrl,
    "medium_image_url": mediumImageUrl,
    "large_image_url": largeImageUrl,
  };
}

class Reviews {
  Reviews({
    this.total,
    this.totalRating,
    this.averageRating,
    this.percentage,
  });

  final int total;
  final int totalRating;
  final int averageRating;
  final List<dynamic> percentage;

  factory Reviews.fromJson(String str) => Reviews.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Reviews.fromMap(Map<String, dynamic> json) => Reviews(
    total: json["total"],
    totalRating: json["total_rating"],
    averageRating: json["average_rating"],
    percentage: List<dynamic>.from(json["percentage"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "total": total,
    "total_rating": totalRating,
    "average_rating": averageRating,
    "percentage": List<dynamic>.from(percentage.map((x) => x)),
  };
}

class Payment {
  Payment({
    this.id,
    this.method,
    this.methodTitle,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String method;
  final String methodTitle;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Payment.fromJson(String str) => Payment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Payment.fromMap(Map<String, dynamic> json) => Payment(
    id: json["id"],
    method: json["method"],
    methodTitle: json["method_title"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "method": method,
    "method_title": methodTitle,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class SelectedShippingRate {
  SelectedShippingRate({
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

  factory SelectedShippingRate.fromJson(String str) => SelectedShippingRate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SelectedShippingRate.fromMap(Map<String, dynamic> json) => SelectedShippingRate(
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
