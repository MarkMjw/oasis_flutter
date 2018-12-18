import 'package:flutter/material.dart';
import 'package:flutter_app/page/demo_page.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("我的"),
        ),
        body: Center(
          child: Text("我的Tab"),
        ));
  }
}
