import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_flutter/config/color_config.dart';
import 'package:oasis_flutter/model/status.dart';
import 'package:oasis_flutter/util/util.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class FeedItem extends StatefulWidget {
  Status status;

  FeedItem(this.status);

  @override
  State<StatefulWidget> createState() {
    return _FeedItemSate(status);
  }
}

class _FeedItemSate extends State<FeedItem> {
  Status status;

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  _FeedItemSate(this.status);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAuthorWidget(),
        buildMediaWidget(),
        buildToolWidget(),
        buildContentWidget(),
      ],
    );
  }

  Container buildAuthorWidget() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.only(left: 15, right: 15),
      width: double.infinity,
      height: 45,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: status.user.image,
              fit: BoxFit.fill,
              width: 36,
              height: 36,
              placeholder: (context, url) => Image.asset("assets/images/default_head.webp", width: 36, height: 36),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  status.user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConfig.commonColor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 2),
                alignment: Alignment.centerLeft,
                child: Text(
                  formatTime(status.createTime),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConfig.commonColorSecond,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildMediaWidget() {
    var item = status.medias;
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: status.medias[0].aspectRatio(),
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(color: ColorConfig.colorPlaceHolder),
                  child: ClipRect(
                    child: CachedNetworkImage(imageUrl: item[index].url, fit: BoxFit.fitWidth),
                  ),
                );
              },
              itemCount: item.length,
              onPageChanged: (int index) {
                _currentPageNotifier.value = index;
              },
            ),
          ),
          buildCircleIndicator(item.length),
        ],
      ),
    );
  }

  Widget buildCircleIndicator(int size) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: size,
          size: 4,
          dotSpacing: 4,
          selectedSize: 6,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }

  Container buildToolWidget() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 8),
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [buildPraiseWidget(), buildShareWidget()],
      ),
    );
  }

  Row buildPraiseWidget() {
    var likeCountMargin = 40.0;
    var len = status.likes.length;
    if (len == 2) {
      likeCountMargin = 20.0;
    } else if (len == 1) {
      likeCountMargin = 5.0;
    } else if (len == 0) {
      likeCountMargin = 0.0;
    } else {
      likeCountMargin = 40.0;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Offstage(
                offstage: status.likes.length <= 0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: status.likeUser(0).image,
                      fit: BoxFit.fill,
                      width: 20,
                      height: 20,
                      placeholder: (context, url) => Image.asset("assets/images/default_head.webp", width: 20, height: 20),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 17,
              top: 0,
              child: Offstage(
                offstage: status.likes.length <= 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: status.likeUser(1).image,
                      fit: BoxFit.fill,
                      width: 20,
                      height: 20,
                      placeholder: (context, url) => Image.asset("assets/images/default_head.webp", width: 20, height: 20),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 34,
              top: 0,
              child: Offstage(
                offstage: status.likes.length <= 2,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: status.likeUser(2).image,
                      fit: BoxFit.fill,
                      width: 20,
                      height: 20,
                      placeholder: (context, url) => Image.asset("assets/images/default_head.webp", width: 20, height: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Offstage(
          offstage: status.likeTotal <= 0,
          child: Container(
            margin: EdgeInsets.only(left: likeCountMargin),
            child: Text(
              "等${formatNumberZh(status.likeTotal)}次赞",
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: ColorConfig.commonColor, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Widget buildShareWidget() {
    var likeImage = "assets/images/feed_like.webp";
    if (status.isLike) {
      likeImage = "assets/images/feed_liked.webp";
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 15),
          child: Image.asset(likeImage, width: 24, height: 24),
        ),
        Container(
          margin: EdgeInsets.only(right: 15),
          child: Image.asset("assets/images/feed_comment.webp", width: 24, height: 24),
        ),
        Image.asset("assets/images/feed_share.webp", width: 24, height: 24),
      ],
    );
  }

  Container buildContentWidget() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Offstage(
            offstage: status.topics.isEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                "#${status.firstTopic()}",
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorConfig.commonColorHighlight, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Offstage(
            offstage: status.title.isEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                status.title,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorConfig.commonColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Offstage(
            offstage: status.text.isEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                status.text,
                textAlign: TextAlign.left,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorConfig.commonColor, fontSize: 15),
              ),
            ),
          ),
          Offstage(
            offstage: status.commentTotal <= 0,
            child: Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                "共${formatNumberZh(status.commentTotal)}条评论",
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorConfig.commonColorSecond, fontSize: 13),
              ),
            ),
          ),
          Offstage(
            offstage: status.comments.isEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    status.commentUser(0).name,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: ColorConfig.commonColorSecond, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      status.commentText(0),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ColorConfig.commonColorSecond, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Offstage(
            offstage: status.comments.length <= 1,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    status.commentUser(1).name,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: ColorConfig.commonColorSecond, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      status.commentText(1),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ColorConfig.commonColorSecond, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _createIcon(String icon, String iconChecked, bool isChecked) {
    var url = icon;
    if (isChecked) {
      url = iconChecked;
    }
    return Container(
      child: Image.asset(url, width: 22, height: 22),
    );
  }
}
