import 'package:flutter/material.dart';

import 'demo/demo_page.dart';

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
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.dehaze),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DemoPage()));
                })
          ],
        ),
        body: Center(
          child: Text("个人页"),
        ));
  }
}
