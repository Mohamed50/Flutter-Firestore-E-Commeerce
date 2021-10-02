// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_example/data/model/product.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.total,
    this.address,
    this.user,
    this.products,
  });

  double? total;
  Address? address;
  String? user;
  List<ProductElement>? products;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    total: json["total"] == null ? null : double.parse(json["total"].toString()),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    user: json["user"] == null ? null : json["user"],
    products: json["products"] == null ? null : List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "address": address == null ? null : address!.toJson(),
    "user": user == null ? null : user,
    "products": products == null ? null : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.city,
    this.street,
    this.country,
    this.state,
  });

  String? city;
  String? street;
  String? country;
  String? state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json["city"] == null ? null : json["city"],
    street: json["street"] == null ? null : json["street"],
    country: json["Country"] == null ? null : json["Country"],
    state: json["state"] == null ? null : json["state"],
  );

  Map<String, dynamic> toJson() => {
    "city": city == null ? null : city,
    "street": street == null ? null : street,
    "Country": country == null ? null : country,
    "state": state == null ? null : state,
  };
}

class ProductElement {
  ProductElement({
    this.product,
    this.quantity,
    this.size,
  });

  ProductModel? product;
  int? quantity;
  String? size;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    product: json["product"] == null ? null : ProductModel.fromMap(json["product"]),
    quantity: json["quantity"] == null ? null : json["quantity"],
    size: json["size"] == null ? null : json["size"],
  );

  Map<String, dynamic> toJson() => {
    "product": product == null ? null : FirebaseFirestore.instance.collection("Products").doc(product!.id),
    "quantity": quantity == null ? null : quantity,
    "size": size == null ? null : size,
  };
}
