
import 'dart:convert';

OrdersModel customerModelFromJson(String str) => OrdersModel.fromJson(json.decode(str));

String customerModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  String? typename;
  Data? data;

  OrdersModel({
    this.typename,this.data});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Customer? customer;

  Data({this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  Orders? orders;

  Customer({this.orders});

  Customer.fromJson(Map<String, dynamic> json) {
    orders =
    json['orders'] != null ? Orders.fromJson(json['orders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.toJson();
    }
    return data;
  }
}

class Orders {
  List<Items>? items;

  Orders({this.items});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? orderNumber;
  String? status;
  String? shippingMethod;
  List<PaymentMethods>? paymentMethods;
  ShippingAddress? shippingAddress;
  ShippingAddress? billingAddress;
  List<Items>? items;
  String? orderDate;
  Total? total;

  Items(
      {this.id,
        this.orderNumber,
        this.status,
        this.shippingMethod,
        this.paymentMethods,
        this.shippingAddress,
        this.billingAddress,
        this.items,
        this.orderDate,
        this.total});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    status = json['status'];
    shippingMethod = json['shipping_method'];
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(PaymentMethods.fromJson(v));
      });
    }
    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
    billingAddress = json['billing_address'] != null
        ? ShippingAddress.fromJson(json['billing_address'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    orderDate = json['order_date'];
    total = json['total'] != null ? Total.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['status'] = status;
    data['shipping_method'] = shippingMethod;
    if (paymentMethods != null) {
      data['payment_methods'] =
          paymentMethods!.map((v) => v.toJson()).toList();
    }
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress!.toJson();
    }
    if (billingAddress != null) {
      data['billing_address'] = billingAddress!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['order_date'] = orderDate;
    if (total != null) {
      data['total'] = total!.toJson();
    }
    return data;
  }
}

class PaymentMethods {
  String? name;

  PaymentMethods({this.name});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class ShippingAddress {
  String? firstname;
  String? lastname;
  List<String>? street;
  String? city;
  String? telephone;
  String? region;
  String? postcode;

  ShippingAddress(
      {this.firstname,
        this.lastname,
        this.street,
        this.city,
        this.telephone,
        this.region,
        this.postcode});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    street = json['street'].cast<String>();
    city = json['city'];
    telephone = json['telephone'];
    region = json['region'];
    postcode = json['postcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['street'] = street;
    data['city'] = city;
    data['telephone'] = telephone;
    data['region'] = region;
    data['postcode'] = postcode;
    return data;
  }
}


class ProductSalePrice {
  int? value;
  String? currency;

  ProductSalePrice({this.value, this.currency});

  ProductSalePrice.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['currency'] = currency;
    return data;
  }
}

class Total {
  ProductSalePrice? totalShipping;
  ProductSalePrice? subtotal;
  ProductSalePrice? grandTotal;

  Total({this.totalShipping, this.subtotal, this.grandTotal});

  Total.fromJson(Map<String, dynamic> json) {
    totalShipping = json['total_shipping'] != null
        ? ProductSalePrice.fromJson(json['total_shipping'])
        : null;
    subtotal = json['subtotal'] != null
        ? ProductSalePrice.fromJson(json['subtotal'])
        : null;
    grandTotal = json['grand_total'] != null
        ? ProductSalePrice.fromJson(json['grand_total'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (totalShipping != null) {
      data['total_shipping'] = totalShipping!.toJson();
    }
    if (subtotal != null) {
      data['subtotal'] = subtotal!.toJson();
    }
    if (grandTotal != null) {
      data['grand_total'] = grandTotal!.toJson();
    }
    return data;
  }
}
