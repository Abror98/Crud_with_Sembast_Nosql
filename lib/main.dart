import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sembast_nosql/di/locator.dart';
import 'package:sembast_nosql/screens/home_page.dart';

void main() {
  locatorSetUp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.redAccent
      ),
      home: HomePage.screen(),
    );
  }
}

