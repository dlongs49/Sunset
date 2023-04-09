import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with TickerProviderStateMixin {
  late final AnimationController controllAnimate =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat(reverse: true);
  late final Animation<double> opAnimation =
      Tween<double>(begin: 0, end: 1).animate(controllAnimate);
// 打开蓝牙，保持网络畅通 / 光脚站立在秤上
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image.network(
        "https://th.bing.com/th/isd/OIP.mH9YLFEL5YdVxJM82mjVJQHaEo?pid=ImgDet&rs=1",
        width: double.infinity,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (ctx,err,stackTrace) => Image.asset(
        'assets/images/400x400.jpg',//默认显示图片
            height: 50,
        width: double.infinity)
    ));
  }
}
