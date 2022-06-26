// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OurWantToRead extends StatefulWidget {
  const OurWantToRead({Key? key}) : super(key: key);
  @override
  _OurWantToRead createState() => _OurWantToRead();
}

class _OurWantToRead extends State<OurWantToRead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Want To Read"),
      ),
    );
  }
}
