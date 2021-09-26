class ProductModel{

  String? name, shortDesc, description, imageUrl;
  List<String> sizes = [];
  bool? isLiked;

  ProductModel(this.name, this.shortDesc, this.description, this.imageUrl, this.sizes, this.isLiked);

  ProductModel.fromMap();

  Map<String, dynamic> toMap(){
    return {

    };
  }
}