import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_example/data/model/user.dart';

class UserService{

  CollectionReference _usersCollection = FirebaseFirestore.instance.collection("Users");


  addUser(UserModel user) async {
    await _usersCollection.doc(user.id).set(user.toMap());
  }

}