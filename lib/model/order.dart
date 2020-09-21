// To parse this JSON data, do
//
//     final order = orderFromMap(jsonString);

import 'dart:convert';

class Order {
  Order({
    this.id,
    this.status,
    this.statusLabel,
    this.channelName,
    this.isGuest,
    this.customerEmail,
    this.customerFirstName,
    this.customerLastName,
    this.shippingMethod,
    this.shippingTitle,
    this.paymentTitle,
    this.shippingDescription,
    this.couponCode,
    this.isGift,
    this.totalItemCount,
    this.totalQtyOrdered,
    this.baseCurrencyCode,
    this.channelCurrencyCode,
    this.orderCurrencyCode,
    this.grandTotal,
    this.formatedGrandTotal,
    this.baseGrandTotal,
    this.formatedBaseGrandTotal,
    this.grandTotalInvoiced,
    this.formatedGrandTotalInvoiced,
    this.baseGrandTotalInvoiced,
    this.formatedBaseGrandTotalInvoiced,
    this.grandTotalRefunded,
    this.formatedGrandTotalRefunded,
    this.baseGrandTotalRefunded,
    this.formatedBaseGrandTotalRefunded,
    this.subTotal,
    this.formatedSubTotal,
    this.baseSubTotal,
    this.formatedBaseSubTotal,
    this.subTotalInvoiced,
    this.formatedSubTotalInvoiced,
    this.baseSubTotalInvoiced,
    this.formatedBaseSubTotalInvoiced,
    this.subTotalRefunded,
    this.formatedSubTotalRefunded,
    this.discountPercent,
    this.discountAmount,
    this.formatedDiscountAmount,
    this.baseDiscountAmount,
    this.formatedBaseDiscountAmount,
    this.discountInvoiced,
    this.formatedDiscountInvoiced,
    this.baseDiscountInvoiced,
    this.formatedBaseDiscountInvoiced,
    this.discountRefunded,
    this.formatedDiscountRefunded,
    this.baseDiscountRefunded,
    this.formatedBaseDiscountRefunded,
    this.taxAmount,
    this.formatedTaxAmount,
    this.baseTaxAmount,
    this.formatedBaseTaxAmount,
    this.taxAmountInvoiced,
    this.formatedTaxAmountInvoiced,
    this.baseTaxAmountInvoiced,
    this.formatedBaseTaxAmountInvoiced,
    this.taxAmountRefunded,
    this.formatedTaxAmountRefunded,
    this.baseTaxAmountRefunded,
    this.formatedBaseTaxAmountRefunded,
    this.shippingAmount,
    this.formatedShippingAmount,
    this.baseShippingAmount,
    this.formatedBaseShippingAmount,
    this.shippingInvoiced,
    this.formatedShippingInvoiced,
    this.baseShippingInvoiced,
    this.formatedBaseShippingInvoiced,
    this.shippingRefunded,
    this.formatedShippingRefunded,
    this.baseShippingRefunded,
    this.formatedBaseShippingRefunded,
    this.customer,
    this.channel,
    this.shippingAddress,
    this.billingAddress,
    this.updatedAt,
    this.items,
    this.invoices,
    this.shipments,
    this.createdAt,
  });

