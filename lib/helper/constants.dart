import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn(scopes: scopes);

final gID =
    "207114108828-448fdu668k2sp54cdv482cg3clkrtlru.apps.googleusercontent.com";

var scopes = [
  SheetsApi.spreadsheetsScope,
  SheetsApi.driveScope,
  SheetsApi.driveFileScope
];
