import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class SimplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Title
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "发布成功",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.normal),
        ),
        leading: IconButton(
          icon: Image.asset("assets/images/nav_close.png"),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),

      /// body
      body: SimplePageContent(),
    );
  }
}

class SimplePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 42.0),
      child: Column(
        children: <Widget>[
          /// line 2
          new Row(
            children: <Widget>[
              new Container(
                width: 52.0,
                height: 52.0,
                margin: const EdgeInsets.only(left: 16.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar2.png"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 7.0, right: 15.0),
                height: 48.0,
                child: Stack(
                  children: <Widget>[
                    Image.asset("assets/images/publish_chat_box.png"),
                    Positioned(
                      left: 25.0,
                      top: 14.0,
                      child: Text(
                        "张老师发布了一个任务，请接收~",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          /// line 4
          LineTips(
            title: Text(
              "给家长发个通知吧",
              style: TextStyle(fontSize: 14.0, color: const Color(0xff757085)),
            ),
          ),

          /// line 5
          Container(
            margin: const EdgeInsets.only(top: 32.0),
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 60.0,
                  icon: Image.asset("assets/images/share_wechat.png"),
                  onPressed: () {
                    print("share to wechat.");
                  },
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 60.0,
                  icon: Image.asset("assets/images/share_qq.png"),
                  onPressed: () {
                    print("share to qq.");
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LineTips extends StatelessWidget {
  static const defaultMargin = const EdgeInsets.only(left: 15.0, right: 15.0);

  LineTips({
    @required this.title,
    this.margin = defaultMargin,
  });

  final Widget title;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: defaultMargin,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Expanded(
            child: new Container(
              margin: const EdgeInsets.only(
                right: 10.0,
              ),
              color: const Color(0xFFD4CFE4),
              height: 1.0,
            ),
          ),
          title,
          new Expanded(
            child: new Container(
              margin: const EdgeInsets.only(
                left: 10.0,
              ),
              color: const Color(0xFFD4CFE4),
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
