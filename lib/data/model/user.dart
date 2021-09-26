class UserModel{
  String? id, email, name, avatar;

  UserModel({this.id, this.email, this.name, this.avatar});

  UserModel.fromMap(Map json){
    id = json["id"];
    name = json["name"];
    email = json["email"];
    avatar = json["avatar"];
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "email": email,
      "avatar": avatar,
    };
  }

}