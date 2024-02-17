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
  String? typename;
  String? category;
  String? title;
  String? description;
  String? priority;
  String? skulist;
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
    typename: json["__typename"],
    category: json["category"],
    title: json["title"],
    description: json["description"],
    priority: json["priority"],
    skulist: json["skulist"],
    buttontext: json["buttontext"],
    link: json["link"],
    sectiondata: json["sectiondata"] == null ? [] : List<Sectiondatum>.from(json["sectiondata"]!.map((x) => Sectiondatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "category": category,
    "title": title,
    "description": description,
    "priority": priority,
    "skulist": skulist,
    "buttontext": buttontext,
    "link": link,
    "sectiondata": sectiondata == null ? [] : List<dynamic>.from(sectiondata!.map((x) => x.toJson())),
  };
}


class Sectiondatum {
  Typename? typename;
  String? title;
  String? description;
  String? priority;
  String? attachment;
  String? attachmentmob;
  String? buttontext;
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
    typename: typenameValues.map[json["__typename"]]!,
    title: json["title"],
    description: json["description"],
    priority: json["priority"],
    attachment: json["attachment"],
    attachmentmob: json["attachmentmob"],
    buttontext: json["buttontext"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "title": title,
    "description": description,
    "priority": priority,
    "attachment": attachment,
    "attachmentmob": attachmentmob,
    "buttontext": buttontext,
    "link": link,
  };
}

enum Typename {
  SECTIONDATA
}

final typenameValues = EnumValues({
  "sectiondata": Typename.SECTIONDATA
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
