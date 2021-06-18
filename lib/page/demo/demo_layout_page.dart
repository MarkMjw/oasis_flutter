import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class DemoLayoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Title
      appBar: AppBar(
        title: Text("Layout demo"),
//        leading: IconButton(
//          icon: Image.asset("assets/images/icon_close.png"),
//          onPressed: () {
//            Navigator.maybePop(context);
//          },
//        ),
      ),

      /// body
      body: _LayoutPageState(),
    );
  }
}

class _LayoutPageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 42.0),
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 52.0,
                    height: 52.0,
                    margin: const EdgeInsets.only(left: 16.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avatar.png"),
                    ),
                  ),
                  Container(
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
            ],
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(6.0, 24.0, 6.0, 30.0),
            child: RoundInnerSquareBox(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 12.0),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Unit 1 Lesson 3 About animal",
                      style: TextStyle(fontSize: 20.0, fontFamily: "Round", color: Colors.white),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0, bottom: 13.0),
                      child: Image.asset("assets/images/publish_work_line.png"),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: <Widget>[
                        WorkTotalItem(title: "课文跟读 12"),
                        WorkTotalItem(title: "课文跟读 13"),
                        WorkTotalItem(title: "课文跟读 14"),
                        WorkTotalItem(title: "课文跟读 15")
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 178.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset("assets/images/publish_work_sign.png"),
                          Positioned(
                            left: 4.0,
                            top: 4.0,
                            child: Text(
                              "预习",
                              style: TextStyle(fontSize: 14.0, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "明天12：00截止",
                        style: TextStyle(fontSize: 12.0, color: const Color(0xffffc1c1)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          LineTips(
            title: Text(
              "给家长发个通知吧",
              style: TextStyle(fontSize: 14.0, color: const Color(0xff757085)),
            ),
          ),
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
                  padding: EdgeInsets.only(left: 32.0),
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

class RoundInnerSquareBox extends StatelessWidget {
  static const double gap = 12.0;

  final Widget? child;

  RoundInnerSquareBox({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(const Radius.circular(16.0)),
      child: Container(
        color: const Color(0xfff0d5a9),
        padding: const EdgeInsets.all(gap),
        child: Container(
          child: Container(
            color: const Color(0xff3c594e),
            child: child,
          ),
        ),
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

  final Widget? title;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultMargin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                right: 10.0,
              ),
              color: const Color(0xFFD4CFE4),
              height: 1.0,
            ),
          ),
          title!,
          Expanded(
            child: Container(
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

class WorkTotalItem extends StatelessWidget {
  final String? title;

  WorkTotalItem({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        "$title",
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
