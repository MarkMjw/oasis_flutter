import 'package:flutter/material.dart';
import 'package:oasis_flutter/app_theme.dart';
import 'package:oasis_flutter/page/main_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '绿洲Flutter',
        theme: AppTheme.darkTheme(),
        home: const MainPage());
  }
}
