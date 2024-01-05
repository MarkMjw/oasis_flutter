import 'package:flutter/material.dart';
import 'package:oasis_flutter/config/color_config.dart';
import 'package:oasis_flutter/page/home_page.dart';
import 'package:oasis_flutter/page/mine_page.dart';
import 'package:oasis_flutter/page/message_page.dart';
import 'package:oasis_flutter/page/discover_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          _pages[0],
          _pages[1],
          _pages[2],
          _pages[3],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorConfig.colorPrimary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          _buildItem(0),
          _buildItem(1),
          _buildItem(2),
          _buildItem(3),
        ],
        currentIndex: _tabIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
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
        label: "",
    );
  }

  void _initTab() {
    tabImages = [
      [_getTabImage('assets/images/main_nav_home_normal.webp'), _getTabImage('assets/images/main_nav_home_hl.webp')],
      [_getTabImage('assets/images/main_nav_discover_normal.webp'), _getTabImage('assets/images/main_nav_discover_hl.webp')],
      [_getTabImage('assets/images/main_nav_message_normal.webp'), _getTabImage('assets/images/main_nav_message_hl.webp')],
      [_getTabImage('assets/images/main_nav_mine_normal.webp'), _getTabImage('assets/images/main_nav_mine_hl.webp')],
    ];
    _pages = [const HomePage(), const DiscoverPage(), const MoneyPage(), const MinePage()];
    pageController = PageController(initialPage: _tabIndex, keepPage: true);
  }

  Image _getTabImage(path) {
    return Image.asset(path, width: 24, height: 24);
  }
}
