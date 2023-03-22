import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
/* 底部导航对应的页面 */
import 'package:sunset/pages/nav_page/home.dart'; // 首页
import 'package:sunset/pages/nav_page/community.dart'; // 社区
import 'package:sunset/pages/nav_page/find.dart'; // 发现
import 'package:sunset/pages/nav_page/my.dart'; // 我的

// 路由文件
import 'package:sunset/routes/index.dart';
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // 抽离底部导航栏Icon
  @override
  Widget bomIcon(icon, color) {
    return (Icon(IconData(icon, fontFamily: 'sunfont'), color: Color(color)));
  }

  int currentIndex = 0; // 导航索引
  List<Widget> pages = [Home(), Community(),Find(), Find(), My()];

  // 更改底部导航栏索引
  @override
  void changeNavBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          // 设置沉浸式状态栏文字颜色
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Color.fromRGBO(246, 247, 251, 1),
          // bottomNavigationBar:ConvexAppBar(
          //   items: [
          //     TabItem(icon: Icon(IconData(0xe718,fontFamily: 'sunfont')), title: '首页',),
          //     TabItem(icon: Icon(IconData(0xe8c5,fontFamily: 'sunfont')), title: '社区'),
          //     TabItem(icon: Icon(IconData(0xe718,fontFamily: 'sunfont')), title: '发现'),
          //     TabItem(icon: Icon(IconData(0xe621,fontFamily: 'sunfont')), title: '好物'),
          //     TabItem(icon: Icon(IconData(0xe941,fontFamily: 'sunfont')), title: '我的'),
          //   ],
          //   onTap: (int i) => print('click index=$i'),
          // ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              // 当前选中
              currentIndex: currentIndex,
              // 图标尺寸
              iconSize: 20,
              // 选中的颜色
              fixedColor: Color(0xff000000),
              // 选中的字体大小
              selectedFontSize: 12.0,
              // 未选中的字体大小
              unselectedFontSize: 12.0,
              onTap: (index) {
                changeNavBar(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: bomIcon(0xe718, 0xffb4b7be),
                  activeIcon: bomIcon(0xe718, 0xff262626),
                  label: "首页",
                ),
                BottomNavigationBarItem(
                  icon: bomIcon(0xe8c5, 0xffb4b7be),
                  activeIcon: bomIcon(0xe8c5, 0xff262626),
                  label: "社区",
                ),
                BottomNavigationBarItem(
                  icon: bomIcon(0xe61c, 0xffb4b7be),
                  activeIcon: bomIcon(0xe61c, 0xff262626),
                  label: "称重",
                ),
                BottomNavigationBarItem(
                  icon: bomIcon(0xe621, 0xffb4b7be),
                  activeIcon: bomIcon(0xe621, 0xff262626),
                  label: "发现",
                ),
                BottomNavigationBarItem(
                  icon: bomIcon(0xe941, 0xffb4b7be),
                  activeIcon: bomIcon(0xe941, 0xff262626),
                  label: "我的",
                )
              ]),
          body: pages[currentIndex],
          // body: MyProfile(),
        ));
  }
}
