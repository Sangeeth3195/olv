// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  String? typename;
  List<GetHomePageDatum>? getHomePageData;

  HomePageModel({
    this.typename,
    this.getHomePageData,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
    typename: json["__typename"],
    getHomePageData: json["getHomePageData"] == null ? [] : List<GetHomePageDatum>.from(json["getHomePageData"]!.map((x) => GetHomePageDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "getHomePageData": getHomePageData == null ? [] : List<dynamic>.from(getHomePageData!.map((x) => x.toJson())),
  };
}

class GetHomePageDatum {
  GetHomePageDatumTypename? typename;
  String? category;
  String? title;
  String? description;
  String? priority;
  Skulist? skulist;
  String? buttontext;
  String? link;
  List<Sectiondatum>? sectiondata;

  GetHomePageDatum({
    this.typename,
    this.category,
    this.title,
    this.description,
    this.priority,
    this.skulist,
    this.buttontext,
    this.link,
    this.sectiondata,
  });

  factory GetHomePageDatum.fromJson(Map<String, dynamic> json) => GetHomePageDatum(
    typename: getHomePageDatumTypenameValues.map[json["__typename"]]!,
    category: json["category"],
    title: json["title"],
    description: json["description"],
    priority: json["priority"],
    skulist: skulistValues.map[json["skulist"]]!,
    buttontext: json["buttontext"],
    link: json["link"],
    sectiondata: json["sectiondata"] == null ? [] : List<Sectiondatum>.from(json["sectiondata"]!.map((x) => Sectiondatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": getHomePageDatumTypenameValues.reverse[typename],
    "category": category,
    "title": title,
    "description": description,
    "priority": priority,
    "skulist": skulistValues.reverse[skulist],
    "buttontext": buttontext,
    "link": link,
    "sectiondata": sectiondata == null ? [] : List<dynamic>.from(sectiondata!.map((x) => x.toJson())),
  };
}

class Sectiondatum {
  SectiondatumTypename? typename;
  String? title;
  String? description;
  String? priority;
  String? attachment;
  String? attachmentmob;
  Buttontext? buttontext;
  String? link;

  Sectiondatum({
    this.typename,
    this.title,
    this.description,
    this.priority,
    this.attachment,
    this.attachmentmob,
    this.buttontext,
    this.link,
  });

  factory Sectiondatum.fromJson(Map<String, dynamic> json) => Sectiondatum(
    typename: sectiondatumTypenameValues.map[json["__typename"]]!,
    title: json["title"],
    description: json["description"],
    priority: json["priority"],
    attachment: json["attachment"],
    attachmentmob: json["attachmentmob"],
    buttontext: buttontextValues.map[json["buttontext"]]!,
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": sectiondatumTypenameValues.reverse[typename],
    "title": title,
    "description": description,
    "priority": priority,
    "attachment": attachment,
    "attachmentmob": attachmentmob,
    "buttontext": buttontextValues.reverse[buttontext],
    "link": link,
  };
}

enum Buttontext {
  DISCOVER_DECOR,
  DISCOVER_TABLE_TOP,
  EMPTY,
  EXPLORE_KITCHENWARE
}

final buttontextValues = EnumValues({
  "DISCOVER DECOR": Buttontext.DISCOVER_DECOR,
  "DISCOVER TABLE TOP": Buttontext.DISCOVER_TABLE_TOP,
  "": Buttontext.EMPTY,
  "EXPLORE KITCHENWARE": Buttontext.EXPLORE_KITCHENWARE
});

enum SectiondatumTypename {
  SECTIONDATA
}

final sectiondatumTypenameValues = EnumValues({
  "sectiondata": SectiondatumTypename.SECTIONDATA
});

enum Skulist {
  EMPTY,
  RI003874_RI002856_RI000444_RI004330
}

final skulistValues = EnumValues({
  "": Skulist.EMPTY,
  "ri003874,ri002856,ri000444,ri004330": Skulist.RI003874_RI002856_RI000444_RI004330
});

enum GetHomePageDatumTypename {
  HOMEPAGEDATA
}

final getHomePageDatumTypenameValues = EnumValues({
  "homepagedata": GetHomePageDatumTypename.HOMEPAGEDATA
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
