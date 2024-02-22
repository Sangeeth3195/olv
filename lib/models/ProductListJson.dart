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
  Products products;

  Data({
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "products": products.toJson(),
  };
}

class Products {
  List<Aggregation> aggregations;
  List<Item> items;
  int totalCount;
  PageInfo pageInfo;

  Products({
    required this.aggregations,
    required this.items,
    required this.totalCount,
    required this.pageInfo,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    aggregations: List<Aggregation>.from(json["aggregations"].map((x) => Aggregation.fromJson(x))),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    totalCount: json["total_count"],
    pageInfo: PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "aggregations": List<dynamic>.from(aggregations.map((x) => x.toJson())),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "total_count": totalCount,
    "page_info": pageInfo.toJson(),
  };
}

class Aggregation {
  String attributeCode;
  int count;
  String label;
  List<Option> options;
  List<String> selected;

  Aggregation({
    required this.attributeCode,
    required this.count,
    required this.label,
    required this.options,
    required this.selected,

  });

  factory Aggregation.fromJson(Map<String, dynamic> json) => Aggregation(
    attributeCode: json["attribute_code"],
    count: json["count"],
    label: json["label"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      selected: []

  );

  Map<String, dynamic> toJson() => {
    "attribute_code": attributeCode,
    "count": count,
    "label": label,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
    "selected": selected,

  };
}

class Option {
  String label;
  String value;
  int count;
  OptionSwatchData? swatchData;

  Option({
    required this.label,
    required this.value,
    required this.count,
    required this.swatchData,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    label: json["label"],
    value: json["value"],
    count: json["count"],
    swatchData: json["swatch_data"] == null ? null : OptionSwatchData.fromJson(json["swatch_data"]),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
    "count": count,
    "swatch_data": swatchData?.toJson(),
  };
}

class OptionSwatchData {
  String value;
  String type;

  OptionSwatchData({
    required this.value,
    required this.type,
  });

  factory OptionSwatchData.fromJson(Map<String, dynamic> json) => OptionSwatchData(
    value: json["value"] ?? '',
    type: json["type"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "type": type,
  };
}

class Item {
  int id;
  String name;
  String typename;
  String sku;
  Price price;
  List<GetPriceRange>? getPriceRange;
  String specialFromDate;
  String specialToDate;
  List<TextAttribute> textAttributes;
  String brands;
  List<DynamicAttribute> dynamicAttributes;
  String urlKey;
  SmallImage smallImage;
  List<ConfigurableOption>? configurableOptions;
  List<Variant>? variants;
  bool wishlist=false;

  Item({
    required this.id,
    required this.name,
    required this.typename,
    required this.sku,
    required this.price,
    required this.getPriceRange,
    required this.specialFromDate,
    required this.specialToDate,
    required this.textAttributes,
    required this.brands,
    required this.dynamicAttributes,
    required this.urlKey,
    required this.smallImage,
    this.configurableOptions,
    this.variants,
    required this.wishlist,

  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    typename: json["__typename"],
    sku: json["sku"],
    price: Price.fromJson(json["price"]),
    getPriceRange: json["getPriceRange"] == null ? [] : List<GetPriceRange>.from(json["getPriceRange"]!.map((x) => GetPriceRange.fromJson(x))),
    specialFromDate:json["special_from_date"] ?? '',
    specialToDate:json["special_to_date"] ?? '',
    textAttributes: List<TextAttribute>.from(json["textAttributes"].map((x) => TextAttribute.fromJson(x))),
    brands: json["brands"] ?? '',
    dynamicAttributes: List<DynamicAttribute>.from(json["dynamicAttributes"].map((x) => DynamicAttribute.fromJson(x))),
    urlKey: json["url_key"],
    smallImage: SmallImage.fromJson(json["small_image"]),
    configurableOptions: json["configurable_options"] == null ? [] : List<ConfigurableOption>.from(json["configurable_options"]!.map((x) => ConfigurableOption.fromJson(x))),
    variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
    wishlist: json["is_wishlisted"]??false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "__typename": typename,
    "sku": sku,
    "price": price.toJson(),
    "getPriceRange": getPriceRange == null ? [] : List<dynamic>.from(getPriceRange!.map((x) => x.toJson())),
    "special_from_date": specialFromDate,
    "special_to_date": specialToDate,
    "textAttributes": List<dynamic>.from(textAttributes.map((x) => x.toJson())),
    "brands": brands,
    "dynamicAttributes": List<dynamic>.from(dynamicAttributes.map((x) => x.toJson())),
    "url_key": urlKey,
    "small_image": smallImage.toJson(),
    "configurable_options": configurableOptions == null ? [] : List<dynamic>.from(configurableOptions!.map((x) => x.toJson())),
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
  };
}

class ConfigurableOption {
  int id;
  String attributeId;
  String label;
  int position;
  bool useDefault;
  String attributeCode;
  List<Value> values;
  int productId;

