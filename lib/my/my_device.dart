import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyDevice extends StatefulWidget {
  const MyDevice({Key? key}) : super(key: key);

  @override
  _MyDeviceState createState() => _MyDeviceState();
}

class _MyDeviceState extends State<MyDevice> {
  List list = [
    {
      "image": "assets/images/02.png",
      "title": "温湿度计",
      "desc": "实时掌握温度数据",
      "state": 0
    },
    {
      "image": "assets/images/01.png",
      "title": "智能跳绳",
      "desc": "健康生活享跳自我",
      "state": 0
    },
    {
      "image": "assets/images/04.png",
      "title": "智能体脂秤",
      "desc": "科学管理好身材",
      "state": 1
    }
  ];

  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    return Column(
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
                    child: Text("设备管理",
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
        Expanded(
            child: MediaQuery.removePadding(
                // 去除顶部留白
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  // ClampingScrollPhysics 安卓滑动效果 BouncingScrollPhysics IOS滑动效果
                  itemCount: list.length,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          padding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 16),
                          decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Image.asset(list[i]["image"],
                                  width: 46, height: 46, fit: BoxFit.cover),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(list[i]["title"],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800)),
                                  SizedBox(height: 5),
                                  Text(
                                    list[i]["desc"],
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffb4b4b4)),
                                  )
                                ],
                              ),
                              Spacer(flex: 1),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Color(list[i]["state"] == 1
                                            ? 0xff22d47e
                                            : 0xffffffff),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            width: 1.0,
                                            color: Color(0xff22d47e))),
                                    child: Text(
                                        list[i]["state"] == 1 ? "已绑定" : "未绑定",
                                        style: TextStyle(
                                            color: Color(list[i]["state"] == 1
                                                ? 0xffffffff
                                                : 0xff22d47e),
                                            fontSize: 10)),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    IconData(0xeb8a, fontFamily: 'sunfont'),
                                    size: 12,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          print(list[i]);
                        });
                  },
                )))
      ],
    );
  }
}
