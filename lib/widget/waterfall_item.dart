import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oasis_flutter/config/color_config.dart';
import 'package:oasis_flutter/model/status.dart';

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
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: ColorConfig.colorPlaceHolder, borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: AspectRatio(
                    aspectRatio: widget.status.medias[0].aspectRatio(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: CachedNetworkImage(imageUrl: widget.status.cover, fit: BoxFit.fitWidth),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Offstage(
                    offstage: widget.status.recommendReason.isNotEmpty,
                    child: Container(
                      width: double.infinity,
                      color: Colors.black26,
                      child: Center(
                        child: Text(
                          widget.status.recommendReason,
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Offstage(
            offstage: widget.status.topics.isNotEmpty,
            child: Container(
              child: Center(
                child: Text(
                  widget.status.topics.isNotEmpty ? widget.status.topics[0].name : "",
                  style: TextStyle(color: ColorConfig.commonColorHighlight, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Offstage(
            offstage: widget.status.title.isNotEmpty || widget.status.text.isNotEmpty,
            child: Container(
              child: Center(
                child: Text(
                  widget.status.title.isNotEmpty ? widget.status.title : widget.status.text,
                  style: TextStyle(color: ColorConfig.commonColor, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
