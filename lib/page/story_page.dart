import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("故事"),
        ),
        body: Center(
          child: Text("故事Tab"),
        ));
  }
}
