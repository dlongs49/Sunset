import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/provider/global.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/tools.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key, arguments}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController ProfileController = TextEditingController();
  String maxTextNum = "0/50";
  int maxnum = 51;

  // state 为 1 代表仅更新用户简介
  Map<String, dynamic> uinfo = {"description": "", "state": 1};

  @override
  void initState() {
    super.initState();
    getStotageInfo();
  }

  // 从缓存中取 简介信息
  void getStotageInfo() async {
    List<String> descInfo = await getStorage("descInfo");
    uinfo["id"] = descInfo[0];
    uinfo["description"] = descInfo[1];
    maxTextNum = "${descInfo[1].length.toString()}/50";
    // 给 文本框 输入框赋值
    ProfileController = TextEditingController.fromValue(TextEditingValue(
        text: descInfo[1],
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: descInfo[1].length))));
    setState(() {});
  }

  // 监听文字输入
  void textChanged(text) {
    setState(() {
      uinfo["description"] = text;
      maxTextNum = "${text.length.toString()}/50";
    });
  }

  Sign sign = new Sign();

  // 保存
  void saveProfile(context) async {
    try {
      Map res = await sign.updateUInfo(uinfo);
      print("更新简介>>> ${res}");
      if (res["code"] == 200) {
        FocusManager.instance.primaryFocus?.unfocus(); // 收起键盘
        Navigator.pop(context, uinfo["description"]);
      }
    } catch (e) {
      errToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    final skinColor = Provider.of<Global>(context).color;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        Navigator.of(context).pop();
                      }),
                  Text("个人简介",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          height: 1.6,
                          decoration: TextDecoration.none)),
                  InkWell(
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  width: 1, color: Color(skinColor))),
                          child: Text("保存",
                              style: TextStyle(
                                  fontSize: 14, color: Color(skinColor)))),
                      onTap: () => saveProfile(context))
                ],
              ),
            )
          ]),
          Stack(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              decoration: BoxDecoration(
                  color: Color(0xffeeeff3),
                  borderRadius: BorderRadius.circular(12)),
              child: TextField(
                  cursorColor: Color(skinColor),
                  // 光标颜色
                  autofocus: false,
                  // 取消自动获取焦点
                  maxLines: 6,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      // 取消边框
                      hintText: '添加个人简介使得信息更加丰富',
                      helperStyle:
                          TextStyle(color: Color(0xffd0d0d0), fontSize: 13)),
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(maxnum) //限制长度
                  ],
                  controller: ProfileController,
                  onChanged: textChanged),
            ),
            Positioned(
                right: 40,
                bottom: 30,
                child: Text(
                  maxTextNum,
                  style: TextStyle(color: Color(0xff8d8d8d), fontSize: 14),
                ))
          ])
        ],
      ),
    );
  }
}
