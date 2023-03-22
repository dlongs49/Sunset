import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SetAccnum extends StatefulWidget {
  const SetAccnum({Key? key}) : super(key: key);

  @override
  State<SetAccnum> createState() => _SetAccnumState();
}

class _SetAccnumState extends State<SetAccnum> {
  void toPage(String path) {
    Navigator.pushNamed(context, path);
  }

  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Column(children: [
              Container(
                height: topBarHeight,
                color: Color(0xffffffff),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 15, right: 15),
                height: 46.0,
                color: Color(0xffffffff),
                child: Stack(
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
                          // Navigator.of(context).pop();
                        }),
                    Positioned(
                        left: 0,
                        right: 0,
                        child: Text("设置",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                height: 2.2,
                                decoration: TextDecoration.none)))
                  ],
                ),
              )
            ]),
            Column(
              children: [
                InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Row(
                        children: [
                          Icon(Icons.phone_iphone_outlined,
                              color: Color(0xff5e5e5e), size: 22),
                          SizedBox(width: 12),
                          Text("手机号", style: TextStyle(fontSize: 16)),
                          Spacer(flex: 1),
                          Text("18794388410",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffb6b6b6))),
                          SizedBox(width: 10),
                          Icon(Icons.chevron_right_outlined,
                              color: Color(0xffc1c1c1), size: 22),
                        ],
                      ),
                    ),
                    onTap: () => toPage("bindPhone")),
                InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xffefefef)))),
                      child: Row(
                        children: [
                          Icon(Icons.lock_outlined,
                              color: Color(0xff5e5e5e), size: 22),
                          SizedBox(width: 12),
                          Text("设置密码", style: TextStyle(fontSize: 16)),
                          Spacer(flex: 1),
                          Icon(Icons.chevron_right_outlined,
                              color: Color(0xffc1c1c1), size: 22),
                        ],
                      ),
                    ),
                    onTap: () => toPage("setPwd")),
                SizedBox(height: 20),
                InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Row(
                        children: [
                          Icon(Icons.power_settings_new,
                              color: Color(0xffff1a1a), size: 22),
                          SizedBox(width: 12),
                          Text("注销账号", style: TextStyle(fontSize: 16)),
                          Spacer(flex: 1),
                          Text("永久删除账号",
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xffc1c1c1))),
                          SizedBox(width: 10),
                          Icon(Icons.chevron_right_outlined,
                              color: Color(0xffc1c1c1), size: 22),
                        ],
                      ),
                    ),
                    onTap: () => toPage("dsyAccnum")),
              ],
            )
          ],
        ));
  }
}
