import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/provider/global.dart';

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
    double mWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    final skinColor = Provider.of<Global>(context).color;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title: "家庭成员", bgColor: null, fontColor: null),
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
                          color: Color(skinColor),
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
