// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  String? typename;
  Cart? cart;

  CartModel({
    this.typename,
    this.cart,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    typename: json["__typename"],
    cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "cart": cart?.toJson(),
  };
}

class Cart {
  String? typename;
  String? id;
  List<Item>? items;
  List<dynamic>? shippingAddresses;
  Prices? prices;

  Cart({
    this.typename,
    this.id,
    this.items,
    this.shippingAddresses,
    this.prices,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    typename: json["__typename"],
    id: json["id"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    shippingAddresses: json["shipping_addresses"] == null ? [] : List<dynamic>.from(json["shipping_addresses"]!.map((x) => x)),
    prices: json["prices"] == null ? null : Prices.fromJson(json["prices"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "shipping_addresses": shippingAddresses == null ? [] : List<dynamic>.from(shippingAddresses!.map((x) => x)),
    "prices": prices?.toJson(),
  };
}

class Item {
  String? typename;
  int? quantity;
  String? id;
  String? uid;
  Product? product;

  Item({
    this.typename,
    this.quantity,
    this.id,
    this.uid,
    this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    typename: json["__typename"],
    quantity: json["quantity"],
    id: json["id"],
    uid: json["uid"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "quantity": quantity,
    "id": id,
    "uid": uid,
    "product": product?.toJson(),
  };
}

class Product {
  String? typename;
  String? sku;
  String? uid;
  String? name;
  List<DynamicAttribute>? dynamicAttributes;
  PriceRange? priceRange;
  List<MediaGallery>? mediaGallery;

  Product({
    this.typename,
    this.sku,
    this.uid,
    this.name,
    this.dynamicAttributes,
    this.priceRange,
    this.mediaGallery,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    typename: json["__typename"],
    sku: json["sku"],
    uid: json["uid"],
    name: json["name"],
    dynamicAttributes: json["dynamicAttributes"] == null ? [] : List<DynamicAttribute>.from(json["dynamicAttributes"]!.map((x) => DynamicAttribute.fromJson(x))),
    priceRange: json["price_range"] == null ? null : PriceRange.fromJson(json["price_range"]),
    mediaGallery: json["media_gallery"] == null ? [] : List<MediaGallery>.from(json["media_gallery"]!.map((x) => MediaGallery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "sku": sku,
    "uid": uid,
    "name": name,
    "dynamicAttributes": dynamicAttributes == null ? [] : List<dynamic>.from(dynamicAttributes!.map((x) => x.toJson())),
    "price_range": priceRange?.toJson(),
    "media_gallery": mediaGallery == null ? [] : List<dynamic>.from(mediaGallery!.map((x) => x.toJson())),
  };
}

class DynamicAttribute {
  String? typename;
  String? attributeCode;
  String? attributeLabel;
  String? attributeValue;

  DynamicAttribute({
    this.typename,
    this.attributeCode,
    this.attributeLabel,
    this.attributeValue,
  });

  factory DynamicAttribute.fromJson(Map<String, dynamic> json) => DynamicAttribute(
    typename: json["__typename"],
    attributeCode: json["attribute_code"],
    attributeLabel: json["attribute_label"],
    attributeValue: json["attribute_value"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "attribute_code": attributeCode,
    "attribute_label": attributeLabel,
    "attribute_value": attributeValue,
  };
}

class MediaGallery {
  String? typename;
  String? url;
  dynamic label;
  int? position;
  bool? disabled;

  MediaGallery({
    this.typename,
    this.url,
    this.label,
    this.position,
    this.disabled,
  });

  factory MediaGallery.fromJson(Map<String, dynamic> json) => MediaGallery(
    typename: json["__typename"],
    url: json["url"],
    label: json["label"],
    position: json["position"],
    disabled: json["disabled"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "url": url,
    "label": label,
    "position": position,
    "disabled": disabled,
  };
}

class PriceRange {
  String? typename;
  MinimumPrice? minimumPrice;

  PriceRange({
    this.typename,
    this.minimumPrice,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
    typename: json["__typename"],
    minimumPrice: json["minimum_price"] == null ? null : MinimumPrice.fromJson(json["minimum_price"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "minimum_price": minimumPrice?.toJson(),
  };
}

class MinimumPrice {
  String? typename;
  GrandTotal? regularPrice;

  MinimumPrice({
    this.typename,
    this.regularPrice,
  });

  factory MinimumPrice.fromJson(Map<String, dynamic> json) => MinimumPrice(
    typename: json["__typename"],
    regularPrice: json["regular_price"] == null ? null : GrandTotal.fromJson(json["regular_price"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "regular_price": regularPrice?.toJson(),
  };
}

class GrandTotal {
  String? typename;
  double? value;
  String? currency;

  GrandTotal({
    this.typename,
    this.value,
    this.currency,
  });

  factory GrandTotal.fromJson(Map<String, dynamic> json) => GrandTotal(
    typename: json["__typename"],
    value: json["value"]?.toDouble(),
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "value": value,
    "currency": currency,
  };
}

class Prices {
  String? typename;
  List<Discount>? discounts;
  GrandTotal? subtotalExcludingTax;
  GrandTotal? grandTotal;

  Prices({
    this.typename,
    this.discounts,
    this.subtotalExcludingTax,
    this.grandTotal,
  });

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
    typename: json["__typename"],
    discounts: json["discounts"] == null ? [] : List<Discount>.from(json["discounts"]!.map((x) => Discount.fromJson(x))),
    subtotalExcludingTax: json["subtotal_excluding_tax"] == null ? null : GrandTotal.fromJson(json["subtotal_excluding_tax"]),
    grandTotal: json["grand_total"] == null ? null : GrandTotal.fromJson(json["grand_total"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "discounts": discounts == null ? [] : List<dynamic>.from(discounts!.map((x) => x.toJson())),
    "subtotal_excluding_tax": subtotalExcludingTax?.toJson(),
    "grand_total": grandTotal?.toJson(),
  };
}

class Discount {
  String? typename;
  String? label;
  Amount? amount;

  Discount({
    this.typename,
    this.label,
    this.amount,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    typename: json["__typename"],
    label: json["label"],
    amount: json["amount"] == null ? null : Amount.fromJson(json["amount"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "label": label,
    "amount": amount?.toJson(),
  };
}

class Amount {
  String? typename;
  double? value;

  Amount({
    this.typename,
    this.value,
  });

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
    typename: json["__typename"],
    value: json["value"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "value": value,
  };
}
