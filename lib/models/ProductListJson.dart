// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  Data data;

  ProductListModel({
    required this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String typename;
  Products products;

  Data({
    required this.typename,
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    typename: json["__typename"],
    products: Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "products": products.toJson(),
  };
}

class Products {
  String typename;
  List<Aggregation> aggregations;
  List<Item> items;
  int totalCount;
  PageInfo pageInfo;

  Products({
    required this.typename,
    required this.aggregations,
    required this.items,
    required this.totalCount,
    required this.pageInfo,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    typename: json["__typename"],
    aggregations: List<Aggregation>.from(json["aggregations"].map((x) => Aggregation.fromJson(x))),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    totalCount: json["total_count"],
    pageInfo: PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "aggregations": List<dynamic>.from(aggregations.map((x) => x.toJson())),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "total_count": totalCount,
    "page_info": pageInfo.toJson(),
  };
}

class Aggregation {
  String typename;
  String attributeCode;
  int count;
  String label;
  List<Option> options;
  List<String> selected;

  Aggregation({
    required this.typename,
    required this.attributeCode,
    required this.count,
    required this.label,
    required this.options,
    required this.selected,
  });

  factory Aggregation.fromJson(Map<String, dynamic> json) => Aggregation(
    typename: json["__typename"],
    attributeCode: json["attribute_code"],
    count: json["count"],
    label: json["label"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      selected: []

  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "attribute_code": attributeCode,
    "count": count,
    "label": label,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
    "selected": selected,

  };
}

class Option {
  Typename typename;
  String label;
  String value;
  int count;

  Option({
    required this.typename,
    required this.label,
    required this.value,
    required this.count,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    typename: typenameValues.map[json["__typename"]]!,
    label: json["label"],
    value: json["value"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "label": label,
    "value": value,
    "count": count,
  };
}

enum Typename {
  AGGREGATION_OPTION
}

final typenameValues = EnumValues({
  "AggregationOption": Typename.AGGREGATION_OPTION
});

class Item {
  int id;
  String name;
  String typename;
  String sku;
  String special_from_date;
  String special_to_date;
  PriceRange priceRange;
  List<ConfigurableOption> configurableOptions;
  List<Variant> variants;
  List<GetPriceRange> getPriceRange;
  List<TextAttribute> textAttributes;
  List<DynamicAttribute> dynamicAttributes;
  String urlKey;
  SmallImage smallImage;
  bool wishlist=false;

  Item({
    required this.id,
    required this.wishlist,
    required this.name,
    required this.typename,
    required this.sku,
    required this.special_from_date,
    required this.special_to_date,
    required this.priceRange,
    required this.configurableOptions,
    required this.variants,
    required this.getPriceRange,
    required this.textAttributes,
    required this.dynamicAttributes,
    required this.urlKey,
    required this.smallImage,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    wishlist: json["is_wishlisted"]??false,
    name: json["name"],
    typename: json["__typename"],
    sku: json["sku"],
    special_from_date: json["special_from_date"] ?? '',
    special_to_date: json["special_to_date"] ?? '',
    priceRange: json["price_range"]==null ? PriceRange(typename: '', minimumPrice: MinimumPrice(typename: "",regularPrice: RegularPrice(typename: "",currency: "",value: 0))):PriceRange.fromJson(json["price_range"]),
    configurableOptions: json["configurable_options"]==null?[]:List<ConfigurableOption>.from(json["configurable_options"].map((x) => ConfigurableOption.fromJson(x))),
    variants: json["variants"]==null?[]:List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
    getPriceRange: json["getPriceRange"]==null?[]:List<GetPriceRange>.from(json["getPriceRange"].map((x) => GetPriceRange.fromJson(x))),
    textAttributes: json["textAttributes"]==null?[]:List<TextAttribute>.from(json["textAttributes"].map((x) => TextAttribute.fromJson(x))),
    dynamicAttributes: json["dynamicAttributes"]==null?[]:List<DynamicAttribute>.from(json["dynamicAttributes"].map((x) => DynamicAttribute.fromJson(x))),
    urlKey: json["url_key"],
    smallImage: SmallImage.fromJson(json["small_image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "__typename": typename,
    "sku": sku,
    "special_from_date": special_from_date,
    "special_to_date": special_to_date,
    "price_range": priceRange.toJson(),
    "configurable_options": List<dynamic>.from(configurableOptions.map((x) => x.toJson())),
    "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
    "getPriceRange": List<dynamic>.from(getPriceRange.map((x) => x.toJson())),
    "textAttributes": List<dynamic>.from(textAttributes.map((x) => x.toJson())),
    "dynamicAttributes": List<dynamic>.from(dynamicAttributes.map((x) => x.toJson())),
    "url_key": urlKey,
    "small_image": smallImage.toJson(),
  };
}

class ConfigurableOption {
  String typename;
  int id;
  String attributeId;
  String label;
  int position;
  bool useDefault;
  String attributeCode;
  List<Value> values;
  int productId;

  ConfigurableOption({
    required this.typename,
    required this.id,
    required this.attributeId,
    required this.label,
    required this.position,
    required this.useDefault,
    required this.attributeCode,
    required this.values,
    required this.productId,
  });

  factory ConfigurableOption.fromJson(Map<String, dynamic> json) => ConfigurableOption(
    typename: json["__typename"],
    id: json["id"],
    attributeId: json["attribute_id"],
    label: json["label"] ?? '',
    position: json["position"],
    useDefault: json["use_default"],
    attributeCode: json["attribute_code"],
    values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
    productId: json["product_id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "attribute_id": attributeId,
    "label": label,
    "position": position,
    "use_default": useDefault,
    "attribute_code": attributeCode,
    "values": List<dynamic>.from(values.map((x) => x.toJson())),
    "product_id": productId,
  };
}

class Value {
  String typename;
  int valueIndex;
  String label;
  SwatchData swatchData;

  Value({
    required this.typename,
    required this.valueIndex,
    required this.label,
    required this.swatchData,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    typename: json["__typename"],
    valueIndex: json["value_index"],
    label: json["label"],
    swatchData: json["swatch_data"]==null?SwatchData(typename: 'typename', value: 'value'):SwatchData.fromJson(json["swatch_data"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "value_index": valueIndex,
    "label": label,
    "swatch_data": swatchData.toJson(),
  };
}

class SwatchData {
  String typename;
  String value;

  SwatchData({
    required this.typename,
    required this.value,
  });

  factory SwatchData.fromJson(Map<String, dynamic> json) => SwatchData(
    typename: json["__typename"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "value": value,
  };
}

class DynamicAttribute {
  String typename;
  String attributeCode;
  String attributeLabel;
  String attributeValue;

  DynamicAttribute({
    required this.typename,
    required this.attributeCode,
    required this.attributeLabel,
    required this.attributeValue,
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

class GetPriceRange {
  String typename;
  String oldpricevalue;
  String normalpricevalue;

  GetPriceRange({
    required this.typename,
    required this.oldpricevalue,
    required this.normalpricevalue,
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

class PriceRange {
  String typename;
  MinimumPrice minimumPrice;

  PriceRange({
    required this.typename,
    required this.minimumPrice,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
    typename: json["__typename"],
    minimumPrice: MinimumPrice.fromJson(json["minimum_price"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "minimum_price": minimumPrice.toJson(),
  };
}

class MinimumPrice {
  String typename;
  RegularPrice regularPrice;

  MinimumPrice({
    required this.typename,
    required this.regularPrice,
  });

  factory MinimumPrice.fromJson(Map<String, dynamic> json) => MinimumPrice(
    typename: json["__typename"],
    regularPrice: RegularPrice.fromJson(json["regular_price"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "regular_price": regularPrice.toJson(),
  };
}

class RegularPrice {
  String typename;
  int value;
  String currency;

  RegularPrice({
    required this.typename,
    required this.value,
    required this.currency,
  });

  factory RegularPrice.fromJson(Map<String, dynamic> json) => RegularPrice(
    typename: json["__typename"],
    value: json["value"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "value": value,
    "currency": currency,
  };
}

class   SmallImage {
  String typename;
  String url;
  String label;

  SmallImage({
    required this.typename,
    required this.url,
    required this.label,
  });

  factory SmallImage.fromJson(Map<String, dynamic> json) => SmallImage(
    typename: json["__typename"],
    url: json["url"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "url": url,
    "label": label,
  };
}

class TextAttribute {
  String typename;
  String weight;
  String normalprice;
  dynamic specicalprice;

  TextAttribute({
    required this.typename,
    required this.weight,
    required this.normalprice,
    this.specicalprice,
  });

  factory TextAttribute.fromJson(Map<String, dynamic> json) => TextAttribute(
    typename: json["__typename"],
    weight: json["weight"],
    normalprice: json["normalprice"],
    specicalprice: json["specicalprice"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "weight": weight,
    "normalprice": normalprice,
    "specicalprice": specicalprice,
  };
}

class Variant {
  String typename;
  Product product;
  List<Attribute> attributes;

  Variant({
    required this.typename,
    required this.product,
    required this.attributes,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    typename: json["__typename"],
    product: Product.fromJson(json["product"]),
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "product": product.toJson(),
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
  };
}

class Attribute {
  String typename;
  String uid;
  String label;
  String code;
  int valueIndex;

  Attribute({
    required this.typename,
    required this.uid,
    required this.label,
    required this.code,
    required this.valueIndex,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    typename: json["__typename"],
    uid: json["uid"],
    label: json["label"],
    code: json["code"],
    valueIndex: json["value_index"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "uid": uid,
    "label": label,
    "code": code,
    "value_index": valueIndex,
  };
}

class Product {
  String typename;
  int id;
  String name;
  String sku;
  int attributeSetId;
  int weight;
  PriceRange priceRange;
  SmallImage smallImage;
  List<TextAttribute> textAttributes;
  List<GetPriceRange> getPriceRange;

  Product({
    required this.typename,
    required this.id,
    required this.name,
    required this.sku,
    required this.attributeSetId,
    required this.weight,
    required this.priceRange,
    required this.smallImage,
    required this.textAttributes,
    required this.getPriceRange,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    typename: json["__typename"],
    id: json["id"],
    name: json["name"],
    sku: json["sku"],
    attributeSetId: json["attribute_set_id"],
    weight: json["weight"]??0,
    priceRange: PriceRange.fromJson(json["price_range"] ?? ''),
    smallImage: SmallImage.fromJson(json["small_image"] ?? ''),
    textAttributes: json["textAttributes"]==null?[]:List<TextAttribute>.from(json["textAttributes"].map((x) => TextAttribute.fromJson(x))),
    getPriceRange: json["getPriceRange"]==null?[]:List<GetPriceRange>.from(json["getPriceRange"].map((x) => GetPriceRange.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "name": name,
    "sku": sku,
    "attribute_set_id": attributeSetId,
    "weight": weight,
    "price_range": priceRange.toJson(),
  };
}

class PageInfo {
  String typename;
  int pageSize;

  PageInfo({
    required this.typename,
    required this.pageSize,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    typename: json["__typename"],
    pageSize: json["page_size"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "page_size": pageSize,
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
