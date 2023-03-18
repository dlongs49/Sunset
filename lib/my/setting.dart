import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List card1 = [
    {"title": "账号与安全", "type": 0},
    {"title": "消息推送设置", "type": 0},
    {"title": "个性化服务", "type": 0},
    {"title": "单位设置", "type": 0},
    {"title": "语音播报", "type": 1},
  ];
  List card2 = [
    {"title": "用户协议", "type": 0},
    {"title": "隐私政策", "type": 0},
    {"title": "儿童个人信息保护规则及监护人须知", "type": 0},
    {"title": "第三方SDK列表", "type": 0},
    {"title": "个人信息收集清单", "type": 0},
  ];
  List card3 = [
    {"title": "清除缓存", "type": 1},
    {"title": "社区规范", "type": 0},
    {"title": "关于我们", "type": 0},
    {"title": "设备授权", "type": 0}
  ];

  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    double mWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    return Container(
      color: Colors.white,
      child: Column(
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
          Expanded(
              child: MediaQuery.removePadding(
                  // 去除顶部留白
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView(
                      padding: EdgeInsets.only(bottom: 40),
                      physics: BouncingScrollPhysics(), // IOS的回弹属性
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xfff3f3f3)))),
                            child: Column(
                                children: card1.asMap().entries.map((enry) {
                              int idx = enry.key;
                              final item = enry.value;
                              return InkWell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 36),
                                    child: Row(
                                      children: [
                                        Text(item['title'],
                                            style: TextStyle(fontSize: 16)),
                                        SizedBox(width: 10),
                                        Spacer(flex: 1),
                                        Icon(
                                            IconData(0xeb8a,
                                                fontFamily: "sunfont"),
                                            size: 13,
                                            color: Color(0xffbababa))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    print(item["title"]);
                                  });
                            }).toList())),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xfff3f3f3)))),
                            child: Column(
                                children: card2.asMap().entries.map((enry) {
                              int idx = enry.key;
                              final item = enry.value;
                              return InkWell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 36),
                                    child: Row(
                                      children: [
                                        Text(item['title'],
                                            style: TextStyle(fontSize: 16)),
                                        SizedBox(width: 10),
                                        Spacer(flex: 1),
                                        Icon(
                                            IconData(0xeb8a,
                                                fontFamily: "sunfont"),
                                            size: 13,
                                            color: Color(0xffbababa))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    print(item["title"]);
                                  });
                            }).toList())),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.only(bottom: 40),
                            child: Column(
                                children: card3.asMap().entries.map((enry) {
                              int idx = enry.key;
                              final item = enry.value;
                              return InkWell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 36),
                                    child: Row(
                                      children: [
                                        Text(item['title'],
                                            style: TextStyle(fontSize: 16)),
                                        SizedBox(width: 10),
                                        Spacer(flex: 1),
                                        Icon(
                                            IconData(0xeb8a,
                                                fontFamily: "sunfont"),
                                            size: 13,
                                            color: Color(0xffbababa))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    print(item["title"]);
                                  });
                            }).toList())),
                        InkWell(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              height: 50,
                              alignment: Alignment(0, 0),
                              // 子元素水平垂直居中
                              decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  border: Border.all(
                                      width: 1, color: Color(0xffff0000)),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text("退出登录",
                                  style: TextStyle(
                                      color: Color(0xffff0000), fontSize: 20)),
                            ),
                            onTap: () {
                              print("退出登录>>");
                            })
                      ]))),
        ],
      ),
    );
  }
}
