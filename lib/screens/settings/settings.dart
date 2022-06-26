// ignore_for_file: prefer_const_constructors

import 'package:book_logging_app/widgets/ourdrawer.dart';
import 'package:flutter/material.dart';

class OurSettings extends StatefulWidget {
  const OurSettings({Key? key}) : super(key: key);
  @override
  _OurSettingsState createState() => _OurSettingsState();
}

class _OurSettingsState extends State<OurSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
    );
  }
}
