// ignore_for_file: avoid_print, await_only_futures

import 'package:book_logging_app/models/data.dart';
import 'package:book_logging_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  late OurUser _currentUser;

  OurUser get getCurrentUser => _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";
    try {
      User? _firebaseUser = await _auth.currentUser;
      if (_firebaseUser != null) {
        _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
        if (_currentUser != null) {
          retVal = "success";
        }
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";
    try {
      await FirebaseAuth.instance.signOut();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(
      String email, String password, String userName) async {
    String retVal = "error";
    OurUser _user = OurUser();
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user_ = _result.user;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user_!.uid)
          .set({'email': email, 'userName': userName});
      _user.uid = user_.uid;
      _user.email = user_.email;
      _user.userName = userName;
      String _returnString = await OurDatabase().createUser(_user);
      if (_returnString == "success") {
        retVal = "success";
      }
    } on FirebaseAuthException catch (e) {
      retVal = e.message!;
    }

    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user_ = _result.user;
      _currentUser = await OurDatabase().getUserInfo(user_!.uid);
      if (_currentUser != null) {
        retVal = "success";
      }
    } on FirebaseAuthException catch (e) {
      retVal = e.message!;
    }

    return retVal;
  }

  Future<String> loginUserWithGoogle() async {
    String retVal = "error";
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    OurUser _user = OurUser();
    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUser!.authentication;
      final AuthCredential credantial = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      UserCredential _authResult = await _auth.signInWithCredential(credantial);
      User? user_ = _authResult.user;
      if (_authResult.additionalUserInfo!.isNewUser) {
        _user.uid = user_!.uid;
        _user.email = user_.email;
        _user.userName = user_.displayName;
        OurDatabase().createUser(_user);
      }
      _currentUser = await OurDatabase().getUserInfo(user_!.uid);
      if (_currentUser != null) {
        retVal = "success";
      }
    } on FirebaseAuthException catch (e) {
      retVal = e.message!;
    }

    return retVal;
  }
}
