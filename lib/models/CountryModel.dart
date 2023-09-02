// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  String? typename;
  List<Country>? countries;

  CountryModel({
    this.typename,
    this.countries,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    typename: json["__typename"],
    countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "countries": List<dynamic>.from(countries!.map((x) => x.toJson())),
  };
}

class Country {
  String? typename;
  String? id;
  String? twoLetterAbbreviation;
  String? threeLetterAbbreviation;
  String? fullNameLocale;
  String? fullNameEnglish;
  List<AvailableRegion>? availableRegions;

  Country({
    this.typename,
    this.id,
    this.twoLetterAbbreviation,
    this.threeLetterAbbreviation,
    this.fullNameLocale,
    this.fullNameEnglish,
    this.availableRegions,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    typename: json["__typename"],
    id: json["id"],
    twoLetterAbbreviation: json["two_letter_abbreviation"],
    threeLetterAbbreviation: json["three_letter_abbreviation"],
    fullNameLocale: json["full_name_locale"],
    fullNameEnglish: json["full_name_english"],
    availableRegions: List<AvailableRegion>.from(json["available_regions"].map((x) => AvailableRegion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "two_letter_abbreviation": twoLetterAbbreviation,
    "three_letter_abbreviation": threeLetterAbbreviation,
    "full_name_locale": fullNameLocale,
    "full_name_english": fullNameEnglish,
    "available_regions": List<dynamic>.from(availableRegions!.map((x) => x.toJson())),
  };
}

class AvailableRegion {
  Typename? typename;
  int? id;
  String? code;
  String? name;

  AvailableRegion({
    this.typename,
    this.id,
    this.code,
    this.name,
  });

  factory AvailableRegion.fromJson(Map<String, dynamic> json) => AvailableRegion(
    typename: typenameValues.map[json["__typename"]],
    id: json["id"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "id": id,
    "code": code,
    "name": name,
  };
}

enum Typename {
  REGION
}

final typenameValues = EnumValues({
  "Region": Typename.REGION
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
