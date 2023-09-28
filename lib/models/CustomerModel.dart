// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  String? typename;
  Customer? customer;

  CustomerModel({
    this.typename,
    this.customer,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    typename: json["__typename"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "customer": customer?.toJson(),
  };
}

class Customer {
  String? typename;
  String? firstname;
  bool? issubscribed;
  String? lastname;
  dynamic suffix;
  String? email;
  List<WishlistElement>? wishlists;
  List<Address>? addresses;
  PurpleWishlist? wishlist;

  Customer({
    this.typename,
    this.firstname,
    this.issubscribed,
    this.lastname,
    this.suffix,
    this.email,
    this.wishlists,
    this.addresses,
    this.wishlist,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    typename: json["__typename"],
    firstname: json["firstname"],
    issubscribed: json["is_subscribed"],
    lastname: json["lastname"],
    suffix: json["suffix"],
    email: json["email"],
    wishlists: json["wishlists"] == null ? [] : List<WishlistElement>.from(json["wishlists"]!.map((x) => WishlistElement.fromJson(x))),
    addresses: json["addresses"] == null ? [] : List<Address>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
    wishlist: json["wishlist"] == null ? null : PurpleWishlist.fromJson(json["wishlist"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "firstname": firstname,
    "issubscribed": issubscribed,
    "lastname": lastname,
    "suffix": suffix,
    "email": email,
    "wishlists": wishlists == null ? [] : List<dynamic>.from(wishlists!.map((x) => x.toJson())),
    "addresses": addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x.toJson())),
    "wishlist": wishlist?.toJson(),
  };
}

class Address {
  String? typename;
  int? id;
  String? firstname;
  String? lastname;
  List<String>? street;
  String? city;
  int? regionId;
  Region? region;
  String? postcode;
  String? countryCode;
  String? telephone;
  bool? defaultShipping;
  bool? defaultBilling;

  Address({
    this.typename,
    this.id,
    this.firstname,
    this.lastname,
    this.street,
    this.city,
    this.region,
    this.postcode,
    this.countryCode,
    this.telephone,
    this.defaultShipping,
    this.defaultBilling,
    this.regionId,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    typename: json["__typename"],
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    street: json["street"] == null ? [] : List<String>.from(json["street"]!.map((x) => x)),
    city: json["city"],
    regionId: json["region_id"],
    region: json["region"] == null ? null : Region.fromJson(json["region"]),
    postcode: json["postcode"],
    countryCode: json["country_code"],
    telephone: json["telephone"],
    defaultShipping: json["default_shipping"],
    defaultBilling: json["default_billing"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "street": street == null ? [] : List<dynamic>.from(street!.map((x) => x)),
    "city": city,
    "regionId": regionId,
    "region": region?.toJson(),
    "postcode": postcode,
    "country_code": countryCode,
    "telephone": telephone,
    "default_shipping": defaultShipping,
    "default_billing": defaultBilling,
  };
}

class Region {
  String? typename;
  String? regionCode;
  String? region;

  Region({
    this.typename,
    this.regionCode,
    this.region,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    typename: json["__typename"],
    regionCode: json["region_code"],
    region: json["region"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "region_code": regionCode,
    "region": region,
  };
}

class PurpleWishlist {
  String? typename;
  int? itemsCount;
  String? sharingCode;
  DateTime? updatedAt;
  List<ItemWishList>? items;

  PurpleWishlist({
    this.typename,
    this.itemsCount,
    this.sharingCode,
    this.updatedAt,
    this.items,
  });

  factory PurpleWishlist.fromJson(Map<String, dynamic> json) => PurpleWishlist(
    typename: json["__typename"],
    itemsCount: json["items_count"],
    sharingCode: json["sharing_code"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    items: json["items"] == null ? [] : List<ItemWishList>.from(json["items"]!.map((x) => ItemWishList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "items_count": itemsCount,
    "sharing_code": sharingCode,
    "updated_at": updatedAt?.toIso8601String(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class ItemWishList {
  String? typename;
  int? id;
  int? qty;
  dynamic description;
  DateTime? addedAt;
  Product? product;

  ItemWishList({
    this.typename,
    this.id,
    this.qty,
    this.description,
    this.addedAt,
    this.product,
  });

  factory ItemWishList.fromJson(Map<String, dynamic> json) => ItemWishList(
    typename: json["__typename"],
    id: json["id"],
    qty: json["qty"],
    description: json["description"],
    addedAt: json["added_at"] == null ? null : DateTime.parse(json["added_at"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "qty": qty,
    "description": description,
    "added_at": addedAt?.toIso8601String(),
    "product": product?.toJson(),
  };
}

class Product {
  String? typename;
  String? sku;
  String? name;
  List<ConfigurableOption>? configurableOptions;
  List<MediaGallery>? mediaGallery;
  PriceRange? priceRange;

  Product({
    this.typename,
    this.sku,
    this.name,
    this.configurableOptions,
    this.mediaGallery,
    this.priceRange,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    typename: json["__typename"],
    sku: json["sku"],
    name: json["name"],
    configurableOptions: json["configurable_options"] == null ? [] : List<ConfigurableOption>.from(json["configurable_options"]!.map((x) => ConfigurableOption.fromJson(x))),
    mediaGallery: json["media_gallery"] == null ? [] : List<MediaGallery>.from(json["media_gallery"]!.map((x) => MediaGallery.fromJson(x))),
    priceRange: json["price_range"] == null ? null : PriceRange.fromJson(json["price_range"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "sku": sku,
    "name": name,
    "configurable_options": configurableOptions == null ? [] : List<dynamic>.from(configurableOptions!.map((x) => x.toJson())),
    "media_gallery": mediaGallery == null ? [] : List<dynamic>.from(mediaGallery!.map((x) => x.toJson())),
    "price_range": priceRange?.toJson(),
  };
}

class ConfigurableOption {
  int? id;
  int? attributeIdV2;
  String? attributeCode;
  String? label;
  String? typename;
  bool? useDefault;
  List<Value>? values;

  ConfigurableOption({
    this.id,
    this.attributeIdV2,
    this.attributeCode,
    this.label,
    this.typename,
    this.useDefault,
    this.values,
  });

  factory ConfigurableOption.fromJson(Map<String, dynamic> json) => ConfigurableOption(
    id: json["id"],
    attributeIdV2: json["attribute_id_v2"],
    attributeCode: json["attribute_code"],
    label: json["label"],
    typename: json["__typename"],
    useDefault: json["use_default"],
    values: json["values"] == null ? [] : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attribute_id_v2": attributeIdV2,
    "attribute_code": attributeCode,
    "label": label,
    "__typename": typename,
    "use_default": useDefault,
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
  };
}

class Value {
  ValueTypename? typename;
  String? storeLabel;
  SwatchData? swatchData;
  bool? useDefaultValue;

  Value({
    this.typename,
    this.storeLabel,
    this.swatchData,
    this.useDefaultValue,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    typename: valueTypenameValues.map[json["__typename"]]!,
    storeLabel: json["store_label"],
    swatchData: json["swatch_data"] == null ? null : SwatchData.fromJson(json["swatch_data"]),
    useDefaultValue: json["use_default_value"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": valueTypenameValues.reverse[typename],
    "store_label": storeLabel,
    "swatch_data": swatchData?.toJson(),
    "use_default_value": useDefaultValue,
  };
}

class SwatchData {
  SwatchDataTypename? typename;
  String? value;

  SwatchData({
    this.typename,
    this.value,
  });

  factory SwatchData.fromJson(Map<String, dynamic> json) => SwatchData(
    typename: swatchDataTypenameValues.map[json["__typename"]]!,
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": swatchDataTypenameValues.reverse[typename],
    "value": value,
  };
}

enum SwatchDataTypename {
  COLOR_SWATCH_DATA,
  TEXT_SWATCH_DATA
}

final swatchDataTypenameValues = EnumValues({
  "ColorSwatchData": SwatchDataTypename.COLOR_SWATCH_DATA,
  "TextSwatchData": SwatchDataTypename.TEXT_SWATCH_DATA
});

enum ValueTypename {
  CONFIGURABLE_PRODUCT_OPTIONS_VALUES
}

final valueTypenameValues = EnumValues({
  "ConfigurableProductOptionsValues": ValueTypename.CONFIGURABLE_PRODUCT_OPTIONS_VALUES
});

class MediaGallery {
  MediaGalleryTypename? typename;
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
    typename: mediaGalleryTypenameValues.map[json["__typename"]]!,
    url: json["url"],
    label: json["label"],
    position: json["position"],
    disabled: json["disabled"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": mediaGalleryTypenameValues.reverse[typename],
    "url": url,
    "label": label,
    "position": position,
    "disabled": disabled,
  };
}

enum MediaGalleryTypename {
  PRODUCT_IMAGE
}

final mediaGalleryTypenameValues = EnumValues({
  "ProductImage": MediaGalleryTypename.PRODUCT_IMAGE
});

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
  RegularPrice? regularPrice;

  MinimumPrice({
    this.typename,
    this.regularPrice,
  });

  factory MinimumPrice.fromJson(Map<String, dynamic> json) => MinimumPrice(
    typename: json["__typename"],
    regularPrice: json["regular_price"] == null ? null : RegularPrice.fromJson(json["regular_price"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "regular_price": regularPrice?.toJson(),
  };
}

class RegularPrice {
  String? typename;
  int? value;
  String? currency;

  RegularPrice({
    this.typename,
    this.value,
    this.currency,
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

class WishlistElement {
  String? typename;
  String? id;

  WishlistElement({
    this.typename,
    this.id,
  });

  factory WishlistElement.fromJson(Map<String, dynamic> json) => WishlistElement(
    typename: json["__typename"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
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
