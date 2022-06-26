// ignore_for_file: prefer_const_constructors

import 'package:book_logging_app/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../widgets/ourcontanier.dart';
import '../../signUp/signUp.dart';

class OurSignUpForm extends StatefulWidget {
  const OurSignUpForm({Key? key}) : super(key: key);

  @override
  State<OurSignUpForm> createState() => _OurSignUpFormState();
}

class _OurSignUpFormState extends State<OurSignUpForm> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUpUser(String email, String password, String userName,
      BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String _returnString =
          await _currentUser.signUpUser(email, password, userName);
      if (_returnString == "success") {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OurContainerDark(
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: _userNameController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                FontAwesomeIcons.user,
                color: Theme.of(context).cardColor,
              ),
              hintText: "Name",
              hintStyle: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: _emailController,
            decoration: InputDecoration(
              prefixIcon:
                  Icon(FontAwesomeIcons.at, color: Theme.of(context).cardColor),
              hintText: "Email",
              hintStyle: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: _passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                FontAwesomeIcons.lock,
                color: Theme.of(context).cardColor,
              ),
              hintText: "Password",
              hintStyle: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold),
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                FontAwesomeIcons.lock,
                color: Theme.of(context).cardColor,
              ),
              hintText: "Confirm Password",
              hintStyle: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold),
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).secondaryHeaderColor,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.0),
              child: Text("Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
            ),
            onPressed: () {
              if (_passwordController.text == _confirmPasswordController.text) {
                _signUpUser(_emailController.text, _passwordController.text,
                    _userNameController.text, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Passwords do not match!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
