import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/model/user.dart';
import 'package:getx_example/data/service/user-service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();

  String? email, password, name;

  Rxn<User> _user = Rxn<User>();

  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_firebaseAuth.authStateChanges());
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await _googleUser!
          .authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      _firebaseAuth.signInWithCredential(credential).then((value) =>
          saveUser(value));
    }
    catch (e){
      print(e.toString());
      Get.snackbar("Authentication", e.toString());
    }
  }

  Future<void> facebookSignIn() async {
    final FacebookLoginResult? _facebookUser =
        await _facebookLogin.logIn(permissions: [FacebookPermission.email]);
    OAuthCredential credential =
        FacebookAuthProvider.credential(_facebookUser!.accessToken!.token);
    _firebaseAuth
        .signInWithCredential(credential)
        .then((value) => saveUser(value));
  }

  emailSignIn() {
    try {
      _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
    } catch (e) {
      print(e.toString());
      Get.snackbar("Authenticating Error:", e.toString());
    }
  }

  void emailSignUp() {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) => saveUser(value));
    } catch (e) {
      print(e.toString());
      Get.snackbar("Authenticating Error:", e.toString());
    }
  }

  void signOut() {
    _firebaseAuth.signOut();
  }

  void saveUser(UserCredential userCredential) {
    print(userCredential.toString());
    UserService().addUser(
      UserModel.fromMap({
        "id": userCredential.user!.uid,
        "name": name == null ? userCredential.user!.displayName : name,
        "email": userCredential.user!.email,
        "avatar": userCredential.user!.photoURL,
      }),
    );
  }
}
