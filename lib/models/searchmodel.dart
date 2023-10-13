// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  String? typename;
  Products? products;

  SearchModel({
    this.typename,
    this.products,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    typename: json["__typename"],
    products: json["products"] == null ? null : Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "products": products?.toJson(),
  };
}

class Products {
  String? typename;
  List<Item>? items;

  Products({
    this.typename,
    this.items,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    typename: json["__typename"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  int? id;
  String? name;
  String? sku;
  String? stockStatus;
  String? brands;
  List<TextAttribute>? textAttributes;
  ImageProduct? image;

  Item({
    this.id,
    this.name,
    this.sku,
    this.stockStatus,
    this.brands,
    this.textAttributes,
    this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    sku: json["sku"],
    stockStatus: json["stock_status"]!,
    brands: json["brands"],
    textAttributes: json["textAttributes"] == null ? [] : List<TextAttribute>.from(json["textAttributes"]!.map((x) => TextAttribute.fromJson(x))),
    image: json["image"] == null ? null : ImageProduct.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sku": sku,
    "stock_status": stockStatus,
    "brands": brands,
    "textAttributes": textAttributes == null ? [] : List<dynamic>.from(textAttributes!.map((x) => x.toJson())),
    "image": image?.toJson(),
  };
}

class GetPriceRange {
  String? oldpricevalue;
  String? normalpricevalue;

  GetPriceRange({
    this.oldpricevalue,
    this.normalpricevalue,
  });

  factory GetPriceRange.fromJson(Map<String, dynamic> json) => GetPriceRange(
    oldpricevalue: json["oldpricevalue"],
    normalpricevalue: json["normalpricevalue"],
  );

  Map<String, dynamic> toJson() => {
    "oldpricevalue": oldpricevalue,
    "normalpricevalue": normalpricevalue,
  };
}

class ImageProduct {
  String? url;
  String? label;
  dynamic position;
  dynamic disabled;

  ImageProduct({
    this.url,
    this.label,
    this.position,
    this.disabled,
  });

  factory ImageProduct.fromJson(Map<String, dynamic> json) => ImageProduct(
    url: json["url"],
    label: json["label"],
    position: json["position"],
    disabled: json["disabled"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "position": position,
    "disabled": disabled,
  };
}

class TextAttribute {
  String? weight;
  String? normalprice;
  dynamic specicalprice;

  TextAttribute({
    this.weight,
    this.normalprice,
    this.specicalprice,
  });

  factory TextAttribute.fromJson(Map<String, dynamic> json) => TextAttribute(
    weight: json["weight"]!,
    normalprice: json["normalprice"],
    specicalprice: json["specicalprice"],
  );

  Map<String, dynamic> toJson() => {
    "weight": weight,
    "normalprice": normalprice,
    "specicalprice": specicalprice,
  };
}


class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
