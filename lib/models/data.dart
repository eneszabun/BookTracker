import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String? uid;
  String? email;
  String? userName;
  Timestamp? accountCreated;
  String? imagePath;

  OurUser(
      {this.uid,
      this.email,
      this.userName,
      this.accountCreated,
      this.imagePath});
}
