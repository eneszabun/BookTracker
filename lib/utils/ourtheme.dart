// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field

import 'package:flutter/material.dart';

class OurTheme {
  Color _lightGreenColor = Color.fromARGB(255, 63, 157, 131);
  Color _darkGreenColor = Color.fromARGB(255, 14, 56, 51);
  Color _darkBlueColor = Color.fromARGB(255, 5, 20, 38);
  Color _lightBlueColor = Color.fromARGB(255, 71, 110, 157);
  Color _darkBrownColor = Color.fromARGB(255, 59, 38, 6);
  Color _lightBrownColor = Color.fromARGB(255, 173, 133, 69);
  Color _darkWoodenColor = Color.fromARGB(255, 59, 25, 6);
  Color _lightWoodenColor = Color.fromARGB(255, 173, 107, 69);
  Color _lightOrangeColor = Color.fromARGB(255, 255, 186, 0);
  Color _darkOrangeColor = Color.fromARGB(255, 187, 138, 82);
  Color _bordouxColor = Color.fromARGB(255, 59, 12, 25);
  Color _lightYellowColor = Color.fromARGB(255, 240, 184, 96);
  Color _whiteColor = Colors.white;

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: _darkGreenColor,
      primaryColorDark: _darkBlueColor,
      primaryColorLight: _lightWoodenColor,
      secondaryHeaderColor: _lightOrangeColor,
      focusColor: _darkOrangeColor,
      cardColor: _whiteColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white70,
        titleSpacing: -6,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 21,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
