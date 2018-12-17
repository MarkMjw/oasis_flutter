import 'package:flutter/material.dart';

class MoneyPage extends StatefulWidget {
  @override
  _MoneyPageState createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("钱包"),
        ),
        body: Center(
          child: Text("钱包Tab"),
        ));
  }
}
