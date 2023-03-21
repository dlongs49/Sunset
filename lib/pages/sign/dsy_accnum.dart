import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DsyAccnum extends StatefulWidget {
  const DsyAccnum({Key? key}) : super(key: key);

  @override
  State<DsyAccnum> createState() => _DsyAccnumState();
}

class _DsyAccnumState extends State<DsyAccnum> {
  bool isChecked = false;
  void handleChecked(bool val) {}
  void handleDsy(){}
  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Text("账号注销",
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
            SizedBox(height: 30),
            Text("什么原因让你注销该账号",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            SizedBox(height: 50),
            Row(
              children: [
                Checkbox(
                    activeColor: Color(0xffb8b8b8),
                    //选中的颜色
                    fillColor: MaterialStateProperty.all(Color(0xff22d47e)),
                    //打钩的颜色
                    focusColor: Color(0xff22d47e),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
                SizedBox(width: 4),
                Text("体验不好",style: TextStyle(fontSize: 16))
              ],
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: Color(0xffb8b8b8),
                    //选中的颜色
                    fillColor: MaterialStateProperty.all(Color(0xff22d47e)),
                    //打钩的颜色
                    focusColor: Color(0xff22d47e),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
                SizedBox(width: 4),
                Text("体验不好",style: TextStyle(fontSize: 16))
              ],
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: Color(0xffb8b8b8),
                    //选中的颜色
                    fillColor: MaterialStateProperty.all(Color(0xff22d47e)),
                    //打钩的颜色
                    focusColor: Color(0xff22d47e),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
                SizedBox(width: 4),
                Text("体验不好",style: TextStyle(fontSize: 16))
              ],
            ),
            SizedBox(height: 30),
            Align(
              child: Ink(
                  decoration: BoxDecoration(
                      color: Color(0xfff56f32),
                      borderRadius:
                      BorderRadius.all(Radius.circular(50))),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      highlightColor: Color(0xffd44b10), // 水波纹高亮颜色
                      child: Container(
                        alignment: Alignment(0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text("注销",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 18,
                                fontWeight: FontWeight.w800)),
                      ),
                      onTap: handleDsy)),
            ),
          ],
        ),
      ),
    );
  }
}
