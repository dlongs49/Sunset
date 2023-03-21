import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
class BindPhone extends StatefulWidget {
  const BindPhone({Key? key}) : super(key: key);

  @override
  State<BindPhone> createState() => _BindPhoneState();
}

class _BindPhoneState extends State<BindPhone> {
  void phoneChange(String str){}
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
                  Align(
                      alignment: Alignment.center,
                      child: Text("手机登录",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              height: 2.2,
                              decoration: TextDecoration.none))),

                ],
              ),
            ),
          ]),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 2, right: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0xffe8e8e8)))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                child: TextField(
                                    cursorColor: Color(0xff22d47e),
                                    autofocus: false,
                                    style: TextStyle(fontSize: 14),
                                    // 数字键盘
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.all(6),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: '手机号码',
                                        helperStyle: TextStyle(
                                            color: Color(0xffd0d0d0),
                                            fontSize: 13)),
                                    onChanged: phoneChange))),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.cancel,
                                  size: 16, color: Color(0xff8b8b8b))),
                          onTap: () {
                            print(123);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 2, right: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0xffe8e8e8)))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                child: TextField(
                                    cursorColor: Color(0xff22d47e),
                                    autofocus: false,
                                    style: TextStyle(fontSize: 14),
                                    // 数字键盘
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.all(6),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: '随机生成验证码',
                                        helperStyle: TextStyle(
                                            color: Color(0xffd0d0d0),
                                            fontSize: 13)),
                                    onChanged: phoneChange))),
                        Container(
                          width: 1,
                          height: 12,
                          color: Color(0xffb4b4b4),
                        ),
                        SizedBox(width: 30),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Text("获取验证码",
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff22d47e)))),
                          onTap: () {
                            print(123);
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                      child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(top: 30, bottom: 10),
                            alignment: Alignment(0, 0),
                            width: 320,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xff22d47e),
                                borderRadius: BorderRadius.circular(40)),
                            child: Text("绑定",
                                style: TextStyle(
                                    color: Color(0xffffffff), fontSize: 16)),
                          ),
                          onTap: () {})),
                ],
              ))
        ],
      ),
    );
  }
}
