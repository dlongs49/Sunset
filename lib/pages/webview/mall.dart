import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Mall extends StatefulWidget {
  const Mall({Key? key}) : super(key: key);

  @override
  _MallState createState() => _MallState();
}

class _MallState extends State<Mall> {
  // H5 加载进度
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomTabBar(title: "香豆商城", bgColor: null, fontColor: null),
            progress != 1.0
                ? LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Color(0xffffffff),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff22d47e)),
                  )
                : Container(height: 4),
            Expanded(
                child: Container(
                    color: Color(0xFFF6F7FB),
                    child: WebView(
                        initialUrl: "https://main.m.taobao.com/",
                        javascriptMode: JavascriptMode.unrestricted,
                        onProgress: (int gress) {
                          progress = (gress / 100);
                          setState(() {});
                        }))),
          ],
        ));
  }
}
