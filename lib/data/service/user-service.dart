import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_example/data/model/user.dart';

class UserService{

  late FirebaseFirestore _firestore;
  late CollectionReference _usersCollection;

  UserService(){
    _firestore = FirebaseFirestore.instance;
    init();
  }

  UserService.instance(this._firestore){
    init();
  }

  init(){
    _usersCollection = _firestore.collection("Users");
  }

  addUser(UserModel user) async {
    await _usersCollection.doc(user.id).set(user.toMap());
  }

}