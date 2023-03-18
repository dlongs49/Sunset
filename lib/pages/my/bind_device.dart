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
    double mWidth = MediaQuery.of(context).size.width; // 屏幕宽度
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
                    child: Text("体脂秤",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            height: 2.2,
                            decoration: TextDecoration.none)))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 140,
            padding: EdgeInsets.only(bottom: 20),
            color: Color(0xff22d47e),
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/images/tzc.png", width: 70, height: 70),
          ),
        ]),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5, //宽度
                    color: Color(0xffe0e0e0), //边框颜色
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("合并频繁称重记录", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text(
                    "体重间隔30秒内，只保留最后一次",
                    style: TextStyle(fontSize: 12, color: Color(0xffacacac)),
                  )
                ],
              ),
            ),
            InkWell(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5, //宽度
                        color: Color(0xffe0e0e0), //边框颜色
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("蓝牙智能秤操作指南", style: TextStyle(fontSize: 16)),
                      Icon(IconData(0xeb8a, fontFamily: 'sunfont'),
                          color: Color(0xffbdbdbd), size: 14)
                    ],
                  ),
                ),
                onTap: () {
                  print("操作指南>>");
                }),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5, //宽度
                    color: Color(0xffe0e0e0), //边框颜色
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("蓝牙地址", style: TextStyle(fontSize: 16)),
                  Text("20230318",
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 14,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Spacer(flex: 1),
            InkWell(
                borderRadius: new BorderRadius.all(new Radius.circular(30.0)), // 点击水波纹是圆角的，默认是矩形的
                child: Container(
                  alignment: Alignment(0, 0),
                  width: mWidth - 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Color(0xffe82916)),
                      borderRadius: BorderRadius.circular(30)),
                  child: Align(
                      child: Text("解除绑定",
                          style: TextStyle(
                              color: Color(0xffe82916),
                              fontSize: 20,
                              fontWeight: FontWeight.w600))),
                ),
                onTap: () {
                  print("绑定 & 解除绑定 >>");
                }),
            SizedBox(height: 30)
          ],
        ))
      ],
    );
  }
}
