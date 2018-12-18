import 'package:flutter/material.dart';
import 'package:flutter_app/config/color_config.dart';
import 'package:flutter_app/page/home_page.dart';
import 'package:flutter_app/page/mine_page.dart';
import 'package:flutter_app/page/money_page.dart';
import 'package:flutter_app/page/story_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _tabIndex = 0;
  var tabTitles;
  var tabImages;

  var _pages;
  var pageController;

  @override
  void initState() {
    initTab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          _pages[0],
          _pages[1],
          _pages[2],
          _pages[3],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getTabIcon(0), title: getTabText(0)),
          BottomNavigationBarItem(icon: getTabIcon(1), title: getTabText(1)),
          BottomNavigationBarItem(icon: getTabIcon(2), title: getTabText(2)),
          BottomNavigationBarItem(icon: getTabIcon(3), title: getTabText(3)),
        ],
        currentIndex: _tabIndex,
        fixedColor: ColorConfig.colorPrimary,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
          pageController.jumpToPage(_tabIndex);
        },
      ),
    );
  }

  Widget getTabIcon(int curIndex) {
    var image;
    if (curIndex == _tabIndex) {
      image = tabImages[curIndex][1];
    } else {
      image = tabImages[curIndex][0];
    }
    return Center(child: image);
  }

  Color getTabTextColor(int curIndex) {
    var color;
    if (curIndex == _tabIndex) {
      color = ColorConfig.colorPrimary;
    } else {
      color = Color(0x80000000);
    }
    return color;
  }

  Widget getTabText(int curIndex) {
    return Text(
      tabTitles[curIndex],
      style: TextStyle(
        color: getTabTextColor(curIndex),
      ),
    );
  }

  void initTab() {
    tabTitles = ['首页', '故事', '金币', '我的'];
    tabImages = [
      [getTabImage('assets/images/video.png'), getTabImage('assets/images/video_selected.png')],
      [getTabImage('assets/images/story.png'), getTabImage('assets/images/story_selected.png')],
      [getTabImage('assets/images/money.png'), getTabImage('assets/images/money_selected.png')],
      [getTabImage('assets/images/mine.png'), getTabImage('assets/images/mine_selected.png')],
    ];
    _pages = [HomePage(), StoryPage(), MoneyPage(), MinePage()];
    pageController = PageController(initialPage: _tabIndex, keepPage: true);
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 32.0, height: 32.0);
  }
}
