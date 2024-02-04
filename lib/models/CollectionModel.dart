class Collectionmodel {
  Collectionmodel({
    required this.data,
  });

  final Data? data;

  factory Collectionmodel.fromJson(Map<String, dynamic> json){
    return Collectionmodel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.getCollectionSetData,
  });

  final List<GetCollectionSetDatum> getCollectionSetData;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      getCollectionSetData: json["getCollectionSetData"] == null ? [] : List<GetCollectionSetDatum>.from(json["getCollectionSetData"]!.map((x) => GetCollectionSetDatum.fromJson(x))),
    );
  }

}

class GetCollectionSetDatum {
  GetCollectionSetDatum({
    required this.collectionSetId,
    required this.name,
    required this.status,
    required this.image,
    required this.collections,
  });

  final int? collectionSetId;
  final String? name;
  final int? status;
  final dynamic image;
  final List<Collection> collections;

  factory GetCollectionSetDatum.fromJson(Map<String, dynamic> json){
    return GetCollectionSetDatum(
      collectionSetId: json["collection_set_id"],
      name: json["name"],
      status: json["status"],
      image: json["image"],
      collections: json["collections"] == null ? [] : List<Collection>.from(json["collections"]!.map((x) => Collection.fromJson(x))),
    );
  }
}

class Collection {
  Collection({
    required this.collectionId,
    required this.name,
    required this.status,
    required this.image,
    required this.collectionSetImage,
    required this.setImage,
    required this.position,
    required this.optionId,
    required this.brandName,
    required this.brandOptionId,
  });

  final int? collectionId;
  final String? name;
  final int? status;
  final String? image;
  final String? collectionSetImage;
  final String? setImage;
  final int? position;
  final int? optionId;
  final String? brandName;
  final int? brandOptionId;

  factory Collection.fromJson(Map<String, dynamic> json){
    return Collection(
      collectionId: json["collection_id"],
      name: json["name"],
      status: json["status"],
      image: json["image"],
      collectionSetImage: json["collection_set_image"],
      setImage: json["set_image"],
      position: json["position"],
      optionId: json["option_id"],
      brandName: json["brand_name"],
      brandOptionId: json["brand_option_id"],
    );
  }

}
