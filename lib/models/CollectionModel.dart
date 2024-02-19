import 'dart:convert';

CollectionModel collectionModelFromJson(String str) => CollectionModel.fromJson(json.decode(str));

String collectionModelToJson(CollectionModel data) => json.encode(data.toJson());

class CollectionModel {
  String? typename;
  List<GetCollectionSetDatum>? getCollectionSetData;

  CollectionModel({
    this.typename,
    this.getCollectionSetData,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) => CollectionModel(
    typename: json["__typename"],
    getCollectionSetData: json["getCollectionSetData"] == null ? [] : List<GetCollectionSetDatum>.from(json["getCollectionSetData"]!.map((x) => GetCollectionSetDatum.fromJson(x))),

    // getCollectionSetData: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "data": getCollectionSetData == null ? [] :List<dynamic>.from(getCollectionSetData!.map((x) => x.toJson())),
  };
}

class Data {
  List<GetCollectionSetDatum>? getCollectionSetData;

  Data({
    this.getCollectionSetData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    getCollectionSetData: json["getCollectionSetData"] == null ? [] : List<GetCollectionSetDatum>.from(json["getCollectionSetData"]!.map((x) => GetCollectionSetDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "getCollectionSetData": getCollectionSetData == null ? [] : List<dynamic>.from(getCollectionSetData!.map((x) => x.toJson())),
  };
}

class GetCollectionSetDatum {
  int? collectionSetId;
  String? name;
  int? status;
  List<Collection>? collections;

  GetCollectionSetDatum({
    this.collectionSetId,
    this.name,
    this.status,
    this.collections,
  });

  factory GetCollectionSetDatum.fromJson(Map<String, dynamic> json) => GetCollectionSetDatum(
    collectionSetId: json["collection_set_id"],
    name: json["name"],
    status: json["status"],
    collections: json["collections"] == null ? [] : List<Collection>.from(json["collections"]!.map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "collection_set_id": collectionSetId,
    "name": name,
    "status": status,
    "collections": collections == null ? [] : List<dynamic>.from(collections!.map((x) => x.toJson())),
  };
}

class Collection {
  int? collectionId;
  String? name;
  int? status;
  String? image;
  String? collectionSetImage;
  String? setImage;
  int? position;
  int? optionId;
  String? brandName;
  int? brandOptionId;

  Collection({
    this.collectionId,
    this.name,
    this.status,
    this.image,
    this.collectionSetImage,
    this.setImage,
    this.position,
    this.optionId,
    this.brandName,
    this.brandOptionId,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    collectionId: json["collection_id"] ?? 0,
    name: json["name"],
    status: json["status"],
    image: json["image"],
    collectionSetImage: json["collection_set_image"],
    setImage: json["set_image"],
    position: json["position"] ?? 0,
    optionId: json["option_id"],
    brandName: json["brand_name"] ?? '',
    brandOptionId: json["brand_option_id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "collection_id": collectionId,
    "name": name,
    "status": status,
    "image": image,
    "collection_set_image": collectionSetImage,
    "set_image": setImage,
    "position": position,
    "option_id": optionId,
    "brand_name": brandName,
    "brand_option_id": brandOptionId,
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