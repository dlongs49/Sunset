import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class BindDevice extends StatefulWidget {
  const BindDevice({Key? key}) : super(key: key);

  @override
  _BindDeviceState createState() => _BindDeviceState();
}

class _BindDeviceState extends State<BindDevice> {
  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    return Column(
      children: [
        Column(children: [
          Container(
            height: topBarHeight,
            color: Color(0xff22d47e),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15),
            height: 46.0,
            color: Color(0xff22d47e),
            child: Stack(
              children: [
                GestureDetector(
                    child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Icon(IconData(0xec8e, fontFamily: 'sunfont'),
                            color: Colors.white, size: 18.0)),
                    behavior: HitTestBehavior.opaque, // 点击整个区域有响应事件，
                    onTap: () {
                      print("返回上一页");
                      // Navigator.of(context).pop();
                    }),
                Positioned(
                    left: 0,
                    right: 0,
                    child: Text("设备管理",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            height: 2.2,
                            decoration: TextDecoration.none)))
              ],
            ),
          ),
        ]),
      ],
    );
  }
}
