import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class SetPwd extends StatefulWidget {
  const SetPwd({Key? key}) : super(key: key);

  @override
  State<SetPwd> createState() => _SetPwdState();
}

class _SetPwdState extends State<SetPwd> {
  void pwdChange(String pwd) {}

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
                      child: Text("密码登录",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              height: 2.2,
                              decoration: TextDecoration.none))),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        child: Text("密码登录",
                            style: TextStyle(
                                color: Color(0xffb8b8b8), fontSize: 12)),
                        onTap: () {}),
                  )
                ],
              ),
            ),
          ]),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                padding: EdgeInsets.only(left: 2, right: 8),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xffe8e8e8)))),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: TextField(
                                cursorColor: Color(0xff22d47e),
                                autofocus: false,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.all(6),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: '密码',
                                    helperStyle: TextStyle(
                                        color: Color(0xffd0d0d0),
                                        fontSize: 13)),
                                onChanged: pwdChange))),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          // 0xe624 0xe66b
                          child: Icon(IconData(0xe66b, fontFamily: 'sunfont'),
                              size: 16, color: Color(0xff8b8b8b))),
                      onTap: () {
                        print(123);
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                padding: EdgeInsets.only(left: 2, right: 8),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xffe8e8e8)))),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: TextField(
                                cursorColor: Color(0xff22d47e),
                                autofocus: false,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.all(6),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: '密码',
                                    helperStyle: TextStyle(
                                        color: Color(0xffd0d0d0),
                                        fontSize: 13)),
                                onChanged: pwdChange))),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          // 0xe624 0xe66b
                          child: Icon(IconData(0xe66b, fontFamily: 'sunfont'),
                              size: 16, color: Color(0xff8b8b8b))),
                      onTap: () {
                        print(123);
                      },
                    )
                  ],
                ),
              ),
              Align(
                  child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 14, bottom: 10),
                        alignment: Alignment(0, 0),
                        width: 320,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xff22d47e),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text("确定",
                            style: TextStyle(
                                color: Color(0xffffffff), fontSize: 16)),
                      ),
                      onTap: () {})),
            ],
          )
        ],
      ),
    );
  }
}
