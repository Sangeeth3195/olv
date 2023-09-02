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
    customer: Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "customer": customer!.toJson(),
  };
}

class Customer {
  String? typename;
  String? firstname;
  String? lastname;
  dynamic? suffix;
  String? email;
  List<Address>? addresses;

  Customer({
    this.typename,
    this.firstname,
    this.lastname,
    this.suffix,
    this.email,
    this.addresses,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    typename: json["__typename"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    suffix: json["suffix"],
    email: json["email"],
    addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "firstname": firstname,
    "lastname": lastname,
    "suffix": suffix,
    "email": email,
    "addresses": List<dynamic>.from(addresses!.map((x) => x.toJson())),
  };
}

class Address {
  String? typename;
  int? id;
  String? firstname;
  String? lastname;
  List<String>? street;
  String? city;
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
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    typename: json["__typename"],
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    street: List<String>.from(json["street"].map((x) => x)),
    city: json["city"],
    region: Region.fromJson(json["region"]),
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
    "street": List<dynamic>.from(street!.map((x) => x)),
    "city": city,
    "region": region!.toJson(),
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
