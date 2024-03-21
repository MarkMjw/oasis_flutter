import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:oasis_flutter/config/api.dart';
import 'package:oasis_flutter/config/color_config.dart';
import 'package:oasis_flutter/model/status.dart';
import 'package:oasis_flutter/widget/waterfall_item.dart';

class ChannelPage extends StatefulWidget {
  final int cid;

  const ChannelPage({super.key, this.cid = 0});

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> with AutomaticKeepAliveClientMixin {
  var _items = [];
  var cursor = "-1";
  var _hasMore = true;
  var _loading = false;
  final ScrollController _scrollController = ScrollController();

  _ChannelPageState() {
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;
      if (maxScroll == pixels && _hasMore) {
        // scroll to bottom, get next page data
        setState(() {
          _loading = true;
        });
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
    super.build(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: RefreshIndicator(
              color: ColorConfig.commonColorHighlight,
              backgroundColor: ColorConfig.background1,
              child: buildWaterfall(),
              onRefresh: () async {
                cursor = "-1";
                _loadData(true);
              },
            ),
          ),
          Offstage(
            offstage: !_loading,
            child: _buildLoadMore(),
          )
        ],
      ),
    );
  }

  Widget buildWaterfall() {
    return MasonryGridView.count(
      controller: _scrollController,
      padding: const EdgeInsets.all(5),
      crossAxisCount: 2,
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) {
        Status status = _items[index];
        return WaterfallItem(status);
      },
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
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

  void _loadData(bool isRefresh) async {
    String url = "timeline/discovery?channel_id=${widget.cid}&cursor=$cursor&count=20&${Api.COMMON_PARAM}&is_recommend_channel=${widget.cid == 0}";
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
        _loading = false;
        if (isRefresh) {
          _items = items;
        } else {
          _items.addAll(items);
        }
      });
    }
  }
}
