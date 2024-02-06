// To parse this JSON data, do
//
//     final instafeed = instafeedFromJson(jsonString);

import 'dart:convert';

Instafeed instafeedFromJson(String str) => Instafeed.fromJson(json.decode(str));

String instafeedToJson(Instafeed data) => json.encode(data.toJson());

class Instafeed {
  List<Datum> data;
  Paging paging;

  Instafeed({
    required this.data,
    required this.paging,
  });

  factory Instafeed.fromJson(Map<String, dynamic> json) => Instafeed(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    paging: Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "paging": paging.toJson(),
  };
}

class Datum {
  String id;
  String caption;
  MediaType mediaType;
  String mediaUrl;
  String permalink;

  Datum({
    required this.id,
    required this.caption,
    required this.mediaType,
    required this.mediaUrl,
    required this.permalink,
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
  Cursors cursors;
  String next;

  Paging({
    required this.cursors,
    required this.next,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    cursors: Cursors.fromJson(json["cursors"]),
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "cursors": cursors.toJson(),
    "next": next,
  };
}

class Cursors {
  String before;
  String after;

  Cursors({
    required this.before,
    required this.after,
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
