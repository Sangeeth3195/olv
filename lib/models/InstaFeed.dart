// To parse this JSON data, do
//
//     final instafeedModel = instafeedModelFromJson(jsonString);

import 'dart:convert';

InstafeedModel instafeedModelFromJson(String str) => InstafeedModel.fromJson(json.decode(str));

String instafeedModelToJson(InstafeedModel data) => json.encode(data.toJson());

class InstafeedModel {
  List<Datum>? data;
  Paging? paging;

  InstafeedModel({
    this.data,
    this.paging,
  });

  factory InstafeedModel.fromJson(Map<String, dynamic> json) => InstafeedModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "paging": paging?.toJson(),
  };
}

class Datum {
  String? id;
  String? caption;
  MediaType? mediaType;
  String? mediaUrl;
  String? permalink;

  Datum({
    this.id,
    this.caption,
    this.mediaType,
    this.mediaUrl,
    this.permalink,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    caption: json["caption"],
    mediaType: mediaTypeValues.map[json["media_type"]]!,
    mediaUrl: json["media_url"],
    permalink: json["permalink"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "caption": caption,
    "media_type": mediaTypeValues.reverse[mediaType],
    "media_url": mediaUrl,
    "permalink": permalink,
  };
}

enum MediaType {
  CAROUSEL_ALBUM,
  IMAGE,
  VIDEO
}

final mediaTypeValues = EnumValues({
  "CAROUSEL_ALBUM": MediaType.CAROUSEL_ALBUM,
  "IMAGE": MediaType.IMAGE,
  "VIDEO": MediaType.VIDEO
});

class Paging {
  Cursors? cursors;
  String? next;

  Paging({
    this.cursors,
    this.next,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    cursors: json["cursors"] == null ? null : Cursors.fromJson(json["cursors"]),
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "cursors": cursors?.toJson(),
    "next": next,
  };
}

class Cursors {
  String? before;
  String? after;

  Cursors({
    this.before,
    this.after,
  });

  factory Cursors.fromJson(Map<String, dynamic> json) => Cursors(
    before: json["before"],
    after: json["after"],
  );

  Map<String, dynamic> toJson() => {
    "before": before,
    "after": after,
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
