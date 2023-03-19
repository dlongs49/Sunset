import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Mall extends StatefulWidget {
  const Mall({Key? key}) : super(key: key);

  @override
  _MallState createState() => _MallState();
}

class _MallState extends State<Mall> {
  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    double mWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Expanded(
          child: Column(
        children: [
          Column(children: [
            Container(
              height: topBarHeight,
              color: Color(0xffffffff),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 46.0,
              color: Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.centerLeft,
                          child: Icon(IconData(0xec8e, fontFamily: 'sunfont'),
                              color: Colors.black, size: 18.0)),
                      behavior: HitTestBehavior.opaque, // 点击整个区域有响应事件，
                      onTap: () {
                        print("返回上一页");
                        Navigator.of(context).pop();
                      }),
                  SizedBox(width: (mWidth / 2) - 74),
                  // 使得文字居中，屏幕宽度 - 内边距 15+15 - 容器的宽度 40
                  Text("商城",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          decoration: TextDecoration.none))
                ],
              ),
            ),
          ]),
          Expanded(
              child: (Container(
                  color: Color(0xFFF6F7FB),
                  child: WebviewScaffold(
                      url: 'https://main.m.taobao.com/',
                      withZoom: false,
                      // 是否缩放
                      withLocalStorage: true,
                      withJavascript: true,
                      hidden: false,
                      //等待页面加载时显示其他小部件hiden配合initialChild使用
                      initialChild: Center(
                          child: CupertinoActivityIndicator(
                        radius: 15.0,
                        animating: true,
                      )))))),
        ],
      )),
    );
  }
}