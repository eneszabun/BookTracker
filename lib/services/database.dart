// ignore_for_file: await_only_futures, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/data.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";
    try {
      await _firestore.collection("users").doc(user.uid).set({
        'userName': user.userName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();

    try {
      DocumentSnapshot<Map<String, dynamic>> _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal.uid = uid;
      retVal.userName = _docSnapshot.data()!['userName'];
      retVal.email = _docSnapshot.data()!['email'];
      retVal.accountCreated = _docSnapshot.data()!['accountCreated'];
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  // final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  // Future<String> createUserWithDatabase(OurUser user) async {
  //   String retVal = "error";
  //   try {
  //     await _firebaseDatabase.ref("users").set({
  //       'username': user.userName,
  //       'email': user.email,
  //       'accounCreated': Timestamp.now(),
  //     });
  //     retVal = "success";
  //   } catch (e) {
  //     print(e);
  //   }
  //   return retVal;
  // }

  // Future<OurUser> getUserInfoWithDatabase(String uid) async {
  //   OurUser retVal = OurUser();
  //   try {
  //     final _docSnapshot = await _firebaseDatabase.ref().child('users').get();
  //     retVal.uid = uid;
  //     retVal.userName = _docSnapshot.child('username') as String?;
  //     retVal.email = _docSnapshot.child('email') as String?;
  //   } catch (e) {
  //     print(e);
  //   }
  //   return retVal;
  // }
}
