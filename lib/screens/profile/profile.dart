// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';

import 'package:book_logging_app/screens/books/books.dart';
import 'package:book_logging_app/screens/want_to_reed/want_to_read.dart';
import 'package:book_logging_app/widgets/ourcontanier.dart';
import 'package:book_logging_app/widgets/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../states/current_user.dart';
import '../home/home.dart';

class EnterExitRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  EnterExitRoute({required this.exitPage, required this.enterPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: enterPage,
              )
            ],
          ),
        );
}

class OurProfile extends StatefulWidget {
  const OurProfile({Key? key}) : super(key: key);
  @override
  _OurProfileState createState() => _OurProfileState();
}

class _OurProfileState extends State<OurProfile> {
  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    var uid = _currentUser.getCurrentUser.uid.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _currentUser.getCurrentUser.userName.toString() + "'s Profile"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 24),
          ProfileWidget(
            imagePath: _currentUser.getCurrentUser.imagePath.toString(),
            onTap: () async {},
          ),
          SizedBox(height: 24),
          buildName(_currentUser),
          SizedBox(height: 24),
          Divider(
            height: 0.1,
            thickness: 1,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          ListTile(
            title: Text(
              "Books",
              style: GoogleFonts.roboto(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 21,
              ),
            ),
            trailing: bookCount(uid),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                EnterExitRoute(exitPage: HomeScreen(), enterPage: OurBooks()),
              );
            },
          ),
          ListTile(
            title: Text(
              "Want To Read",
              style: GoogleFonts.roboto(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 21,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                EnterExitRoute(
                    exitPage: HomeScreen(), enterPage: OurWantToRead()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildName(_currentUser) => Column(
        children: [
          Text(
            _currentUser.getCurrentUser.userName.toString(),
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _currentUser.getCurrentUser.email.toString(),
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      );
}

final db = FirebaseFirestore.instance;
Widget bookCount(uid) => StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('bookshelves')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Text('${snapshot.data?.docs.length}',
            style: GoogleFonts.roboto(
              fontSize: 17,
              color: Theme.of(context).secondaryHeaderColor,
            ));
      },
    );
