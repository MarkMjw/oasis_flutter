import 'package:flutter/material.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({super.key});

  @override
  _MoneyPageState createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("消息"),
        ),
        body: const Center(
          child: Text("消息页"),
        ));
  }
}
