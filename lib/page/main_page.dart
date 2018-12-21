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
    _initTab();
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
          _buildItem(0),
          _buildItem(1),
          _buildItem(2),
          _buildItem(3),
        ],
        currentIndex: _tabIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
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

  BottomNavigationBarItem _buildItem(int index) {
    return BottomNavigationBarItem(
        icon: tabImages[index][index == _tabIndex ? 1 : 0],
        title: Text(
          tabTitles[index],
          style: TextStyle(
            color: index == _tabIndex ? ColorConfig.colorPrimary : Color(0x80000000),
          ),
        ));
  }

  void _initTab() {
    tabTitles = ['首页', '故事', '金币', '我的'];
    tabImages = [
      [_getTabImage('assets/images/video.png'), _getTabImage('assets/images/video_selected.png')],
      [_getTabImage('assets/images/story.png'), _getTabImage('assets/images/story_selected.png')],
      [_getTabImage('assets/images/money.png'), _getTabImage('assets/images/money_selected.png')],
      [_getTabImage('assets/images/mine.png'), _getTabImage('assets/images/mine_selected.png')],
    ];
    _pages = [HomePage(), StoryPage(), MoneyPage(), MinePage()];
    pageController = PageController(initialPage: _tabIndex, keepPage: true);
  }

  Image _getTabImage(path) {
    return new Image.asset(path);
  }
}
