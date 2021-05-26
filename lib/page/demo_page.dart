import 'package:flutter/material.dart';
import 'package:flutter_app/page/demo_layout_page.dart';
import 'package:flutter_app/page/demo_list_page.dart';

class DemoPage extends StatefulWidget {
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
    return new Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                child: Text("Layout demo页面", style: TextStyle(fontSize: 15.0, color: Colors.red)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DemoLayoutPage()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                child: Text("List demo页面", style: TextStyle(fontSize: 15.0, color: Colors.red)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DemoListPage()));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
