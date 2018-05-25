import 'package:flutter/material.dart';
import 'package:flutter_app/content_list.dart';
import 'package:flutter_app/string.dart';

void main() => runApp(AwesomeTip());

class AwesomeTip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Strings.appTitle,
        theme: ThemeData(
          primaryColor: Colors.red.shade800,
        ),
        home: ContentList());
  }
}
