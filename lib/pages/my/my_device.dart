import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/provider/global.dart';

class MyDevice extends StatefulWidget {
  const MyDevice({Key? key, arguments}) : super(key: key);

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

  // 跳转绑定页面
  @override
  void toBind(dynamic params, int index) {
    final item = Map<String, dynamic>.from(
        params); // list中item项转换 Map 否则 item['title'] 报错
    if (index == 2) {
      if (item["state"] == 0) {
        Navigator.pushNamed(context, 'bindDevice');
      } else {
        Navigator.pushNamed(context, 'balance');
      }
    } else {
      // 暂无页面
      Fluttertoast.showToast(
          msg: item["title"],
          toastLength: Toast.LENGTH_SHORT,
          // 停留时长短 & 长
          gravity: ToastGravity.CENTER,
          // 弹框是否居中
          backgroundColor: Color(0xd23b3b3b),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final skinColor = Provider.of<Global>(context).color;
    return Scaffold(
        body: Column(
      children: [
        CustomTabBar(title: "设备管理", bgColor: null, fontColor: null),
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
                    return Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
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
                                            ? skinColor
                                            : 0xffffffff),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            width: 1.0,
                                            color: Color(skinColor))),
                                    child: Text(
                                        list[i]["state"] == 1 ? "已绑定" : "未绑定",
                                        style: TextStyle(
                                            color: Color(list[i]["state"] == 1
                                                ? 0xffffffff
                                                : skinColor),
                                            fontSize: 10)),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    IconData(0xeb8a, fontFamily: 'sunfont'),
                                    size: 12,
                                    color: Color(0xffa3a3a3),
                                  )
                                ],
                              )
                            ],
                          ),
                          onTap: () => toBind(list[i], i)),
                    );
                  },
                )))
      ],
    ));
  }
}
