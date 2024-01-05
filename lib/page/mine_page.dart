import 'package:flutter/material.dart';

import 'demo/demo_page.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("我的"),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.dehaze),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoPage()));
                })
          ],
        ),
        body: const Center(
          child: Text("个人页"),
        ));
  }
}
