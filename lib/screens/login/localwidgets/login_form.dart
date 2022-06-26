// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_print

import 'package:book_logging_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../states/current_user.dart';
import '../../../widgets/ourcontanier.dart';
import '../../signUp/signUp.dart';

enum LogingType { email, google }

class OurLoginForm extends StatefulWidget {
  const OurLoginForm({Key? key}) : super(key: key);

  @override
  State<OurLoginForm> createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _loginUser({
    required LogingType type,
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    CurrentUser _currentUser =
        Provider.of<CurrentUser>(context!, listen: false);

    try {
      String _returnString = "";
      switch (type) {
        case LogingType.email:
          _returnString =
              await _currentUser.loginUserWithEmail(email!, password!);
          break;
        case LogingType.google:
          _returnString = await _currentUser.loginUserWithGoogle();
          break;
        default:
      }

      if (_returnString == "success") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false);
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

  Widget _googleButton() {
    return OutlinedButton(
      onPressed: () {
        _loginUser(type: LogingType.google, context: context);
      },
      style: OutlinedButton.styleFrom(
        primary: Theme.of(context).secondaryHeaderColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 0,
        side: BorderSide(color: Theme.of(context).canvasColor),
      ),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Image(image: AssetImage("assets/google_logo.png"), height: 25.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Sign in with Google"),
              ),
            ],
          )),
    );
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
              "Log In",
              style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
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
              child: Text("Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
            ),
            onPressed: () {
              _loginUser(
                  type: LogingType.email,
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context);
            },
          ),
          TextButton(
            child: Text("Don't have an account? Sign up here."),
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Theme.of(context).secondaryHeaderColor,
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 2.15,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OurSignUp(),
                ),
              );
            },
          ),
          _googleButton(),
        ],
      ),
    );
  }
}
