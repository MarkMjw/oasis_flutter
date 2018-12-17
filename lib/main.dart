import 'package:flutter/material.dart';
import 'package:flutter_app/config/color_config.dart';
import 'package:flutter_app/page/main_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          accentColor: ColorConfig.colorPrimary,
          primaryColorDark: ColorConfig.colorPrimary,
          primaryColor: ColorConfig.colorPrimary,
        ),
        home: new MainPage());
  }
}
