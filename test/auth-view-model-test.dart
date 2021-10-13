import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'mocks/auth-view-model-test.mocks.dart';

String validEmail = "abc@gmail.com";
String validPassword = 'abc@123';

@GenerateMocks([FacebookLogin])
main() async {
  final user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: validEmail,
    displayName: 'Bob',
  );

  final _firebaseAuthMock = MockFirebaseAuth(mockUser: user);
  final _googleSignIn = MockGoogleSignIn();
  final _facebookLogin = MockFacebookLogin();

  AuthViewModel authViewModel = AuthViewModel.instance(_firebaseAuthMock, _googleSignIn, _facebookLogin);

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

    test(
      'when sign in with google account success then credential is not null',
          () async {
        //ACT
        final credentials = await authViewModel.getGoogleCredentials();
        //ASSERT
        expect(credentials, isNotNull);
      },
    );

    test(
      'when sign in with google account canceled then exception thrown',
          () async {
        _googleSignIn.setIsCancelled(true);
        //ASSERT
        expect(authViewModel.getGoogleCredentials(), throwsException);
      },
    );

  });

  group('Sign in with email and password', () {
    test(
      'when sign in with email and password then user is not null and state is authenticated',
      () async {
        //ACT
        await authViewModel.signInWithEmail(validEmail, validPassword);
        //ASSERT
        expect(authViewModel.user, isNotNull);
        expect(authViewModel.authState, AuthState.Authenticated);
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
