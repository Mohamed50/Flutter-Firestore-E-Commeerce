import 'package:flutter/material.dart';
import 'package:getx_example/utils/color-extension.dart';

class ProductModel{

  String? name, details, description, imageUrl;
  List<String> sizes = [];
  Color? color;
  bool? isLiked;

  ProductModel(this.name, this.details, this.description, this.imageUrl, this.sizes, this.isLiked);

  ProductModel.fromMap(Map json){
    name = json["name"];
    details = json["details"];
    description = json["description"];
    imageUrl = json["imageUrl"];
    color = HexColor.fromHex(json["color"]);
    sizes = List<String>.from(json["sizes"].map((x) => x));
  }

  Map<String, dynamic> toMap(){
    return {

    };
  }
}