  final int id;
  final String status;
  final String statusLabel;
  final String channelName;
  final int isGuest;
  final String customerEmail;
  final String customerFirstName;
  final String customerLastName;
  final String shippingMethod;
  final String shippingTitle;
  final String paymentTitle;
  final String shippingDescription;
  final dynamic couponCode;
  final dynamic isGift;
  final int totalItemCount;
  final dynamic totalQtyOrdered;
  final String baseCurrencyCode;
  final String channelCurrencyCode;
  final String orderCurrencyCode;
  final String grandTotal;
  final String formatedGrandTotal;
  final String baseGrandTotal;
  final String formatedBaseGrandTotal;
  final dynamic grandTotalInvoiced;
  final String formatedGrandTotalInvoiced;
  final dynamic baseGrandTotalInvoiced;
  final String formatedBaseGrandTotalInvoiced;
  final dynamic grandTotalRefunded;
  final String formatedGrandTotalRefunded;
  final dynamic baseGrandTotalRefunded;
  final String formatedBaseGrandTotalRefunded;
  final String subTotal;
  final String formatedSubTotal;
  final String baseSubTotal;
  final String formatedBaseSubTotal;
  final dynamic subTotalInvoiced;
  final String formatedSubTotalInvoiced;
  final dynamic baseSubTotalInvoiced;
  final String formatedBaseSubTotalInvoiced;
  final dynamic subTotalRefunded;
  final String formatedSubTotalRefunded;
  final dynamic discountPercent;
  final String discountAmount;
  final String formatedDiscountAmount;
  final String baseDiscountAmount;
  final String formatedBaseDiscountAmount;
  final dynamic discountInvoiced;
  final String formatedDiscountInvoiced;
  final dynamic baseDiscountInvoiced;
  final String formatedBaseDiscountInvoiced;
  final dynamic discountRefunded;
  final String formatedDiscountRefunded;
  final dynamic baseDiscountRefunded;
  final String formatedBaseDiscountRefunded;
  final String taxAmount;
  final String formatedTaxAmount;
  final String baseTaxAmount;
  final String formatedBaseTaxAmount;
  final dynamic taxAmountInvoiced;
  final String formatedTaxAmountInvoiced;
  final dynamic baseTaxAmountInvoiced;
  final String formatedBaseTaxAmountInvoiced;
  final dynamic taxAmountRefunded;
  final String formatedTaxAmountRefunded;
  final dynamic baseTaxAmountRefunded;
  final String formatedBaseTaxAmountRefunded;
  final dynamic shippingAmount;
  final String formatedShippingAmount;
  final dynamic baseShippingAmount;
  final String formatedBaseShippingAmount;
  final dynamic shippingInvoiced;
  final String formatedShippingInvoiced;
  final dynamic baseShippingInvoiced;
  final String formatedBaseShippingInvoiced;
  final dynamic shippingRefunded;
  final String formatedShippingRefunded;
  final dynamic baseShippingRefunded;
  final String formatedBaseShippingRefunded;
  final Customer customer;
  final Channel channel;
  final IngAddress shippingAddress;
  final IngAddress billingAddress;
  final DateTime updatedAt;
  final List<Item> items;
  final List<dynamic> invoices;
  final List<dynamic> shipments;
  final DateTime createdAt;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    id: json["id"],
    status: json["status"],
    statusLabel: json["status_label"],
    channelName: json["channel_name"],
    isGuest: json["is_guest"],
    customerEmail: json["customer_email"],
    customerFirstName: json["customer_first_name"],
    customerLastName: json["customer_last_name"],
    shippingMethod: json["shipping_method"],
    shippingTitle: json["shipping_title"],
    paymentTitle: json["payment_title"],
    shippingDescription: json["shipping_description"],
    couponCode: json["coupon_code"],
    isGift: json["is_gift"],
    totalItemCount: json["total_item_count"],
    totalQtyOrdered: json["total_qty_ordered"],
    baseCurrencyCode: json["base_currency_code"],
    channelCurrencyCode: json["channel_currency_code"],
    orderCurrencyCode: json["order_currency_code"],
    grandTotal: json["grand_total"],
    formatedGrandTotal: json["formated_grand_total"],
    baseGrandTotal: json["base_grand_total"],
    formatedBaseGrandTotal: json["formated_base_grand_total"],
    grandTotalInvoiced: json["grand_total_invoiced"],
    formatedGrandTotalInvoiced: json["formated_grand_total_invoiced"],
    baseGrandTotalInvoiced: json["base_grand_total_invoiced"],
    formatedBaseGrandTotalInvoiced: json["formated_base_grand_total_invoiced"],
    grandTotalRefunded: json["grand_total_refunded"],
    formatedGrandTotalRefunded: json["formated_grand_total_refunded"],
    baseGrandTotalRefunded: json["base_grand_total_refunded"],
    formatedBaseGrandTotalRefunded: json["formated_base_grand_total_refunded"],
    subTotal: json["sub_total"],
    formatedSubTotal: json["formated_sub_total"],
    baseSubTotal: json["base_sub_total"],
    formatedBaseSubTotal: json["formated_base_sub_total"],
    subTotalInvoiced: json["sub_total_invoiced"],
    formatedSubTotalInvoiced: json["formated_sub_total_invoiced"],
    baseSubTotalInvoiced: json["base_sub_total_invoiced"],
    formatedBaseSubTotalInvoiced: json["formated_base_sub_total_invoiced"],
    subTotalRefunded: json["sub_total_refunded"],
    formatedSubTotalRefunded: json["formated_sub_total_refunded"],
    discountPercent: json["discount_percent"],
    discountAmount: json["discount_amount"],
    formatedDiscountAmount: json["formated_discount_amount"],
    baseDiscountAmount: json["base_discount_amount"],
    formatedBaseDiscountAmount: json["formated_base_discount_amount"],
    discountInvoiced: json["discount_invoiced"],
    formatedDiscountInvoiced: json["formated_discount_invoiced"],
    baseDiscountInvoiced: json["base_discount_invoiced"],
    formatedBaseDiscountInvoiced: json["formated_base_discount_invoiced"],
    discountRefunded: json["discount_refunded"],
    formatedDiscountRefunded: json["formated_discount_refunded"],
    baseDiscountRefunded: json["base_discount_refunded"],
    formatedBaseDiscountRefunded: json["formated_base_discount_refunded"],
    taxAmount: json["tax_amount"],
    formatedTaxAmount: json["formated_tax_amount"],
    baseTaxAmount: json["base_tax_amount"],
    formatedBaseTaxAmount: json["formated_base_tax_amount"],
    taxAmountInvoiced: json["tax_amount_invoiced"],
    formatedTaxAmountInvoiced: json["formated_tax_amount_invoiced"],
    baseTaxAmountInvoiced: json["base_tax_amount_invoiced"],
    formatedBaseTaxAmountInvoiced: json["formated_base_tax_amount_invoiced"],
    taxAmountRefunded: json["tax_amount_refunded"],
    formatedTaxAmountRefunded: json["formated_tax_amount_refunded"],
    baseTaxAmountRefunded: json["base_tax_amount_refunded"],
    formatedBaseTaxAmountRefunded: json["formated_base_tax_amount_refunded"],
    shippingAmount: json["shipping_amount"],
    formatedShippingAmount: json["formated_shipping_amount"],
    baseShippingAmount: json["base_shipping_amount"],
    formatedBaseShippingAmount: json["formated_base_shipping_amount"],
    shippingInvoiced: json["shipping_invoiced"],
    formatedShippingInvoiced: json["formated_shipping_invoiced"],
    baseShippingInvoiced: json["base_shipping_invoiced"],
    formatedBaseShippingInvoiced: json["formated_base_shipping_invoiced"],
    shippingRefunded: json["shipping_refunded"],
    formatedShippingRefunded: json["formated_shipping_refunded"],
    baseShippingRefunded: json["base_shipping_refunded"],
    formatedBaseShippingRefunded: json["formated_base_shipping_refunded"],
    customer: Customer.fromMap(json["customer"]),
    channel: Channel.fromMap(json["channel"]),
    shippingAddress: json["shipping_address"] == null ? null : IngAddress.fromMap(json["shipping_address"]),
    billingAddress: json["billing_address"] == null ? null : IngAddress.fromMap(json["billing_address"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
    invoices: json["invoices"] == null ? null : List<dynamic>.from(json["invoices"].map((x) => x)),
    shipments: json["shipments"] == null ? null : List<dynamic>.from(json["shipments"].map((x) => x)),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "status": status,
    "status_label": statusLabel,
    "channel_name": channelName,
    "is_guest": isGuest,
    "customer_email": customerEmail,
    "customer_first_name": customerFirstName,
    "customer_last_name": customerLastName,
    "shipping_method": shippingMethod,
    "shipping_title": shippingTitle,
    "payment_title": paymentTitle,
    "shipping_description": shippingDescription,
    "coupon_code": couponCode,
    "is_gift": isGift,
    "total_item_count": totalItemCount,
    "total_qty_ordered": totalQtyOrdered,
    "base_currency_code": baseCurrencyCode,
    "channel_currency_code": channelCurrencyCode,
    "order_currency_code": orderCurrencyCode,
    "grand_total": grandTotal,
    "formated_grand_total": formatedGrandTotal,
    "base_grand_total": baseGrandTotal,
    "formated_base_grand_total": formatedBaseGrandTotal,
    "grand_total_invoiced": grandTotalInvoiced,
    "formated_grand_total_invoiced": formatedGrandTotalInvoiced,
    "base_grand_total_invoiced": baseGrandTotalInvoiced,
    "formated_base_grand_total_invoiced": formatedBaseGrandTotalInvoiced,
    "grand_total_refunded": grandTotalRefunded,
    "formated_grand_total_refunded": formatedGrandTotalRefunded,
    "base_grand_total_refunded": baseGrandTotalRefunded,
    "formated_base_grand_total_refunded": formatedBaseGrandTotalRefunded,
    "sub_total": subTotal,
    "formated_sub_total": formatedSubTotal,
    "base_sub_total": baseSubTotal,
    "formated_base_sub_total": formatedBaseSubTotal,
    "sub_total_invoiced": subTotalInvoiced,
    "formated_sub_total_invoiced": formatedSubTotalInvoiced,
    "base_sub_total_invoiced": baseSubTotalInvoiced,
    "formated_base_sub_total_invoiced": formatedBaseSubTotalInvoiced,
    "sub_total_refunded": subTotalRefunded,
    "formated_sub_total_refunded": formatedSubTotalRefunded,
    "discount_percent": discountPercent,
    "discount_amount": discountAmount,
    "formated_discount_amount": formatedDiscountAmount,
    "base_discount_amount": baseDiscountAmount,
    "formated_base_discount_amount": formatedBaseDiscountAmount,
    "discount_invoiced": discountInvoiced,
    "formated_discount_invoiced": formatedDiscountInvoiced,
    "base_discount_invoiced": baseDiscountInvoiced,
    "formated_base_discount_invoiced": formatedBaseDiscountInvoiced,
    "discount_refunded": discountRefunded,
    "formated_discount_refunded": formatedDiscountRefunded,
    "base_discount_refunded": baseDiscountRefunded,
    "formated_base_discount_refunded": formatedBaseDiscountRefunded,
    "tax_amount": taxAmount,
    "formated_tax_amount": formatedTaxAmount,
    "base_tax_amount": baseTaxAmount,
    "formated_base_tax_amount": formatedBaseTaxAmount,
    "tax_amount_invoiced": taxAmountInvoiced,
    "formated_tax_amount_invoiced": formatedTaxAmountInvoiced,
    "base_tax_amount_invoiced": baseTaxAmountInvoiced,
    "formated_base_tax_amount_invoiced": formatedBaseTaxAmountInvoiced,
    "tax_amount_refunded": taxAmountRefunded,
    "formated_tax_amount_refunded": formatedTaxAmountRefunded,
    "base_tax_amount_refunded": baseTaxAmountRefunded,
    "formated_base_tax_amount_refunded": formatedBaseTaxAmountRefunded,
    "shipping_amount": shippingAmount,
    "formated_shipping_amount": formatedShippingAmount,
    "base_shipping_amount": baseShippingAmount,
    "formated_base_shipping_amount": formatedBaseShippingAmount,
    "shipping_invoiced": shippingInvoiced,
    "formated_shipping_invoiced": formatedShippingInvoiced,
    "base_shipping_invoiced": baseShippingInvoiced,
    "formated_base_shipping_invoiced": formatedBaseShippingInvoiced,
    "shipping_refunded": shippingRefunded,
    "formated_shipping_refunded": formatedShippingRefunded,
    "base_shipping_refunded": baseShippingRefunded,
    "formated_base_shipping_refunded": formatedBaseShippingRefunded,
    "customer": customer.toMap(),
    "channel": channel.toMap(),
    "shipping_address": shippingAddress.toMap(),
    "billing_address": billingAddress.toMap(),
    "updated_at": updatedAt.toIso8601String(),
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
    "invoices": List<dynamic>.from(invoices.map((x) => x)),
    "shipments": List<dynamic>.from(shipments.map((x) => x)),
    "created_at": createdAt.toIso8601String(),
  };
}

class IngAddress {
  IngAddress({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
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
  final dynamic email;
  final String firstName;
  final String lastName;
  final List<String> address1;
  final String country;
  final String countryName;
  final String state;
  final String city;
  final String postcode;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory IngAddress.fromJson(String str) => IngAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IngAddress.fromMap(Map<String, dynamic> json) => IngAddress(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    address1: List<String>.from(json["address1"].map((x) => x)),
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
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "address1": List<dynamic>.from(address1.map((x) => x)),
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

class Channel {
  Channel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.timezone,
    this.theme,
    this.homePageContent,
    this.footerContent,
    this.hostname,
    this.logo,
    this.logoUrl,
    this.favicon,
    this.faviconUrl,
    this.defaultLocale,
    this.rootCategoryId,
    this.rootCategory,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String code;
  final String name;
  final String description;
  final dynamic timezone;
  final String theme;
  final String homePageContent;
  final String footerContent;
  final String hostname;
  final dynamic logo;
  final dynamic logoUrl;
  final dynamic favicon;
  final dynamic faviconUrl;
  final DefaultLocale defaultLocale;
  final int rootCategoryId;
  final RootCategory rootCategory;
  final dynamic createdAt;
  final DateTime updatedAt;

  factory Channel.fromJson(String str) => Channel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Channel.fromMap(Map<String, dynamic> json) => Channel(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    description: json["description"],
    timezone: json["timezone"],
    theme: json["theme"],
    homePageContent: json["home_page_content"],
    footerContent: json["footer_content"],
    hostname: json["hostname"],
    logo: json["logo"],
    logoUrl: json["logo_url"],
    favicon: json["favicon"],
    faviconUrl: json["favicon_url"],
    defaultLocale: DefaultLocale.fromMap(json["default_locale"]),
    rootCategoryId: json["root_category_id"],
    rootCategory: RootCategory.fromMap(json["root_category"]),
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "code": code,
    "name": name,
    "description": description,
    "timezone": timezone,
    "theme": theme,
    "home_page_content": homePageContent,
    "footer_content": footerContent,
    "hostname": hostname,
    "logo": logo,
    "logo_url": logoUrl,
    "favicon": favicon,
    "favicon_url": faviconUrl,
    "default_locale": defaultLocale.toMap(),
    "root_category_id": rootCategoryId,
    "root_category": rootCategory.toMap(),
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
  };
}

class DefaultLocale {
  DefaultLocale({
    this.id,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String code;
  final String name;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory DefaultLocale.fromJson(String str) => DefaultLocale.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DefaultLocale.fromMap(Map<String, dynamic> json) => DefaultLocale(
    id: json["id"],
    code: json["code"] == null ? null : json["code"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "code": code == null ? null : code,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class RootCategory {
  RootCategory({
    this.id,
    this.code,
    this.name,
    this.slug,
    this.displayMode,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.status,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final dynamic code;
  final String name;
  final String slug;
  final String displayMode;
  final String description;
  final String metaTitle;
  final String metaDescription;
  final String metaKeywords;
  final int status;
  final dynamic imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory RootCategory.fromJson(String str) => RootCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RootCategory.fromMap(Map<String, dynamic> json) => RootCategory(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    slug: json["slug"],
    displayMode: json["display_mode"],
    description: json["description"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaKeywords: json["meta_keywords"],
    status: json["status"],
    imageUrl: json["image_url"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "code": code,
    "name": name,
    "slug": slug,
    "display_mode": displayMode,
    "description": description,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "status": status,
    "image_url": imageUrl,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Customer {
  Customer({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.phone,
    this.status,
    this.group,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String name;
  final dynamic gender;
  final dynamic dateOfBirth;
  final dynamic phone;
  final int status;
  final DefaultLocale group;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    name: json["name"],
    gender: json["gender"],
    dateOfBirth: json["date_of_birth"],
    phone: json["phone"],
    status: json["status"],
    group: DefaultLocale.fromMap(json["group"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "name": name,
    "gender": gender,
    "date_of_birth": dateOfBirth,
    "phone": phone,
    "status": status,
    "group": group.toMap(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Item {
  Item({
    this.id,
    this.sku,
    this.type,
    this.name,
    this.product,
    this.couponCode,
    this.weight,
    this.totalWeight,
    this.qtyOrdered,
    this.qtyCanceled,
    this.qtyInvoiced,
    this.qtyShipped,
    this.qtyRefunded,
    this.price,
    this.formatedPrice,
    this.basePrice,
    this.formatedBasePrice,
    this.total,
    this.formatedTotal,
    this.baseTotal,
    this.formatedBaseTotal,
    this.totalInvoiced,
    this.formatedTotalInvoiced,
    this.baseTotalInvoiced,
    this.formatedBaseTotalInvoiced,
    this.amountRefunded,
    this.formatedAmountRefunded,
    this.baseAmountRefunded,
    this.formatedBaseAmountRefunded,
    this.discountPercent,
    this.discountAmount,
    this.formatedDiscountAmount,
    this.baseDiscountAmount,
    this.formatedBaseDiscountAmount,
    this.discountInvoiced,
    this.formatedDiscountInvoiced,
    this.baseDiscountInvoiced,
    this.formatedBaseDiscountInvoiced,
    this.discountRefunded,
    this.formatedDiscountRefunded,
    this.baseDiscountRefunded,
    this.formatedBaseDiscountRefunded,
    this.taxPercent,
    this.taxAmount,
    this.formatedTaxAmount,
    this.baseTaxAmount,
    this.formatedBaseTaxAmount,
    this.taxAmountInvoiced,
    this.formatedTaxAmountInvoiced,
    this.baseTaxAmountInvoiced,
    this.formatedBaseTaxAmountInvoiced,
    this.taxAmountRefunded,
    this.formatedTaxAmountRefunded,
    this.baseTaxAmountRefunded,
    this.formatedBaseTaxAmountRefunded,
    this.grantTotal,
    this.formatedGrantTotal,
    this.baseGrantTotal,
    this.formatedBaseGrantTotal,
    this.additional,
    this.child,
    this.children,
  });

  final int id;
  final String sku;
  final String type;
  final String name;
  final Product product;
  final dynamic couponCode;
  final String weight;
  final String totalWeight;
  final int qtyOrdered;
  final int qtyCanceled;
  final int qtyInvoiced;
  final int qtyShipped;
  final int qtyRefunded;
  final String price;
  final String formatedPrice;
  final String basePrice;
  final String formatedBasePrice;
  final String total;
  final String formatedTotal;
  final String baseTotal;
  final String formatedBaseTotal;
  final String totalInvoiced;
  final String formatedTotalInvoiced;
  final String baseTotalInvoiced;
  final String formatedBaseTotalInvoiced;
  final String amountRefunded;
  final String formatedAmountRefunded;
  final String baseAmountRefunded;
  final String formatedBaseAmountRefunded;
  final String discountPercent;
  final String discountAmount;
  final String formatedDiscountAmount;
  final String baseDiscountAmount;
  final String formatedBaseDiscountAmount;
  final String discountInvoiced;
  final String formatedDiscountInvoiced;
  final String baseDiscountInvoiced;
  final String formatedBaseDiscountInvoiced;
  final String discountRefunded;
  final String formatedDiscountRefunded;
  final String baseDiscountRefunded;
  final String formatedBaseDiscountRefunded;
  final String taxPercent;
  final String taxAmount;
  final String formatedTaxAmount;
  final String baseTaxAmount;
  final String formatedBaseTaxAmount;
  final String taxAmountInvoiced;
  final String formatedTaxAmountInvoiced;
  final String baseTaxAmountInvoiced;
  final String formatedBaseTaxAmountInvoiced;
  final String taxAmountRefunded;
  final String formatedTaxAmountRefunded;
  final String baseTaxAmountRefunded;
  final String formatedBaseTaxAmountRefunded;
  final double grantTotal;
  final String formatedGrantTotal;
  final double baseGrantTotal;
  final String formatedBaseGrantTotal;
  final Additional additional;
  final dynamic child;
  final List<dynamic> children;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    id: json["id"],
    sku: json["sku"],
    type: json["type"],
    name: json["name"],
    product: Product.fromMap(json["product"]),
    couponCode: json["coupon_code"],
    weight: json["weight"],
    totalWeight: json["total_weight"],
    qtyOrdered: json["qty_ordered"],
    qtyCanceled: json["qty_canceled"],
    qtyInvoiced: json["qty_invoiced"],
    qtyShipped: json["qty_shipped"],
    qtyRefunded: json["qty_refunded"],
    price: json["price"],
    formatedPrice: json["formated_price"],
    basePrice: json["base_price"],
    formatedBasePrice: json["formated_base_price"],
    total: json["total"],
    formatedTotal: json["formated_total"],
    baseTotal: json["base_total"],
    formatedBaseTotal: json["formated_base_total"],
    totalInvoiced: json["total_invoiced"],
    formatedTotalInvoiced: json["formated_total_invoiced"],
    baseTotalInvoiced: json["base_total_invoiced"],
    formatedBaseTotalInvoiced: json["formated_base_total_invoiced"],
    amountRefunded: json["amount_refunded"],
    formatedAmountRefunded: json["formated_amount_refunded"],
    baseAmountRefunded: json["base_amount_refunded"],
    formatedBaseAmountRefunded: json["formated_base_amount_refunded"],
    discountPercent: json["discount_percent"],
    discountAmount: json["discount_amount"],
    formatedDiscountAmount: json["formated_discount_amount"],
    baseDiscountAmount: json["base_discount_amount"],
    formatedBaseDiscountAmount: json["formated_base_discount_amount"],
    discountInvoiced: json["discount_invoiced"],
    formatedDiscountInvoiced: json["formated_discount_invoiced"],
    baseDiscountInvoiced: json["base_discount_invoiced"],
    formatedBaseDiscountInvoiced: json["formated_base_discount_invoiced"],
    discountRefunded: json["discount_refunded"],
    formatedDiscountRefunded: json["formated_discount_refunded"],
    baseDiscountRefunded: json["base_discount_refunded"],
    formatedBaseDiscountRefunded: json["formated_base_discount_refunded"],
    taxPercent: json["tax_percent"],
    taxAmount: json["tax_amount"],
    formatedTaxAmount: json["formated_tax_amount"],
    baseTaxAmount: json["base_tax_amount"],
    formatedBaseTaxAmount: json["formated_base_tax_amount"],
    taxAmountInvoiced: json["tax_amount_invoiced"],
    formatedTaxAmountInvoiced: json["formated_tax_amount_invoiced"],
    baseTaxAmountInvoiced: json["base_tax_amount_invoiced"],
    formatedBaseTaxAmountInvoiced: json["formated_base_tax_amount_invoiced"],
    taxAmountRefunded: json["tax_amount_refunded"],
    formatedTaxAmountRefunded: json["formated_tax_amount_refunded"],
    baseTaxAmountRefunded: json["base_tax_amount_refunded"],
    formatedBaseTaxAmountRefunded: json["formated_base_tax_amount_refunded"],
    grantTotal: json["grant_total"].toDouble(),
    formatedGrantTotal: json["formated_grant_total"],
    baseGrantTotal: json["base_grant_total"].toDouble(),
    formatedBaseGrantTotal: json["formated_base_grant_total"],
    additional: Additional.fromMap(json["additional"]),
    child: json["child"],
    children: List<dynamic>.from(json["children"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "sku": sku,
    "type": type,
    "name": name,
    "product": product.toMap(),
    "coupon_code": couponCode,
    "weight": weight,
    "total_weight": totalWeight,
    "qty_ordered": qtyOrdered,
    "qty_canceled": qtyCanceled,
    "qty_invoiced": qtyInvoiced,
    "qty_shipped": qtyShipped,
    "qty_refunded": qtyRefunded,
    "price": price,
    "formated_price": formatedPrice,
    "base_price": basePrice,
    "formated_base_price": formatedBasePrice,
    "total": total,
    "formated_total": formatedTotal,
    "base_total": baseTotal,
    "formated_base_total": formatedBaseTotal,
    "total_invoiced": totalInvoiced,
    "formated_total_invoiced": formatedTotalInvoiced,
    "base_total_invoiced": baseTotalInvoiced,
    "formated_base_total_invoiced": formatedBaseTotalInvoiced,
    "amount_refunded": amountRefunded,
    "formated_amount_refunded": formatedAmountRefunded,
    "base_amount_refunded": baseAmountRefunded,
    "formated_base_amount_refunded": formatedBaseAmountRefunded,
    "discount_percent": discountPercent,
    "discount_amount": discountAmount,
    "formated_discount_amount": formatedDiscountAmount,
    "base_discount_amount": baseDiscountAmount,
    "formated_base_discount_amount": formatedBaseDiscountAmount,
    "discount_invoiced": discountInvoiced,
    "formated_discount_invoiced": formatedDiscountInvoiced,
    "base_discount_invoiced": baseDiscountInvoiced,
    "formated_base_discount_invoiced": formatedBaseDiscountInvoiced,
    "discount_refunded": discountRefunded,
    "formated_discount_refunded": formatedDiscountRefunded,
    "base_discount_refunded": baseDiscountRefunded,
    "formated_base_discount_refunded": formatedBaseDiscountRefunded,
    "tax_percent": taxPercent,
    "tax_amount": taxAmount,
    "formated_tax_amount": formatedTaxAmount,
    "base_tax_amount": baseTaxAmount,
    "formated_base_tax_amount": formatedBaseTaxAmount,
    "tax_amount_invoiced": taxAmountInvoiced,
    "formated_tax_amount_invoiced": formatedTaxAmountInvoiced,
    "base_tax_amount_invoiced": baseTaxAmountInvoiced,
    "formated_base_tax_amount_invoiced": formatedBaseTaxAmountInvoiced,
    "tax_amount_refunded": taxAmountRefunded,
    "formated_tax_amount_refunded": formatedTaxAmountRefunded,
    "base_tax_amount_refunded": baseTaxAmountRefunded,
    "formated_base_tax_amount_refunded": formatedBaseTaxAmountRefunded,
    "grant_total": grantTotal,
    "formated_grant_total": formatedGrantTotal,
    "base_grant_total": baseGrantTotal,
    "formated_base_grant_total": formatedBaseGrantTotal,
    "additional": additional.toMap(),
    "child": child,
    "children": List<dynamic>.from(children.map((x) => x)),
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
