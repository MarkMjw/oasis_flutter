import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oasis_flutter/config/color_config.dart';
import 'package:oasis_flutter/model/status.dart';
import 'package:oasis_flutter/util/util.dart';

class WaterfallItem extends StatefulWidget {
  Status status;

  WaterfallItem(this.status);

  @override
  State<StatefulWidget> createState() {
    return _WaterfallItemState();
  }
}

class _WaterfallItemState extends State<WaterfallItem> {
  _WaterfallItemState();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: ColorConfig.colorPlaceHolder, borderRadius: BorderRadius.all(Radius.circular(5))),
            child: AspectRatio(
              aspectRatio: widget.status.medias[0].aspectRatioWaterfall(),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: CachedNetworkImage(imageUrl: widget.status.fixCover(), fit: BoxFit.fitWidth),
              ),
            ),
          ),
          Offstage(
            offstage: widget.status.topics.isEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                "#${widget.status.firstTopic()}",
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorConfig.commonColorHighlight, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Offstage(
            offstage: widget.status.fixText().isEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                widget.status.fixText(),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorConfig.commonColor, fontSize: 14),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            height: 24,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.status.user.image,
                    fit: BoxFit.fill,
                    width: 24,
                    height: 24,
                    placeholder: (context, url) => Image.asset("assets/images/default_head.webp", width: 24, height: 24),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.status.user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConfig.commonColorSecond,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: _createIcon("assets/images/discover_btn_like.webp", "assets/images/discover_btn_like.webp",
                      formatNumberZh(widget.status.likeTotal), widget.status.isLike),
                  onTap: () {
                    Fluttertoast.showToast(msg: "点赞👍 +1", backgroundColor: ColorConfig.colorToastBackground);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _createIcon(String icon, String iconChecked, String text, bool isChecked) {
    var url = icon;
    if (isChecked) {
      url = iconChecked;
    }
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(left: 10, right: 3),
      child: Row(
        children: <Widget>[
          Image.asset(url, width: 16, height: 16),
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11,
                color: ColorConfig.commonColorSecond,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
