import 'package:flutter/material.dart';
import 'package:flutter_app/page/main_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.red,
          primaryColorDark: Colors.red,
          primaryColor: Colors.red,
        ),
        home: new MainPage());
  }
}
