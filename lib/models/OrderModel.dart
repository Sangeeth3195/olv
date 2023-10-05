// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? typename;
  Customer? customer;

  OrderModel({
    this.typename,
    this.customer,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
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
  Orders? orders;

  Customer({
    this.typename,
    this.orders,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    typename: json["__typename"],
    orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "orders": orders?.toJson(),
  };
}

class Orders {
  String? typename;
  List<OrdersItem>? items;

  Orders({
    this.typename,
    this.items,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    typename: json["__typename"],
    items: json["items"] == null ? [] : List<OrdersItem>.from(json["items"]!.map((x) => OrdersItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class OrdersItem {
  PurpleTypename? typename;
  String? id;
  String? orderNumber;
  Status? status;
  ShippingMethod? shippingMethod;
  List<PaymentMethod>? paymentMethods;
  IngAddress? shippingAddress;
  IngAddress? billingAddress;
  List<ItemItem>? items;
  DateTime? orderDate;
  Total? total;

  OrdersItem({
    this.typename,
    this.id,
    this.orderNumber,
    this.status,
    this.shippingMethod,
    this.paymentMethods,
    this.shippingAddress,
    this.billingAddress,
    this.items,
    this.orderDate,
    this.total,
  });

  factory OrdersItem.fromJson(Map<String, dynamic> json) => OrdersItem(
    typename: purpleTypenameValues.map[json["__typename"]]!,
    id: json["id"],
    orderNumber: json["order_number"],
    status: statusValues.map[json["status"]]!,
    shippingMethod: shippingMethodValues.map[json["shipping_method"]]!,
    paymentMethods: json["payment_methods"] == null ? [] : List<PaymentMethod>.from(json["payment_methods"]!.map((x) => PaymentMethod.fromJson(x))),
    shippingAddress: json["shipping_address"] == null ? null : IngAddress.fromJson(json["shipping_address"]),
    billingAddress: json["billing_address"] == null ? null : IngAddress.fromJson(json["billing_address"]),
    items: json["items"] == null ? [] : List<ItemItem>.from(json["items"]!.map((x) => ItemItem.fromJson(x))),
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    total: json["total"] == null ? null : Total.fromJson(json["total"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": purpleTypenameValues.reverse[typename],
    "id": id,
    "order_number": orderNumber,
    "status": statusValues.reverse[status],
    "shipping_method": shippingMethodValues.reverse[shippingMethod],
    "payment_methods": paymentMethods == null ? [] : List<dynamic>.from(paymentMethods!.map((x) => x.toJson())),
    "shipping_address": shippingAddress?.toJson(),
    "billing_address": billingAddress?.toJson(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "order_date": orderDate?.toIso8601String(),
    "total": total?.toJson(),
  };
}

class IngAddress {
  BillingAddressTypename? typename;
  Firstname? firstname;
  Lastname? lastname;
  List<Street>? street;
  City? city;
  String? telephone;
  Region? region;
  String? postcode;

  IngAddress({
    this.typename,
    this.firstname,
    this.lastname,
    this.street,
    this.city,
    this.telephone,
    this.region,
    this.postcode,
  });

  factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
    typename: billingAddressTypenameValues.map[json["__typename"]]!,
    firstname: firstnameValues.map[json["firstname"]]!,
    lastname: lastnameValues.map[json["lastname"]]!,
    street: json["street"] == null ? [] : List<Street>.from(json["street"]!.map((x) => streetValues.map[x]!)),
    city: cityValues.map[json["city"]]!,
    telephone: json["telephone"],
    region: regionValues.map[json["region"]]!,
    postcode: json["postcode"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": billingAddressTypenameValues.reverse[typename],
    "firstname": firstnameValues.reverse[firstname],
    "lastname": lastnameValues.reverse[lastname],
    "street": street == null ? [] : List<dynamic>.from(street!.map((x) => streetValues.reverse[x])),
    "city": cityValues.reverse[city],
    "telephone": telephone,
    "region": regionValues.reverse[region],
    "postcode": postcode,
  };
}

enum City {
  BLB,
  CHENNAI
}

final cityValues = EnumValues({
  "BLB": City.BLB,
  "Chennai": City.CHENNAI
});

enum Firstname {
  MOHAMED_MAIDEEN
}

final firstnameValues = EnumValues({
  "Mohamed Maideen": Firstname.MOHAMED_MAIDEEN
});

enum Lastname {
  I
}

final lastnameValues = EnumValues({
  "I": Lastname.I
});

enum Region {
  TAMIL_NADU
}

final regionValues = EnumValues({
  "Tamil Nadu": Region.TAMIL_NADU
});

enum Street {
  BLB,
  STREET_SYED_AHAMED_STREET,
  SYED_AHAMED_STREET,
  SYED_AHAMED_STREET_1
}

final streetValues = EnumValues({
  "BLB": Street.BLB,
  "[Syed Ahamed Street]": Street.STREET_SYED_AHAMED_STREET,
  "Syed Ahamed Street": Street.SYED_AHAMED_STREET,
  "Syed Ahamed Street-1": Street.SYED_AHAMED_STREET_1
});

enum BillingAddressTypename {
  ORDER_ADDRESS
}

final billingAddressTypenameValues = EnumValues({
  "OrderAddress": BillingAddressTypename.ORDER_ADDRESS
});

class ItemItem {
  FluffyTypename? typename;
  String? productName;
  ProductType? productType;
  String? productSku;
  GrandTotal? productSalePrice;
  int? quantityOrdered;

  ItemItem({
    this.typename,
    this.productName,
    this.productType,
    this.productSku,
    this.productSalePrice,
    this.quantityOrdered,
  });

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
    typename: fluffyTypenameValues.map[json["__typename"]]!,
    productName: json["product_name"],
    productType: productTypeValues.map[json["product_type"]]!,
    productSku: json["product_sku"],
    productSalePrice: json["product_sale_price"] == null ? null : GrandTotal.fromJson(json["product_sale_price"]),
    quantityOrdered: json["quantity_ordered"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": fluffyTypenameValues.reverse[typename],
    "product_name": productName,
    "product_type": productTypeValues.reverse[productType],
    "product_sku": productSku,
    "product_sale_price": productSalePrice?.toJson(),
    "quantity_ordered": quantityOrdered,
  };
}

class GrandTotal {
  GrandTotalTypename? typename;
  double? value;
  Currency? currency;

  GrandTotal({
    this.typename,
    this.value,
    this.currency,
  });

  factory GrandTotal.fromJson(Map<String, dynamic> json) => GrandTotal(
    typename: grandTotalTypenameValues.map[json["__typename"]]!,
    value: json["value"]?.toDouble(),
    currency: currencyValues.map[json["currency"]]!,
  );

  Map<String, dynamic> toJson() => {
    "__typename": grandTotalTypenameValues.reverse[typename],
    "value": value,
    "currency": currencyValues.reverse[currency],
  };
}

enum Currency {
  INR
}

final currencyValues = EnumValues({
  "INR": Currency.INR
});

enum GrandTotalTypename {
  MONEY
}

final grandTotalTypenameValues = EnumValues({
  "Money": GrandTotalTypename.MONEY
});

enum ProductType {
  CONFIGURABLE,
  SIMPLE
}

final productTypeValues = EnumValues({
  "configurable": ProductType.CONFIGURABLE,
  "simple": ProductType.SIMPLE
});

enum FluffyTypename {
  ORDER_ITEM
}

final fluffyTypenameValues = EnumValues({
  "OrderItem": FluffyTypename.ORDER_ITEM
});

class PaymentMethod {
  PaymentMethodTypename? typename;
  Name? name;

  PaymentMethod({
    this.typename,
    this.name,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    typename: paymentMethodTypenameValues.map[json["__typename"]]!,
    name: nameValues.map[json["name"]]!,
  );

  Map<String, dynamic> toJson() => {
    "__typename": paymentMethodTypenameValues.reverse[typename],
    "name": nameValues.reverse[name],
  };
}

enum Name {
  CASH_ON_DELIVERY,
  RAZORPAY
}

final nameValues = EnumValues({
  "Cash On Delivery": Name.CASH_ON_DELIVERY,
  "Razorpay": Name.RAZORPAY
});

enum PaymentMethodTypename {
  ORDER_PAYMENT_METHOD
}

final paymentMethodTypenameValues = EnumValues({
  "OrderPaymentMethod": PaymentMethodTypename.ORDER_PAYMENT_METHOD
});

enum ShippingMethod {
  FREE_SHIPPING,
  OMA_SHIPPING_STANDARD_SHIPPING,
  STANDARD_SHIPPING
}

final shippingMethodValues = EnumValues({
  "Free Shipping": ShippingMethod.FREE_SHIPPING,
  "OMA Shipping - Standard Shipping": ShippingMethod.OMA_SHIPPING_STANDARD_SHIPPING,
  "Standard Shipping": ShippingMethod.STANDARD_SHIPPING
});

enum Status {
  CANCELED,
  COMPLETE,
  EMPTY,
  PENDING,
  PROCESSING,
  SHIPPED
}

final statusValues = EnumValues({
  "Canceled": Status.CANCELED,
  "Complete": Status.COMPLETE,
  "": Status.EMPTY,
  "Pending": Status.PENDING,
  "Processing": Status.PROCESSING,
  "Shipped": Status.SHIPPED
});

class Total {
  TotalTypename? typename;
  GrandTotal? totalShipping;
  GrandTotal? subtotal;
  GrandTotal? grandTotal;

  Total({
    this.typename,
    this.totalShipping,
    this.subtotal,
    this.grandTotal,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
    typename: totalTypenameValues.map[json["__typename"]]!,
    totalShipping: json["total_shipping"] == null ? null : GrandTotal.fromJson(json["total_shipping"]),
    subtotal: json["subtotal"] == null ? null : GrandTotal.fromJson(json["subtotal"]),
    grandTotal: json["grand_total"] == null ? null : GrandTotal.fromJson(json["grand_total"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": totalTypenameValues.reverse[typename],
    "total_shipping": totalShipping?.toJson(),
    "subtotal": subtotal?.toJson(),
    "grand_total": grandTotal?.toJson(),
  };
}

enum TotalTypename {
  ORDER_TOTAL
}

final totalTypenameValues = EnumValues({
  "OrderTotal": TotalTypename.ORDER_TOTAL
});

enum PurpleTypename {
  CUSTOMER_ORDER
}

final purpleTypenameValues = EnumValues({
  "CustomerOrder": PurpleTypename.CUSTOMER_ORDER
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
