import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';


class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List card1 = [
    {"title": "账号与安全", "type": 0, "path": "setAccnum"},
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
  bool isSwitch = false;

  @override
  void initState() {
    super.initState();
  }

  void toPage(params) {
    if (params["path"] != null) {
      Navigator.pushNamed(context, params['path']);
    }
  }

  void onCard3(params) {
    if (params['type'] == 1) {

    } else {
      toast(params["title"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title:"设置",bgColor:null,fontColor:null),
          Expanded(
              child: ListView(
                  padding: EdgeInsets.only(bottom: 40),
                  physics: BouncingScrollPhysics(), // IOS的回弹属性
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xfff3f3f3)))),
                        child: Column(
                            children: card1
                                .asMap()
                                .entries
                                .map((enry) {
                              int idx = enry.key;
                              final item = enry.value;
                              return InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: EdgeInsets.all(18),
                                    child: Row(
                                      children: [
                                        Text(item['title'],
                                            style: TextStyle(fontSize: 16)),
                                        SizedBox(width: 10),
                                        Spacer(flex: 1),
                                        item["type"] == 1 ? CupertinoSwitch(
                                            value: isSwitch,
                                            activeColor: Color(0xffdfdfdf),
                                            trackColor: Color(0xff22d47e),
                                            onChanged: (value) {
                                              setState(() {
                                                isSwitch = value;
                                              });
                                            }
                                        ) : Container(),
                                        item["type"] == 0
                                            ? Icon(
                                            IconData(0xeb8a,
                                                fontFamily: "sunfont"),
                                            size: 13,
                                            color: Color(0xffbababa))
                                            : Container()
                                      ],
                                    ),
                                  ),
                                  onTap: ()=>toPage(item));
                            }).toList())),
                    Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xfff3f3f3)))),
                        child: Column(
                            children: card2
                                .asMap()
                                .entries
                                .map((enry) {
                              int idx = enry.key;
                              final item = enry.value;
                              return InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: EdgeInsets.all(18),
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
                                  onTap: () => onCard3(item));
                            }).toList())),
                    Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Column(
                            children: card3
                                .asMap()
                                .entries
                                .map((enry) {
                              int idx = enry.key;
                              final item = enry.value;
                              return InkWell(
                                  child: Container(
                                    padding: EdgeInsets.all(18),
                                    child: Row(
                                      children: [
                                        Text(item['title'],
                                            style: TextStyle(fontSize: 16)),
                                        SizedBox(width: 10),
                                        Spacer(flex: 1),
                                        Text(item["type"] == 1
                                            ? "123.0M"
                                            : '', style: TextStyle(
                                            color: Color(0xffc2c2c2),
                                            fontSize: 16)),
                                        Icon(
                                            IconData(0xeb8a,
                                                fontFamily: "sunfont"),
                                            size: 13,
                                            color: Color(0xffbababa))
                                      ],
                                    ),
                                  ),
                                  onTap: () => onCard3(item));
                            }).toList())),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: InkWell(
                          borderRadius: new BorderRadius.all(
                              new Radius.circular(30.0)),
                          // 点击水波纹是圆角的，默认是矩形的
                          child: Container(
                            height: 50,
                            alignment: Alignment(0, 0),
                            // 子元素水平垂直居中
                            decoration: BoxDecoration(
                              // color: Color(0xffffffff),
                                border: Border.all(
                                    width: 1, color: Color(0xffff0000)),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text("退出登录",
                                style: TextStyle(
                                    color: Color(0xffff0000),
                                    fontSize: 20)),
                          ),
                          onTap: () {
                            // Fluttertoast.showToast(
                            //     msg: '退出登录',
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.CENTER,
                            //     backgroundColor: Color(0xd23b3b3b),
                            //     textColor: Colors.white,
                            //     fontSize: 16.0);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Container(
                                        height: 30,
                                        alignment: Alignment(0, 0),
                                        child: Text('提示')),
                                    content: Container(
                                        alignment: Alignment(0, 0),
                                        height: 24,
                                        child: Text('是否确定退出')),
                                    actions: <Widget>[
                                      TextButton(
                                          child: Text(
                                            '取消',
                                            style:
                                            TextStyle(color: Colors.grey),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context, "取消");
                                          }),
                                      TextButton(
                                        child: Text(
                                          '确定',
                                          style: TextStyle(
                                              color: Color(0xff4ece99)),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context, "确定");
                                        },
                                      ),
                                    ],
                                  );
                                });
                            print("退出登录>>");
                          }),
                    )
                  ])),
        ],
      ),
    );
  }
}
