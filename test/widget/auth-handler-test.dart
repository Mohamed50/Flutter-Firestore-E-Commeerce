// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child view.widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/service/user-service.dart';
import 'package:getx_example/utils/validator.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:getx_example/view-model/home-view-model.dart';
import 'package:getx_example/view-model/menu-view-model.dart';
import 'package:getx_example/view/auth/auth-handler.dart';
import 'package:mockito/mockito.dart';
import '../mocks/auth-view-model-test.mocks.dart';
import '../mocks/firebase-mock.dart';
import '../util/const.dart';
import '../util/util.dart';



void main() {
  late MockFirebaseAuth _firebaseAuthMock;
  late MockGoogleSignIn _googleSignIn;
  late MockFacebookLogin _facebookLogin;
  late AuthViewModel authViewModel;
  late MockFirebaseFirestore _firestore;
  late UserService _userService;

  setUpAll(() async {
    setupFirebaseMocks();
    await Firebase.initializeApp();
  });

  setUp(() {
    _firebaseAuthMock = MockFirebaseAuth();
    _googleSignIn = MockGoogleSignIn();
    _facebookLogin = MockFacebookLogin();
    _firestore = MockFirebaseFirestore();
    when(_firestore.collection('Users')).thenReturn(MockCollectionReference());
    _userService = UserService.instance(_firestore);
    authViewModel = AuthViewModel.instance(_firebaseAuthMock, _googleSignIn, _facebookLogin, _userService);
  });


  group('Login page tests', () {
    final emailField = find.byKey(Key('email-field'));
    final passwordField = find.byKey(Key('password-field'));
    final loginButton = find.text('Sign in');
    final facebookLoginButton = find.byKey(Key('facebook-login'));
    final googleLoginButton = find.byKey(Key('google-login'));

    testWidgets('when it is login page then all widgets found', (WidgetTester tester) async {
        Get.put<AuthViewModel>(authViewModel);
        await tester.pumpWidget(makeWidgetTestable(AuthHandler()));
        // Verify that our widgets found.
        expect(emailField, findsOneWidget);
        expect(passwordField, findsOneWidget);
        expect(loginButton, findsOneWidget);
        expect(facebookLoginButton, findsOneWidget);
        expect(googleLoginButton, findsOneWidget);
    });

    testWidgets('when press sign in button with empty fields then empty field message found', (WidgetTester tester) async {
        Get.put<AuthViewModel>(authViewModel);
        await tester.pumpWidget(makeWidgetTestable(AuthHandler()));

        await tester.tap(loginButton);
        await tester.pump();

        expect(find.text(emailEmptyMessageKey.tr), findsOneWidget);
        expect(find.text(passwordEmptyMessageKey.tr), findsOneWidget);
    });

    testWidgets('when press sign in button with unValid fields data then unValid field message found', (WidgetTester tester) async {
        Get.put<AuthViewModel>(authViewModel);
        await tester.pumpWidget(makeWidgetTestable(AuthHandler()));

        await tester.enterText(emailField, unValidEmail);
        await tester.enterText(passwordField, unValidPassword);
        await tester.tap(loginButton);
        await tester.pump();

        expect(find.text(emailNotValidMessageKey.tr), findsOneWidget);
        expect(find.text(passwordNotValidMessageKey.tr), findsOneWidget);
    });

    _mockSignInWithEmailSuccess(){
      final MockUserCredential userCredential = MockUserCredential();
      when(userCredential.user).thenReturn(MockUser());
      when(_firebaseAuthMock.signInWithEmailAndPassword(email: validEmail, password: validPassword)).thenAnswer((realInvocation) async => userCredential);
    }

    _mockSignInWithEmailField(){
      when(_firebaseAuthMock.signInWithEmailAndPassword(email: validEmail, password: validPassword)).thenAnswer((realInvocation) async => throw FirebaseAuthException(code: ''));
    }

    testWidgets('when press sign in button with valid fields then menu page and home page are found', (WidgetTester tester) async {
        Get.put<AuthViewModel>(authViewModel);
        Get.put<MenuViewModel>(MenuViewModel());
        Get.put<HomeViewModel>(HomeViewModel());
        _mockSignInWithEmailSuccess();
        await tester.pumpWidget(makeWidgetTestable(AuthHandler()));

        await tester.enterText(emailField, validEmail);
        await tester.enterText(passwordField, validPassword);
        await tester.tap(loginButton);
        await tester.pump();

        expect(loginButton, findsNothing);
        expect(find.byKey(Key('menu-page')), findsOneWidget);
        expect(find.byKey(Key('home-page')), findsOneWidget);
    });

    testWidgets('when press sign in button with unValid fields then menu page and home page are not found', (WidgetTester tester) async {
        Get.put<AuthViewModel>(authViewModel);
        _mockSignInWithEmailField();
        await tester.pumpWidget(makeWidgetTestable(AuthHandler()));

        await tester.enterText(emailField, validEmail);
        await tester.enterText(passwordField, validPassword);
        await tester.tap(loginButton);
        await tester.pump(Duration(seconds: 3));

        expect(loginButton, findsOneWidget);
        expect(find.byKey(Key('menu-page')), findsNothing);
        expect(find.byKey(Key('home-page')), findsNothing);
    });



  });
}
