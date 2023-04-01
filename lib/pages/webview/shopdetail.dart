import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class ShopDetail extends StatefulWidget {
  const ShopDetail({Key? key}) : super(key: key);

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        // child:WebviewScaffold(
        //     url: 'https://main.m.taobao.com/',
        //     withZoom: false,
        //     // 是否缩放
        //     withLocalStorage: true,
        //     withJavascript: true,
        //     hidden: false,
        //     //等待页面加载时显示其他小部件hiden配合initialChild使用
        //     initialChild: Center(
        //         child: CupertinoActivityIndicator(
        //           radius: 15.0,
        //           animating: true,
        //         )))
    );
  }
}
