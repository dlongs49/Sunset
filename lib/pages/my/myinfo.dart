import 'dart:core';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:sunset/local_data/info.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  _MyInfoState createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  List sexList = ["女", "男"];
  int sexActive = 0; // 默认索引对应值 女
  int seleStature = 160; // 女：160cm 男：180cm
  double seleWeight = 45.0; // 女：45.0kg 男：60.0kg
  int seleWaistline = 60; // 女：60cm 男：80cm
  // 重写选择器的样式
  PickerStyle customPickStyle() {
    // 确定按钮样式
    Widget _commitButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      margin: const EdgeInsets.only(right: 22),
      child:
          Text('确定', style: TextStyle(fontSize: 14, color: Color(0xff22d47e))),
    );
    return PickerStyle(
      commitButton: _commitButton,
    );
  }

  // 个人简介
  void toPage(String path) {
    Navigator.pushNamed(context, path);
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
                      child: Text("个人信息",
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
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: MediaQuery.removePadding(
                      // 去除顶部留白
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: ListView(
                          padding: EdgeInsets.only(bottom: 40),
                          physics: BouncingScrollPhysics(), // IOS的回弹属性
                          children: [
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("头像", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(36),
                                    child: Image.network(
                                      "https://p.qqan.com/up/2021-5/16215608427768095.png",
                                      width: 36,
                                      height: 36,
                                    )),
                                SizedBox(width: 15),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("ID", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                Text("123456",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffb4b4b4))),
                                SizedBox(width: 10)
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("昵称", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                    child: Text("冰消叶散",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    onTap: () {}),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("个人简介", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkResponse(
                                  // 取消点击水波纹使用 InkResponse
                                    highlightColor: Colors.transparent,
                                    radius: 0.0,
                                    child: Text("取半舍满",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffb3b3b3))),
                                    onTap: () => toPage("myProfile")),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Color(0xfff2f2f2)))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("性别", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                Row(
                                    children: sexList
                                        .asMap()
                                        .entries
                                        .map<Widget>((enry) {
                                  int index = enry.key;
                                  String item = enry.value;
                                  return InkWell(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 26, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Color(sexActive == index
                                              ? 0xff22d47e
                                              : 0xffe8e8f2),
                                          borderRadius: index == 0
                                              ? BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(30))
                                              : BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30)),
                                        ),
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Color(sexActive == index
                                                  ? 0xffffffff
                                                  : 0xff747474)),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          sexActive = index;
                                          seleStature = index == 0 ? 160 : 180;
                                          seleWeight = index == 0 ? 45.0 : 60.0;
                                          seleWaistline = index == 0 ? 60 : 80;
                                        });
                                      });
                                }).toList())
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("身高", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                    child: Text(seleStature.toString() + ".CM",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffb3b3b3))),
                                    onTap: () {
                                      Pickers.showSinglePicker(context,
                                          data: stature,
                                          pickerStyle: customPickStyle(),
                                          selectData: seleStature,
                                          onConfirm: (val, i) {
                                            setState(() {
                                              seleStature = val;
                                            });
                                            print(val);
                                          },
                                          onChanged: (val, i) =>
                                              print('选择的身高为：$val'));
                                    }),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("生日", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                    child: Text("1998-04-09",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffb3b3b3))),
                                    onTap: () {}),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("体重", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                    child: Text(seleWeight.toString() + "公斤",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffb3b3b3))),
                                    onTap: () {
                                      Pickers.showSinglePicker(context,
                                          data: weight,
                                          pickerStyle: customPickStyle(),
                                          selectData: seleWeight,
                                          onConfirm: (val, i) {
                                            setState(() {
                                              seleWeight = val;
                                            });
                                            print(val);
                                          },
                                          onChanged: (val, i) =>
                                              print('选择的体重为：$val'));
                                    }),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("腰围", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                    child: Text(
                                        seleWaistline.toString() + ".0CM",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffb3b3b3))),
                                    onTap: () {
                                      Pickers.showSinglePicker(context,
                                          data: waistLine,
                                          pickerStyle: customPickStyle(),
                                          selectData: seleWaistline,
                                          onConfirm: (val, i) {
                                            setState(() {
                                              seleWaistline = val;
                                            });
                                            print(val);
                                          },
                                          onChanged: (val, i) =>
                                              print('选择的腰围为：$val'));
                                    }),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Color(0xfff8f8fa),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                  "性别、年龄、身高、体重、腰围信息将影响日常活动、体脂数据的准确性。请准确填写以上个人资料，以获取更精准的健康数据",
                                  style: TextStyle(
                                      height: 1.5,
                                      fontSize: 12,
                                      color: Color(0xff6d6d6d))),
                            )
                          ])))),
        ],
      ),
    );
  }
}
