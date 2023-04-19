import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custom/CustomLinearProgressIndicator.dart';

class ShopDetail extends StatefulWidget {
  final arguments;
  const ShopDetail({Key? key, this.arguments}) : super(key: key);
  @override
  State<ShopDetail> createState() =>  _ShopDetailState(arguments:this.arguments);
}

class _ShopDetailState extends State<ShopDetail> {
  final arguments;
  _ShopDetailState({this.arguments});
  String url = "";

  @override
  void initState() {
    super.initState();
    url = arguments["url"].toString();
    setState(() {});
  }

  // H5 加载进度
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomTabBar(title: "好物详情", bgColor: null, fontColor: null),
            progress != 1.0
                ? CustomLinearProgressIndicator(value: progress)
                : Container(height: 4),
            Expanded(
                child: Container(
                    color: Color(0xFFF6F7FB),
                    child: WebView(
                        initialUrl:
                            url != "" ? url : "https://main.m.taobao.com/",
                        javascriptMode: JavascriptMode.unrestricted,
                        onProgress: (int gress) {
                          progress = (gress / 100);
                          setState(() {});
                        }))),
          ],
        ));
  }
}
