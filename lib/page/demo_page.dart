import 'package:flutter/material.dart';
import 'package:flutter_app/page/demo_layout_page.dart';
import 'package:flutter_app/page/demo_list_page.dart';

class DemoPage extends StatefulWidget {
  DemoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DemoPageState createState() => new _DemoPageState();
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
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 20.0),
              child: new RaisedButton(
                child: Text("Layout demo页面", style: new TextStyle(fontSize: 15.0, color: Colors.red)),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new DemoLayout()));
                },
              ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 20.0),
              child: new RaisedButton(
                child: Text("List demo页面", style: new TextStyle(fontSize: 15.0, color: Colors.red)),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new DemoList()));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
