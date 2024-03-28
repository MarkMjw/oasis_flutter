import 'package:flutter/material.dart';
import 'package:oasis_flutter/config/api.dart';
import 'package:oasis_flutter/config/color_config.dart';
import 'package:oasis_flutter/model/status.dart';
import 'package:oasis_flutter/widget/feed_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var _items = [];
  var cursor = "-1";
  var _hasMore = true;
  final ScrollController _scrollController = ScrollController();

  _HomePageState() {
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;
      if (maxScroll == pixels && _hasMore) {
        // scroll to bottom, get next page data
        _loadData(false);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadData(true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("关注")),
        body: RefreshIndicator(
            color: ColorConfig.commonColorHighlight,
            backgroundColor: ColorConfig.background1,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _items.length * 2,
              itemBuilder: (BuildContext context, int position) {
                if (position.isOdd) {
                  if (position == _items.length * 2 - 1) {
                    if (_hasMore) {
                      return _buildLoadMore();
                    } else {
                      return Container();
                    }
                  } else {
                    return const Divider(color: Colors.transparent, height: 5);
                  }
                }

                final index = position ~/ 2;
                return _buildRow(index);
              },
            ),
            onRefresh: () async {
              cursor = "-1";
              _loadData(true);
            }));
  }

  Widget _buildRow(int position) {
    Status status = _items[position];
    return FeedItem(status);
  }

  Widget _buildLoadMore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 24,
          height: 24,
          margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
          child: CircularProgressIndicator(color: ColorConfig.commonColorHighlight, strokeWidth: 2),
        ),
        Text(
          "加载中...",
          style: TextStyle(
            color: ColorConfig.commonColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Future<void> _loadData(bool isRefresh) async {
    String url = "timeline/following_and_card?cursor=$cursor&count=6";
    final response = await dio.get(url);
    final body = response.data;
    final int code = body["code"];
    if (code == 0) {
      cursor = body["data"]["next_cursor"];
      _hasMore = cursor != "0";

      final statuses = body["data"]["statuses"];
      var items = [];
      statuses.forEach((item) => items.add(Status.fromJson(item)));

      setState(() {
        if (isRefresh) {
          _items = items;
        } else {
          _items.addAll(items);
        }
      });
    }
  }
}
