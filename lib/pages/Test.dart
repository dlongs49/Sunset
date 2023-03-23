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
        body: FadeTransition(
            opacity: opAnimation,
            child: Container(
              width: 200,
              height: 200,
              margin: EdgeInsets.only(top: 300,left: 100),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(200)
              ),
            )));
  }
}
