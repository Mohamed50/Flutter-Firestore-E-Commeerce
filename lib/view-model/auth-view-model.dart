import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/model/user.dart';
import 'package:getx_example/data/service/user-service.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthState { Authenticated, NotAuthenticated }

class AuthViewModel extends GetxController {
  AuthState authState = AuthState.NotAuthenticated;

  late FirebaseAuth _firebaseAuth;
  late GoogleSignIn _googleSignIn;
  late FacebookLogin _facebookLogin;

  String? email, password, name;

  Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;

  AuthViewModel() {
    _firebaseAuth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn(scopes: ["email"]);
    _facebookLogin = FacebookLogin();
  }

  AuthViewModel.instance(this._firebaseAuth, this._googleSignIn, this._facebookLogin);

  /// _____________________________ sign in state functions _____________________________

  Future googleSignIn() async {
    try {
      OAuthCredential credential = await getGoogleCredentials();
      UserCredential userCredential = await signInWithCredentials(credential);
      _saveUser(userCredential);
    } catch (e) {
      print(e.toString());
      Get.snackbar("Authentication", e.toString());
    }
  }

  Future facebookSignIn() async {
    try {
      OAuthCredential credential = await getFacebookCredentials();
      UserCredential userCredential = await signInWithCredentials(credential);
      _saveUser(userCredential);
    } catch (e) {
      print(e.toString());
      Get.snackbar("Authentication", e.toString());
    }
  }

  Future emailSignIn() async {
    try {
      await signInWithEmail(email!, password!);
    } catch (e) {
      Get.snackbar("Authenticating Error:", e.toString());
    }
  }

  Future emailSignUp() async {
    try {
      UserCredential userCredential = await signUpWithEmail(email!, password!);
      _saveUser(userCredential);
    } catch (e) {
      Get.snackbar("Authenticating Error:", e.toString());
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    _setUser(null);
    _notAuthenticated();
  }

  /// _____________________________ firebase calls _____________________________

  Future<UserCredential> signInWithEmail(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    _setUser(result.user);
    _authenticated();
    return result;
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    _setUser(result.user);
    _authenticated();
    return result;
  }

  Future<UserCredential> signInWithCredentials(OAuthCredential credential) async {
    UserCredential result = await _firebaseAuth.signInWithCredential(credential);
    _setUser(result.user);
    _authenticated();
    return result;
  }

  /// _____________________________ private functions _____________________________

  Future<OAuthCredential> getGoogleCredentials() async {
    final GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
    if(_googleUser != null) {
      GoogleSignInAuthentication googleSignInAuthentication = await _googleUser.authentication;
      return GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
    }
    else
      throw(Exception('something went wrong'));
  }

  Future<OAuthCredential> getFacebookCredentials() async {
    final FacebookLoginResult? _facebookUser =
        await _facebookLogin.logIn(permissions: [FacebookPermission.email]);
    if (_facebookUser!.status == FacebookLoginStatus.success)
      return FacebookAuthProvider.credential(_facebookUser.accessToken!.token);
    else
      throw Exception('Facebook login failed');
  }

  Future _saveUser(UserCredential userCredential) async {
    await UserService().addUser(
      UserModel.fromMap({
        "id": userCredential.user!.uid,
        "name": name == null ? userCredential.user!.displayName : name,
        "email": userCredential.user!.email,
        "avatar": userCredential.user!.photoURL,
      }),
    );
  }

  _authenticated(){
    authState = AuthState.Authenticated;
  }

  _notAuthenticated(){
    authState = AuthState.NotAuthenticated;
  }

  _setUser(User? user){
    _user.value = user;
  }

}
