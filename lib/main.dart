import 'package:flutter/material.dart';
import 'package:oasis_flutter/config/color_config.dart';
import 'package:oasis_flutter/page/main_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '绿洲Flutter',
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: ColorConfig.commonColorHighlight,
          primaryColorDark: ColorConfig.colorPrimary,
          primaryColor: ColorConfig.colorPrimary,
        ),
        home: MainPage());
  }
}
