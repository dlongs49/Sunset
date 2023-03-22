import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:sunset/components/tabbar.dart';

class Mall extends StatefulWidget {
  const Mall({Key? key}) : super(key: key);

  @override
  _MallState createState() => _MallState();
}

class _MallState extends State<Mall> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Expanded(
          child: Column(
        children: [
          CustomTabBar(title: "香豆商城", bgColor: null, fontColor: null),
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
