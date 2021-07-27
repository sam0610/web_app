import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/user.dart';
import 'package:web_app/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: constant_identifier_names
enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  User? _user;
  // ignore: unused_field
  Status _status = Status.Uninitialized;
  final UserServices _userServices = UserServices();

  UserModel? _userModel;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

//  getter
  UserModel? get userModel => _userModel;
  Status get status => _status;
  User? get user => _user;

  AuthProvider.init() {
    _fireSetup();
  }
  _fireSetup() async {
    await initialization.then((value) {
      auth.authStateChanges().listen(_onStateChanged);
    });
  }

  Future<Map<String, dynamic>> sigInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await auth.signInWithCredential(credential).then((userCredential) async {
        _user = userCredential.user;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("id", _user!.uid);
        if (!await _userServices.doesUserExist(_user!.uid)) {
          _userServices.createUser(
              id: _user!.uid,
              name: _user!.displayName ?? "",
              photo: _user!.photoURL ?? "");
          await initializeUserModel();
        } else {
          await initializeUserModel();
        }
      });
      return {'success': true, 'message': 'success'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<bool> initializeUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? _userId = preferences.getString('id');
    if (_userId != null) {
      _userModel = await UserServices().getUserById(_userId);
    }
    notifyListeners();
    if (_userModel == null) {
      return false;
    } else {
      return true;
    }
  }

  Future signOut() async {
    auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
      notifyListeners();
    } else {
      _user = firebaseUser;
      initializeUserModel();
      Future.delayed(const Duration(seconds: 2), () {
        _status = Status.Authenticated;
        notifyListeners();
      });
    }
  }
}
