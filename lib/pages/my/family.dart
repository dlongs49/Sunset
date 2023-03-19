import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Family extends StatefulWidget {
  const Family({Key? key}) : super(key: key);

  @override
  _FamilyState createState() => _FamilyState();
}

class _FamilyState extends State<Family> {
  List list = [
    {"name": "书本书华", "sex": 1},
  ];

  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    double mWidth = MediaQuery.of(context).size.width; // 屏幕宽度
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
                      child: Text("家庭成员",
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
              child: Stack(alignment: Alignment.center, children: [
                list.length != 0 ?
            MediaQuery.removePadding(
                // 去除顶部留白
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 60),
                    physics: BouncingScrollPhysics(), // IOS的回弹属性
                    itemCount: list.length,
                    itemBuilder: (context, i) => Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xfff1f1f1)))),
                          child: Row(
                            children: [
                              Image.asset(
                                list[i]['sex'] == 0
                                    ? "assets/images/women.png"
                                    : "assets/images/man.png",
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(width: 10),
                              Text(list[i]['name'],
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(width: 10),
                              Icon(
                                  IconData(
                                      list[i]['sex'] == 0 ? 0xe632 : 0xe612,
                                      fontFamily: "sunfont"),
                                  size: 13,
                                  color: Color(list[i]['sex'] == 0
                                      ? 0xfffb859d
                                      : 0xff51aefe))
                            ],
                          ),
                        )))
                :Container(child:Align(child: Image.asset("assets/images/none.png"))),
            Positioned(
                bottom: 18,
                child: InkWell(
                    child: Container(
                      width: mWidth - 60,
                      height: 46,
                      alignment: Alignment(0, 0),
                      // 子元素水平垂直居中
                      decoration: BoxDecoration(
                          color: Color(0xff22d47e),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text("添加家庭成员",
                          style: TextStyle(
                              color: Color(0xffffffff), fontSize: 20)),
                    ),
                    onTap: () {
                      print("添加家庭成员>>");
                    }))
          ])),
        ],
      ),
    );
  }
}
