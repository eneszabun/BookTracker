// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'localwidgets/login_form.dart';

class OurLogin extends StatelessWidget {
  const OurLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child:
                      Image.asset("assets/icon.png", width: 100, height: 100),
                ),
                SizedBox(height: 20),
                OurLoginForm()
              ],
            ),
          )
        ],
      ),
    );
  }
}
