import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'mocks/auth-view-model-test.mocks.dart';

String validEmail = "abc@gmail.com";
String validPassword = 'abc@123';
String unValidEmail = "test@gmail.com";
String unValidPassword = 'test@123';

@GenerateMocks([FacebookLogin])
@GenerateMocks([GoogleSignIn, GoogleSignInAccount, GoogleSignInAuthentication])
@GenerateMocks([FirebaseAuth, UserCredential, User])
main() async {
  late MockFirebaseAuth _firebaseAuthMock;
  late MockGoogleSignIn _googleSignIn;
  late MockFacebookLogin _facebookLogin;
  late AuthViewModel authViewModel;

  setUp(() {
    _firebaseAuthMock = MockFirebaseAuth();
    _googleSignIn = MockGoogleSignIn();
    _facebookLogin = MockFacebookLogin();
    authViewModel = AuthViewModel.instance(
        _firebaseAuthMock, _googleSignIn, _facebookLogin);
  });

  group('Get Facebook Credentials', () {
    _getFakeFacebookResult(FacebookLoginStatus status) {
      DateTime expires = DateTime.now().add(Duration(days: 1));
      return FacebookLoginResult(
        status,
        FacebookAccessToken.fromMap(
          {
            "token": "",
            "userId": "",
            "expires": expires.millisecondsSinceEpoch,
            'permissions': [],
            'declinedPermissions': [],
          },
        ),
      );
    }

    _fakeFacebookLogin(FacebookLoginStatus status) {
      when(_facebookLogin.logIn(permissions: [FacebookPermission.email]))
          .thenAnswer((_) async {
        return _getFakeFacebookResult(status);
      });
    }

    test(
      'when sign in with facebook account success then credential is not null',
      () async {
        //ARRANGE
        _fakeFacebookLogin(FacebookLoginStatus.success);
        //ACT
        final credentials = await authViewModel.getFacebookCredentials();
        //ASSERT
        expect(credentials, isNotNull);
      },
    );

    test(
      'when sign in with facebook account failed then exception thrown',
      () async {
        //ARRANGE
        _fakeFacebookLogin(FacebookLoginStatus.error);
        //ASSERT
        expect(authViewModel.getFacebookCredentials(), throwsException);
      },
    );

    test(
      'when sign in with facebook account canceled then exception thrown',
      () async {
        //ARRANGE
        _fakeFacebookLogin(FacebookLoginStatus.cancel);
        //ASSERT
        expect(authViewModel.getFacebookCredentials(), throwsException);
      },
    );
  });

  group('Get Google Credentials', () {
    _getMockGoogleSignInAuthentication() {
      final googleAuthentication = MockGoogleSignInAuthentication();
      when(googleAuthentication.accessToken).thenReturn("");
      when(googleAuthentication.idToken).thenReturn("");
      return googleAuthentication;
    }

    _getFakeGoogleAccount() {
      final googleAccount = MockGoogleSignInAccount();
      when(googleAccount.authentication).thenAnswer((_) async {
        return _getMockGoogleSignInAuthentication();
      });
      return googleAccount;
    }

    _fakeGoogleLogin([String? error]) {
      when(_googleSignIn.signIn()).thenAnswer((_) async {
        if (error == null)
          return _getFakeGoogleAccount();
        else
          throw Exception(error);
      });
    }

    test(
      'when sign in with google account success then credential is not null',
      () async {
        //Assign
        _fakeGoogleLogin();
        //ACT
        final credentials = await authViewModel.getGoogleCredentials();
        //ASSERT
        expect(credentials, isNotNull);
      },
    );

    test(
      'when sign in with google account finish with error then exception thrown',
      () async {
        //CANCELED
        _fakeGoogleLogin(GoogleSignIn.kSignInCanceledError);
        expect(authViewModel.getGoogleCredentials(), throwsException);
        //NETWORK ERROR
        _fakeGoogleLogin(GoogleSignIn.kNetworkError);
        expect(authViewModel.getGoogleCredentials(), throwsException);
        //SIGN IN FAILED
        _fakeGoogleLogin(GoogleSignIn.kSignInFailedError);
        expect(authViewModel.getGoogleCredentials(), throwsException);
        //SIGN IN REQUIRED ERROR
        _fakeGoogleLogin(GoogleSignIn.kSignInRequiredError);
        expect(authViewModel.getGoogleCredentials(), throwsException);
      },
    );
  });

  group('Sign in with email and password', () {

    _mockSignInWithEmailSuccess(){
      final MockUserCredential userCredential = MockUserCredential();
      when(userCredential.user).thenReturn(MockUser());
      when(_firebaseAuthMock.signInWithEmailAndPassword(email: validEmail, password: validPassword)).thenAnswer((realInvocation) async => userCredential);
    }

    _mockSignInWithEmailField(){
      when(_firebaseAuthMock.signInWithEmailAndPassword(email: unValidEmail, password: unValidPassword)).thenAnswer((realInvocation) async => throw FirebaseAuthException(code: ''));
    }


    test(
      'when sign in with valid email and password then user is not null and state is authenticated',
      () async {
        //ASSIGN
        _mockSignInWithEmailSuccess();
        //ACT
        await authViewModel.signInWithEmail(validEmail, validPassword);
        //ASSERT
        expect(authViewModel.user, isNotNull);
        expect(authViewModel.authState, AuthState.Authenticated);
      },
    );

    test(
      'when sign in with unValid email and password then user is null and state is unauthenticated',
      () async {
        //ASSIGN
        _mockSignInWithEmailField();
        //ASSERT
        expect(authViewModel.signInWithEmail(unValidEmail, unValidPassword), throwsException);
        expect(authViewModel.user, isNull);
        expect(authViewModel.authState, AuthState.NotAuthenticated);
      },
    );

    test(
      'when sign out then user is null and state is not authenticated',
      () async {
        //ACT
        await authViewModel.signOut();
        //ASSERT
        expect(authViewModel.user, isNull);
        expect(authViewModel.authState, AuthState.NotAuthenticated);
      },
    );


  });

  group('Sign in with credentials', () {
    _getGoogleCredentials() async {
      final signInAccount = await _googleSignIn.signIn();
      final signInAuthentication = await signInAccount!.authentication;
      return GoogleAuthProvider.credential(
        accessToken: signInAuthentication.accessToken,
        idToken: signInAuthentication.idToken,
      );
    }

    test(
      'when sign in with google account then user is not null and state is authenticated',
      () async {
        //ASSIGN
        final OAuthCredential credential = await _getGoogleCredentials();
        //ACT
        await authViewModel.signInWithCredentials(credential);
        //ASSERT
        expect(authViewModel.user, isNotNull);
        expect(authViewModel.authState, AuthState.Authenticated);
      },
    );

    test(
      'when sign out then user is null',
      () async {
        //ACT
        await authViewModel.signOut();
        //ASSERT
        expect(authViewModel.user, isNull);
        expect(authViewModel.authState, AuthState.NotAuthenticated);
      },
    );
  });
}