  ConfigurableOption({
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
    id: json["id"],
    attributeId: json["attribute_id"],
    label: json["label"],
    position: json["position"],
    useDefault: json["use_default"],
    attributeCode: json["attribute_code"],
    values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
    productId: json["product_id"],
  );

  Map<String, dynamic> toJson() => {
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
  int valueIndex;
  String label;
  ValueSwatchData swatchData;

  Value({
    required this.valueIndex,
    required this.label,
    required this.swatchData,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    valueIndex: json["value_index"],
    label: json["label"],
    swatchData: ValueSwatchData.fromJson(json["swatch_data"]),
  );

  Map<String, dynamic> toJson() => {
    "value_index": valueIndex,
    "label": label,
    "swatch_data": swatchData.toJson(),
  };
}

class ValueSwatchData {
  String value;

  ValueSwatchData({
    required this.value,
  });

  factory ValueSwatchData.fromJson(Map<String, dynamic> json) => ValueSwatchData(
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
  };
}

class DynamicAttribute {
  String attributeCode;
  String attributeLabel;
  String attributeValue;

  DynamicAttribute({
    required this.attributeCode,
    required this.attributeLabel,
    required this.attributeValue,
  });

  factory DynamicAttribute.fromJson(Map<String, dynamic> json) => DynamicAttribute(
    attributeCode: json["attribute_code"],
    attributeLabel: json["attribute_label"],
    attributeValue: json["attribute_value"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_code": attributeCode,
    "attribute_label": attributeLabel,
    "attribute_value": attributeValue,
  };
}

class GetPriceRange {
  String oldpricevalue;
  String normalpricevalue;

  GetPriceRange({
    required this.oldpricevalue,
    required this.normalpricevalue,
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

class Price {
  RegularPrice regularPrice;

  Price({
    required this.regularPrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    regularPrice: RegularPrice.fromJson(json["regularPrice"]),
  );

  Map<String, dynamic> toJson() => {
    "regularPrice": regularPrice.toJson(),
  };
}

class RegularPrice {
  Amount amount;

  RegularPrice({
    required this.amount,
  });

  factory RegularPrice.fromJson(Map<String, dynamic> json) => RegularPrice(
    amount: Amount.fromJson(json["amount"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount.toJson(),
  };
}

class Amount {
  int value;
  String currency;

  Amount({
    required this.value,
    required this.currency,
  });

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
    value: json["value"],
    currency: json["currency"]!,
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "currency": currency,
  };
}



class SmallImage {
  String url;
  String label;

  SmallImage({
    required this.url,
    required this.label,
  });

  factory SmallImage.fromJson(Map<String, dynamic> json) => SmallImage(
    url: json["url"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
  };
}

class TextAttribute {
  String weight;
  String normalprice;
  String? specicalprice;

  TextAttribute({
    required this.weight,
    required this.normalprice,
    required this.specicalprice,
  });

  factory TextAttribute.fromJson(Map<String, dynamic> json) => TextAttribute(
    weight: json["weight"],
    normalprice: json["normalprice"],
    specicalprice: json["specicalprice"] ?? '0',
  );

  Map<String, dynamic> toJson() => {
    "weight": weight,
    "normalprice": normalprice,
    "specicalprice": specicalprice,
  };
}

class Variant {
  Product product;
  List<Attribute> attributes;

  Variant({
    required this.product,
    required this.attributes,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    product: Product.fromJson(json["product"]),
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
  };
}

class Attribute {
  String uid;
  String label;
  String code;
  int valueIndex;

  Attribute({
    required this.uid,
    required this.label,
    required this.code,
    required this.valueIndex,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    uid: json["uid"],
    label: json["label"],
    code: json["code"],
    valueIndex: json["value_index"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "label": label,
    "code": code,
    "value_index": valueIndex,
  };
}

class Product {
  int id;
  String name;
  String sku;
  int attributeSetId;
  int weight;
  List<MediaGallery> mediaGallery;
  PriceRange priceRange;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.attributeSetId,
    required this.weight,
    required this.mediaGallery,
    required this.priceRange,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    sku: json["sku"],
    attributeSetId: json["attribute_set_id"],
    weight: json["weight"],
    mediaGallery: List<MediaGallery>.from(json["media_gallery"].map((x) => MediaGallery.fromJson(x))),
    priceRange: PriceRange.fromJson(json["price_range"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sku": sku,
    "attribute_set_id": attributeSetId,
    "weight": weight,
    "media_gallery": List<dynamic>.from(mediaGallery.map((x) => x.toJson())),
    "price_range": priceRange.toJson(),
  };
}

class MediaGallery {
  String url;
  String label;
  int position;
  bool disabled;

  MediaGallery({
    required this.url,
    required this.label,
    required this.position,
    required this.disabled,
  });

  factory MediaGallery.fromJson(Map<String, dynamic> json) => MediaGallery(
    url: json["url"],
    label: json["label"] ?? '',
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

class PriceRange {
  MinimumPrice minimumPrice;

  PriceRange({
    required this.minimumPrice,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
    minimumPrice: MinimumPrice.fromJson(json["minimum_price"]),
  );

  Map<String, dynamic> toJson() => {
    "minimum_price": minimumPrice.toJson(),
  };
}

class MinimumPrice {
  Amount regularPrice;

  MinimumPrice({
    required this.regularPrice,
  });

  factory MinimumPrice.fromJson(Map<String, dynamic> json) => MinimumPrice(
    regularPrice: Amount.fromJson(json["regular_price"]),
  );

  Map<String, dynamic> toJson() => {
    "regular_price": regularPrice.toJson(),
  };
}

class PageInfo {
  int pageSize;

  PageInfo({
    required this.pageSize,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    pageSize: json["page_size"],
  );

  Map<String, dynamic> toJson() => {
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
