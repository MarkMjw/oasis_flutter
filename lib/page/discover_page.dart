import 'package:flutter/material.dart';
import 'package:oasis_flutter/config/api.dart';
import 'package:oasis_flutter/config/color_config.dart';
import 'package:oasis_flutter/model/category.dart';

import 'channel_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with TickerProviderStateMixin {
  final List<Category> _cates = [];
  TabController? _controller;

  @override
  void initState() {
    _controller = TabController(length: _cates.length, vsync: this);
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
        title: const Text("发现"),
        bottom: TabBar(
          controller: _controller,
          tabs: _cates.map((cate) {
            return Tab(text: cate.name);
          }).toList(),
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: ColorConfig.commonColorHighlight,
          indicatorWeight: 2,
          indicatorPadding: const EdgeInsets.only(bottom: 0.0),
          labelColor: ColorConfig.commonColorHighlight,
          labelStyle: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          unselectedLabelColor: ColorConfig.commonColor,
          unselectedLabelStyle: const TextStyle(fontSize: 16.0),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _cates.map((cate) {
          return ChannelPage(cid: cate.id);
        }).toList(),
      ),
    );
  }

  void _fetchTabs() async {
    String url = "${Api.HOST}/channel/list?${Api.COMMON_PARAM}";
    print(url);
    final response = await dio.get(url);
    final body = response.data;
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
