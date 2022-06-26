// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, prefer_const_declarations

import 'package:book_logging_app/screens/books/books.dart';
import 'package:book_logging_app/screens/home/home.dart';
import 'package:book_logging_app/screens/profile/profile.dart';
import 'package:book_logging_app/screens/settings/settings.dart';
import 'package:book_logging_app/screens/want_to_reed/want_to_read.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../screens/root/root.dart';
import '../states/current_user.dart';

void _signOut(BuildContext context) async {
  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
  String _returnString = await _currentUser.signOut();
  if (_returnString == "success") {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OurRoot(),
        ),
        (route) => false);
  }
}

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

class OurDrawer extends StatelessWidget {
  const OurDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              _currentUser.getCurrentUser.userName.toString(),
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: 'Roboto',
              ),
            ),
            accountEmail: Text(
              _currentUser.getCurrentUser.email.toString(),
              style: TextStyle(
                color: Colors.white60,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/profile.png"),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.network(
                        'https://media.istockphoto.com/photos/rocky-mountains-in-black-and-white-silhouette-picture-id528723418?b=1&k=20&m=528723418&s=170667a&w=0&h=1jMUXCQY5GDITD8k_vsRrYJtWgVGlOIOI3wg-Q8jCU0=')
                    .image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.solidUser,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 18,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                EnterExitRoute(exitPage: HomeScreen(), enterPage: OurProfile()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.book,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            title: Text(
              "Books",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 18,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                EnterExitRoute(exitPage: HomeScreen(), enterPage: OurBooks()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.solidClock,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            title: Text(
              "Want To Read",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 18,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                EnterExitRoute(
                  exitPage: HomeScreen(),
                  enterPage: OurWantToRead(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.gear,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            title: Text(
              "Settings",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 18,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                EnterExitRoute(
                    exitPage: HomeScreen(), enterPage: OurSettings()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            title: Text(
              "Log Out",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 18,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () => _signOut(context),
          ),
          Divider(
            height: 0.3,
            thickness: 3,
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ],
      ),
    );
  }
}
