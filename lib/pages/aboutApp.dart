import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart'; // 弹框插件

class AboutApp extends StatefulWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  void toPage(path) {
    print(path);
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
                        Navigator.of(context).pop();
                      }),
                  Positioned(
                      left: 0,
                      right: 0,
                      child: Text("关于App",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              height: 2.2,
                              decoration: TextDecoration.none)))
                ],
              ),
            ),
          ]),
          SizedBox(height: 50),
          Align(
            child: Image.asset(
              "assets/images/3044.jpg",
              width: 60,
              height: 60,
            ),
          ),
          SizedBox(height: 50),
          Align(
            child: Text("Sunset",
                style: TextStyle(
                    color: Color(0xff22d47e),
                    fontSize: 23,
                    fontWeight: FontWeight.w800)),
          ),
          SizedBox(height: 10),
          Align(
            child: Text("v1.0.1",
                style: TextStyle(
                    color: Color(0xffbdbdbd),
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: 30),
          InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("码云", style: TextStyle(fontSize: 18)),
                        Icon(Icons.chevron_right_outlined,
                            color: Color(0xffc2c2c2), size: 24)
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () => toPage('gitee')),
          InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("GitHub", style: TextStyle(fontSize: 18)),
                        Icon(Icons.chevron_right_outlined,
                            color: Color(0xffc2c2c2), size: 24)
                      ],
                    )
                  ],
                ),
              ),
              onTap: () => toPage('github')),
          InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("个站", style: TextStyle(fontSize: 18)),
                        Icon(Icons.chevron_right_outlined,
                            color: Color(0xffc2c2c2), size: 24)
                      ],
                    )
                  ],
                ),
              ),
              onTap: () => toPage('website')),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 0.5, color: Color(0xffe7e7e8))))),
          SizedBox(height: 26),
          Container(
              width: double.infinity,
              height: 80,
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xfff1f1f1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                  "该软件仅用于学习开发使用，请勿在商业用途使用,如有侵权请立即联系作者 dillonl.dl49@gmail.com",
                  style: TextStyle(fontSize: 13, height: 1.6)))
        ],
      ),
    );
  }
}
