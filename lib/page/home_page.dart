import 'package:flutter/material.dart';
import 'package:flutter_app/config/color_config.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/page/demo_page.dart';
import 'dart:convert';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/page/video_page.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> _cates = [];

  @override
  void initState() {
    _initTabs();
//    _fetchTabs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _cates.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("首页"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.dehaze),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DemoPage()));
                })
          ],
          bottom: TabBar(
            tabs: _cates.map((cate) {
              Tab(text: cate.name);
            }).toList(),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            indicatorWeight: 2,
//            indicatorPadding: EdgeInsets.only(bottom: 0.0),
            labelColor: Colors.white,
            labelStyle: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            unselectedLabelColor: ColorConfig.colorText1,
            unselectedLabelStyle: new TextStyle(fontSize: 16.0),
          ),
        ),
        body: TabBarView(
          children: _cates.map((cate) {
            return VideoPage(cid: cate.cid);
          }).toList(),
        ),
      ),
    );
  }

  void _initTabs() {
    var cate1 = Category();
    cate1.cid = "1";
    cate1.name = "推荐";

    var cate2 = Category();
    cate2.cid = "3";
    cate2.name = "搞笑";

    var cate3 = Category();
    cate3.cid = "7";
    cate3.name = "影视";

    var cate4 = Category();
    cate4.cid = "5";
    cate4.name = "萌趣";

    var cate5 = Category();
    cate5.cid = "6";
    cate5.name = "明星";

    var cate6 = Category();
    cate6.cid = "4";
    cate6.name = "音乐";

    var cate7 = Category();
    cate7.cid = "8";
    cate7.name = "体育";

    var cate8 = Category();
    cate8.cid = "9";
    cate8.name = "游戏";

    _cates.add(cate1);
    _cates.add(cate2);
    _cates.add(cate3);
    _cates.add(cate4);
    _cates.add(cate5);
    _cates.add(cate6);
    _cates.add(cate7);
    _cates.add(cate8);
  }

  void _fetchTabs() async {
    // 异步请求回来的数据无法显示
    String url = "${Api.HOST}/user/profile?${Api.COMMON_PARAM}";
    print(url);
    Response response = await get(url);

    final body = json.decode(response.body);
    final int code = body["code"];
    if (code == 0) {
      final cids = body["data"]["cids"];
      cids.forEach((item) => _cates.add(Category.fromJson(item)));

      setState(() {});
    }
  }
}
