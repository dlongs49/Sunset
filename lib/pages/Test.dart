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

  void showIsLogDialog(BuildContext context) {
    final width = MediaQueryData.fromWindow(window).size.width;
    showDialog(
        context: context,
        builder: (ctx) => Container(
              color: Color(0x7e000000),
              child: Center(
                  child: Container(
                width: width - 80,
                height: 150,
                padding:
                    EdgeInsets.only(right: 24, left: 24, top: 20, bottom: 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(children: [
                  Text("登录提示",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                  SizedBox(height: 10),
                  Text("暂未登录，请先登录~",
                      style: TextStyle(color: Color(0xff808080), fontSize: 15)),
                  SizedBox(height: 15),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Colors.white,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Text("取消",
                                    style: TextStyle(
                                        color: Color(0xffb8b8b8),
                                        fontSize: 16)),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Material(
                            color: Colors.white,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Text("立即登录",
                                    style: TextStyle(
                                        color: Color(0xff22d47e),
                                        fontSize: 16)),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, "phoneLog");
                              },
                            ),
                          )
                        ],
                      ))
                ]),
              )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InkWell(
      child: Container(
        width: double.infinity,
        height: 400,
      ),
      onTap: () {
        showIsLogDialog(context);
      },
    ));
  }
}
