import 'package:first_news/screens/countries.dart';
import 'package:flutter/material.dart';
import 'package:first_news/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: {
        Countries.router: (context) => Countries(),
      },
    );
  }
}
