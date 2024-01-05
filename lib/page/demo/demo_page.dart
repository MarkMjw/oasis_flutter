import 'package:flutter/material.dart';
import 'package:oasis_flutter/page/demo/demo_layout_page.dart';
import 'package:oasis_flutter/page/demo/demo_list_page.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      print(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Layout demo页面", style: TextStyle(fontSize: 15.0, color: Colors.red)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoLayoutPage()));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("List demo页面", style: TextStyle(fontSize: 15.0, color: Colors.red)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoListPage()));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
