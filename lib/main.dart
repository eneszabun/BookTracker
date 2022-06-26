import 'package:book_logging_app/screens/books/books.dart';
import 'package:book_logging_app/screens/root/root.dart';
import 'package:book_logging_app/screens/search/search.dart';
import 'package:book_logging_app/screens/settings/settings.dart';
import 'package:book_logging_app/screens/want_to_reed/want_to_read.dart';
import 'package:book_logging_app/states/current_user.dart';
import 'package:book_logging_app/utils/ourtheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/profile/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/profile': (context) => const OurProfile(),
          '/books': (context) => const OurBooks(),
          '/wanttoread': (context) => const OurWantToRead(),
          '/settings': (context) => const OurSettings(),
        },
        theme: OurTheme().buildTheme(),
        home: const OurRoot(),
      ),
    );
  }
}
