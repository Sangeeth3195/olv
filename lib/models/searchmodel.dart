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
  ItemTypename? typename;
  int? id;
  String? name;
  String? sku;
  StockStatus? stockStatus;
  String? brands;
  List<GetPriceRange>? getPriceRange;
  List<TextAttribute>? textAttributes;
  ImageProduct? image;

  Item({
    this.typename,
    this.id,
    this.name,
    this.sku,
    this.stockStatus,
    this.brands,
    this.getPriceRange,
    this.textAttributes,
    this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    typename: itemTypenameValues.map[json["__typename"]]!,
    id: json["id"],
    name: json["name"],
    sku: json["sku"],
    stockStatus: stockStatusValues.map[json["stock_status"]]!,
    brands: json["brands"],
    getPriceRange: json["getPriceRange"] == null ? [] : List<GetPriceRange>.from(json["getPriceRange"]!.map((x) => GetPriceRange.fromJson(x))),
    textAttributes: json["textAttributes"] == null ? [] : List<TextAttribute>.from(json["textAttributes"]!.map((x) => TextAttribute.fromJson(x))),
    image: json["image"] == null ? null : ImageProduct.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": itemTypenameValues.reverse[typename],
    "id": id,
    "name": name,
    "sku": sku,
    "stock_status": stockStatusValues.reverse[stockStatus],
    "brands": brands,
    "getPriceRange": getPriceRange == null ? [] : List<dynamic>.from(getPriceRange!.map((x) => x.toJson())),
    "textAttributes": textAttributes == null ? [] : List<dynamic>.from(textAttributes!.map((x) => x.toJson())),
    "image": image?.toJson(),
  };
}

class GetPriceRange {
  String? typename;
  String? oldpricevalue;
  String? normalpricevalue;

  GetPriceRange({
    this.typename,
    this.oldpricevalue,
    this.normalpricevalue,
  });

  factory GetPriceRange.fromJson(Map<String, dynamic> json) => GetPriceRange(
    typename: json["__typename"],
    oldpricevalue: json["oldpricevalue"],
    normalpricevalue: json["normalpricevalue"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "oldpricevalue": oldpricevalue,
    "normalpricevalue": normalpricevalue,
  };
}

class ImageProduct {
  ImageTypename? typename;
  String? url;
  String? label;
  dynamic position;
  dynamic disabled;

  ImageProduct({
    this.typename,
    this.url,
    this.label,
    this.position,
    this.disabled,
  });

  factory ImageProduct.fromJson(Map<String, dynamic> json) => ImageProduct(
    typename: imageTypenameValues.map[json["__typename"]]!,
    url: json["url"],
    label: json["label"],
    position: json["position"],
    disabled: json["disabled"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": imageTypenameValues.reverse[typename],
    "url": url,
    "label": label,
    "position": position,
    "disabled": disabled,
  };
}

enum ImageTypename {
  PRODUCT_IMAGE
}

final imageTypenameValues = EnumValues({
  "ProductImage": ImageTypename.PRODUCT_IMAGE
});

enum StockStatus {
  IN_STOCK
}

final stockStatusValues = EnumValues({
  "IN_STOCK": StockStatus.IN_STOCK
});

class TextAttribute {
  TextAttributeTypename? typename;
  Weight? weight;
  String? normalprice;
  dynamic specicalprice;

  TextAttribute({
    this.typename,
    this.weight,
    this.normalprice,
    this.specicalprice,
  });

  factory TextAttribute.fromJson(Map<String, dynamic> json) => TextAttribute(
    typename: textAttributeTypenameValues.map[json["__typename"]]!,
    weight: weightValues.map[json["weight"]]!,
    normalprice: json["normalprice"],
    specicalprice: json["specicalprice"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": textAttributeTypenameValues.reverse[typename],
    "weight": weightValues.reverse[weight],
    "normalprice": normalprice,
    "specicalprice": specicalprice,
  };
}

enum TextAttributeTypename {
  TEXT_ATTRIBUTES
}

final textAttributeTypenameValues = EnumValues({
  "TextAttributes": TextAttributeTypename.TEXT_ATTRIBUTES
});

enum Weight {
  THE_000_GM
}

final weightValues = EnumValues({
  "0.00 GM": Weight.THE_000_GM
});

enum ItemTypename {
  CONFIGURABLE_PRODUCT,
  SIMPLE_PRODUCT
}

final itemTypenameValues = EnumValues({
  "ConfigurableProduct": ItemTypename.CONFIGURABLE_PRODUCT,
  "SimpleProduct": ItemTypename.SIMPLE_PRODUCT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
