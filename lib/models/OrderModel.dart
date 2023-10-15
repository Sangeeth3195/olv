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
  String? id;
  String? orderNumber;
  String? status;
  String? shippingMethod;
  List<PaymentMethod>? paymentMethods;
  IngAddress? shippingAddress;
  IngAddress? billingAddress;
  List<ItemItem>? items;
  DateTime? orderDate;
  Total? total;

  OrdersItem({
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
    id: json["id"],
    orderNumber: json["order_number"],
    status: json["status"]!,
    shippingMethod: json["shipping_method"],
    paymentMethods: json["payment_methods"] == null ? [] : List<PaymentMethod>.from(json["payment_methods"]!.map((x) => PaymentMethod.fromJson(x))),
    shippingAddress: json["shipping_address"] == null ? null : IngAddress.fromJson(json["shipping_address"]),
    billingAddress: json["billing_address"] == null ? null : IngAddress.fromJson(json["billing_address"]),
    items: json["items"] == null ? [] : List<ItemItem>.from(json["items"]!.map((x) => ItemItem.fromJson(x))),
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    total: json["total"] == null ? null : Total.fromJson(json["total"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_number": orderNumber,
    "status": statusValues.reverse[status],
    "shipping_method": shippingMethod,
    "payment_methods": paymentMethods == null ? [] : List<dynamic>.from(paymentMethods!.map((x) => x.toJson())),
    "shipping_address": shippingAddress?.toJson(),
    "billing_address": billingAddress?.toJson(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),

    "order_date": orderDate?.toIso8601String(),
    "total": total?.toJson(),
  };
}

class IngAddress {
  String? firstname;
  String? lastname;
  List<String>? street;
  String? city;
  String? telephone;
  String? region;
  String? postcode;

  IngAddress({
    this.firstname,
    this.lastname,
    this.street,
    this.city,
    this.telephone,
    this.region,
    this.postcode,
  });

  factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
    firstname: json["firstname"],
    lastname: json["lastname"]!,
    street: json['street'].cast<String>(),
    city: json["city"]!,
    telephone: json["telephone"],
    region:json["region"]!,
    postcode: json["postcode"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "street": street,
    "city": city,
    "telephone": telephone,
    "region": region,
    "postcode": postcode,
  };
}

class ItemItem {
  String? productName;
  String? productType;
  String? productSku;
  GrandTotal? productSalePrice;
  int? quantityOrdered;

  ItemItem({
    this.productName,
    this.productType,
    this.productSku,
    this.productSalePrice,
    this.quantityOrdered,
  });

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
    productName: json["product_name"],
    productType: json["product_type"]!,
    productSku: json["product_sku"],
    productSalePrice: json["product_sale_price"] == null ? null : GrandTotal.fromJson(json["product_sale_price"]),
    quantityOrdered: json["quantity_ordered"],
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "product_type": productType,
    "product_sku": productSku,
    "product_sale_price": productSalePrice?.toJson(),
    "quantity_ordered": quantityOrdered,
  };
}

class GrandTotal {
  double? value;
  String? currency;

  GrandTotal({
    this.value,
    this.currency,
  });

  factory GrandTotal.fromJson(Map<String, dynamic> json) => GrandTotal(

    value: json["value"]?.toDouble(),
    currency: json["currency"]!,
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "currency": currency,
  };
}

class PaymentMethod {
  String? name;

  PaymentMethod({
    this.name,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    name:json["name"]!,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

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
  List<Discounts>? discounts;
  GrandTotal? totalShipping;
  GrandTotal? subtotal;
  GrandTotal? grandTotal;

  Total({
    this.discounts,
    this.totalShipping,
    this.subtotal,
    this.grandTotal,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
    discounts: json["discounts"] == null ? [] : List<Discounts>.from(json["discounts"]!.map((x) => Discounts.fromJson(x))),
    totalShipping: json["total_shipping"] == null ? null : GrandTotal.fromJson(json["total_shipping"]),
    subtotal: json["subtotal"] == null ? null : GrandTotal.fromJson(json["subtotal"]),
    grandTotal: json["grand_total"] == null ? null : GrandTotal.fromJson(json["grand_total"]),
  );

  Map<String, dynamic> toJson() => {
    "discounts": discounts == null ? [] : List<dynamic>.from(discounts!.map((x) => x.toJson())),
    "total_shipping": totalShipping?.toJson(),
    "subtotal": subtotal?.toJson(),
    "grand_total": grandTotal?.toJson(),
  };
}

class Discounts {
  String? label;
  Amount? amount;

  Discounts({this.label, this.amount});

  Discounts.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    amount =
    json['amount'] != null ? Amount.fromJson(json['amount']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    if (amount != null) {
      data['amount'] = amount!.toJson();
    }
    return data;
  }
}

class Amount {
  double? value;

  Amount({this.value});

  Amount.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
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

