import 'package:flutter/material.dart';
import 'package:getx_example/utils/color-extension.dart';

class CartProductModel{

  int? id;
  String? productId, name, imageUrl, size;
  double price = 0.0;
  int quantity = 1;
  Color? color;

  CartProductModel(this.id, this.name, this.imageUrl);

  CartProductModel.fromMap(Map json){
    id = json["id"];
    productId = json["product_id"];
    name = json["name"];
    imageUrl = json["imageUrl"] ?? json["image"];
    color = HexColor.fromHex(json["color"]);
    size = json["size"];
    price = json["price"]!;
    quantity = json["quantity"] ?? 1;
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "product_id": productId,
      "name": name,
      "image": imageUrl,
      "color": HexColor(color!).toHex(),
      "size": size,
      "price": price,
      "quantity": quantity,
    };
  }
}