import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn(scopes: scopes);

const gID =
    "207114108828-448fdu668k2sp54cdv482cg3clkrtlru.apps.googleusercontent.com";

const scopes = [
  SheetsApi.spreadsheetsScope,
  SheetsApi.driveScope,
  SheetsApi.driveFileScope
];

const double defaultPadding = 10.0;

ThemeData themeData() => ThemeData(
    primaryColor: Colors.blue,
    primarySwatch: Colors.purple,
    backgroundColor: Colors.blue.shade100,
    textTheme: GoogleFonts.robotoTextTheme());
