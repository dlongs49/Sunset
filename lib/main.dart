import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
/* 底部导航对应的页面 */
import './nav_page/home.dart';
import './nav_page/community.dart';
import './nav_page/find.dart';
import './nav_page/my.dart';

import './webview/mall.dart';
import './webview/invite.dart';
import './my/my_device.dart';
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  //透明沉浸式状态栏
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sunset',
        debugShowCheckedModeBanner: false, // 移除右上角 debug 标志
        home: HomePage(),
        routes:{
          "mall":(BuildContext context) => Mall(),
          "invite":(BuildContext context) => Invite(),
        });
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  // 抽离底部导航栏Icon
  Widget bomIcon(icon, color) {
    return (Icon(IconData(icon, fontFamily: 'sunfont'), color: Color(color)));
  }

  int currentIndex = 3; // 导航索引
  List<Widget> pages = [Home(),Community(),Find(),MyDevice()];
  // 更改底部导航栏索引
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
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              // 当前选中
              iconSize: 18,
              // 图标尺寸
              fixedColor: Color(0xff000000),
              // 选中的颜色
              selectedFontSize: 10.0,
              // 选中的字体大小
              unselectedFontSize: 10.0,
              // 未选中的字体大小
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
        ));
  }
}
