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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<Category> _cates = [];
  TabController? _controller;

  @override
  void initState() {
    _initTabs();
    _fetchTabs();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          controller: _controller,
          tabs: _cates.map((cate) {
            return Tab(text: cate.name);
          }).toList(),
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.white,
          indicatorWeight: 2,
          indicatorPadding: EdgeInsets.only(bottom: 0.0),
          labelColor: Colors.white,
          labelStyle: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          unselectedLabelColor: ColorConfig.colorText1,
          unselectedLabelStyle: new TextStyle(fontSize: 16.0),
        ),
      ),
      body: TabBarView(
        children: _cates.map((cate) {
          return VideoPage(cid: cate.id);
        }).toList(),
        controller: _controller,
      ),
    );
  }

  void _initTabs() {
    var cate1 = Category();
    cate1.id = 2;
    cate1.name = "精选";

    var cate2 = Category();
    cate2.id = 16;
    cate2.name = "明星";

    var cate3 = Category();
    cate3.id = 18;
    cate3.name = "摄影";

    var cate4 = Category();
    cate4.id = 10;
    cate4.name = "旅行";

    var cate5 = Category();
    cate5.id = 12;
    cate5.name = "运动";

    _cates.add(cate1);
    _cates.add(cate2);
    _cates.add(cate3);
    _cates.add(cate4);
    _cates.add(cate5);

    _controller = TabController(length: _cates.length, vsync: this);
  }

  void _fetchTabs() async {
    // 异步请求回来的数据无法显示
    String url = "${Api.HOST}/channel/list?${Api.COMMON_PARAM}";
    print(url);
    Response response = await get(Uri.parse(url), headers: {
      "gsid": "O1dGmriqebHVuxbd6uJCMS5AbuPtmezAlQJktRL3cFJvY8hh5aVfcF1lLTL20uOmSKP3/ifRf9bSAlkUWLGPlcVRUnP52P6H6KuAq0qUEt0kB4r4zrIa2+XKJEKCzluH",
      "User-Agent": "HUAWEI-LIO-AL00__oasis__3.6.5__Android__Android10"
    });

    final body = json.decode(response.body);
    final int code = body["code"];
    if (code == 0) {
      final cates = body["data"]["channels"];
      _cates.clear();
      cates.forEach((item) => _cates.add(Category.fromJson(item)));

      setState(() {
        _controller = TabController(length: _cates.length, vsync: this);
      });
    }
  }
}
