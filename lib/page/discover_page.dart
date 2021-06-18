import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oasis_flutter/config/api.dart';
import 'package:oasis_flutter/config/color_config.dart';
import 'package:oasis_flutter/model/category.dart';
import 'package:http/http.dart';

import 'channel_page.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with TickerProviderStateMixin {
  List<Category> _cates = [];
  TabController? _controller;

  @override
  void initState() {
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
        title: Text("发现"),
        bottom: TabBar(
          controller: _controller,
          tabs: _cates.map((cate) {
            return Tab(text: cate.name);
          }).toList(),
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: ColorConfig.commonColorHighlight,
          indicatorWeight: 2,
          indicatorPadding: EdgeInsets.only(bottom: 0.0),
          labelColor: ColorConfig.commonColorHighlight,
          labelStyle: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          unselectedLabelColor: ColorConfig.commonColor,
          unselectedLabelStyle: new TextStyle(fontSize: 16.0),
        ),
      ),
      body: TabBarView(
        children: _cates.map((cate) {
          return ChannelPage(cid: cate.id);
        }).toList(),
        controller: _controller,
      ),
    );
  }

  void _fetchTabs() async {
    String url = "${Api.HOST}/channel/list?${Api.COMMON_PARAM}";
    print(url);
    Response response = await get(Uri.parse(url), headers: Api.COMMON_HEADER);

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
