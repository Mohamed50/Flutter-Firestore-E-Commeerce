import 'package:flutter/material.dart';
import 'package:getx_example/utils/color-extension.dart';

class ProductModel{

  String? id, name, details, description, imageUrl;
  List<String> sizes = [];
  double? price;
  Color? color;
  bool? isLiked;

  ProductModel(this.id, this.name, this.details, this.description, this.imageUrl, this.sizes, this.isLiked, this.price);

  ProductModel.fromMap(Map json){
    id = json["id"];
    name = json["name"];
    details = json["details"];
    description = json["description"];
    imageUrl = json["imageUrl"];
    price = json["price"] != null ? double.parse(json["price"].toString()) : 0.0;
    color = json["color"] != null ? HexColor.fromHex(json["color"]) : null;
    sizes = json["color"] != null ? List<String>.from(json["sizes"].map((x) => x)) : [];
  }

  Map<String, dynamic> toMap(){
    return {
      "name": name,
      "details": details,
      "description": description,
      "imageUrl": imageUrl,
      "sizes": sizes,
      "price": price,
      "color": HexColor(color!).toHex(),
    };
  }
}