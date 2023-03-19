import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String maxTextNum = "0/50";
  String inpText = "";
  int maxnum = 51;

  // 监听文字输入
  void textChanged(text) {
    print("TextLen>> ${text.length} >> $maxnum");
    setState(() {
      inpText = text;
      maxTextNum = "${text.length.toString()}/50";
    });
    print(maxTextNum.runtimeType); // 检测数据类型
    print("Text>>$text >>> $maxTextNum");
  }

  // 保存
  void saveProfile() {
    Fluttertoast.showToast(
        msg: "保存成功",
        toastLength: Toast.LENGTH_SHORT,
        // 停留时长短 & 长
        gravity: ToastGravity.CENTER,
        // 弹框是否居中
        backgroundColor: Color(0xd23b3b3b),
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.of(context).pop();
  }

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
                        print("返回上一页");
                        Navigator.of(context).pop();
                      }),
                  Text("个人信息",
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
                                  width: 1, color: Color(0xff22d47e))),
                          child: Text("保存",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff22d47e)))),
                      onTap: saveProfile)
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
                  cursorColor: Color(0xff22d47e),
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
