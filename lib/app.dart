import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sunset/pages/device/bind_device.dart';
/* 底部导航对应的页面 */
import 'package:sunset/pages/nav_page/home.dart'; // 首页
import 'package:sunset/pages/nav_page/community.dart'; // 社区
import 'package:sunset/pages/device/bind_device.dart'; // 绑定设备
import 'package:sunset/pages/nav_page/find.dart'; // 发现
import 'package:sunset/pages/nav_page/my.dart'; // 我的

// 路由文件
import 'package:sunset/routes/index.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 抽离底部导航栏Icon
  @override
  Widget bomIcon(icon, color) {
    return (Icon(IconData(icon, fontFamily: 'sunfont'), color: Color(color)));
  }

  int currentIndex = 0; // 导航索引
  List<Widget> pages = [Home(), Community(), Container(), Find(), My()];

  // 更改底部导航栏索引
  @override
  void changeNavBar(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, "bindDevice", arguments: {"base": "root"});
    } else {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          body:
              // 这里使用 IndexedStack 实现保持原页面状态 【性能有开销】
              IndexedStack(index: currentIndex, children: pages),
          // body: MyProfile(),
        ));
  }
}
