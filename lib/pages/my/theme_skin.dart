import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ThemeSkin extends StatefulWidget {
  const ThemeSkin({Key? key}) : super(key: key);

  @override
  _ThemeSkinState createState() => _ThemeSkinState();
}

class _ThemeSkinState extends State<ThemeSkin> {
  // 主题集合
  List list = [
    0xff22d47e,
    0xff605af2,
    0xff8682a3,
    0xfffd8f3a,
    0xff11bff1,
    0xff456da1
  ];

  // 选中的主题索引
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    double mWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    return Scaffold(
      body:Column(
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
                      child: Text("主题色",
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
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 26),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      physics: BouncingScrollPhysics(),
                      // IOS的回弹属性
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 主轴一行的数量
                        mainAxisSpacing: 20, // 主轴每行间距
                        crossAxisSpacing: 26, // 交叉轴每行间距
                        childAspectRatio: 1, // item的宽高比
                      ),
                      itemBuilder: (ctx, i) => InkWell(
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color(list[i]),
                                  borderRadius: BorderRadius.circular(14)),
                              child: Visibility(
                                  visible: i == activeIndex ? true : false,
                                  child: Icon(
                                      IconData(0xe645, fontFamily: 'sunfont'),
                                      color: Colors.white,
                                      size: 26))),
                          onTap: () {
                            setState(() {
                              activeIndex = i;
                            });
                          }))))
        ],
      )
    );
  }
}
