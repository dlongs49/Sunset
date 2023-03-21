import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
class PwdLogin extends StatefulWidget {
  const PwdLogin({Key? key}) : super(key: key);

  @override
  State<PwdLogin> createState() => _PwdLoginState();
}

class _PwdLoginState extends State<PwdLogin> {
  TapGestureRecognizer useragreeall = TapGestureRecognizer();
  TapGestureRecognizer privacypolicy = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
  }

  void toPage(dynamic item) {
    Navigator.pushNamed(context, item);
  }

  final isCheck = false;

  void phoneChange(String str) {}
  void pwdChange(String str) {}
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
                        onTap: () => toPage("pwdLogin")),
                  )
                ],
              ),
            ),
          ]),
          Container(
            constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
            margin: EdgeInsets.symmetric(vertical: 50),
            child: Image.asset("assets/images/3044.jpg"),
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                        hintText: '手机号码',
                                        helperStyle: TextStyle(
                                            color: Color(0xffd0d0d0),
                                            fontSize: 13)),
                                    onChanged: phoneChange))),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              // 0xe624 0xe66b
                              child: Icon(IconData(0xe66b,fontFamily: 'sunfont'),
                                  size: 16, color: Color(0xff8b8b8b))),
                          onTap: () {
                            print(123);
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Radio(
                          activeColor: Color(0xff22d47e),
                          groupValue: true,
                          value: isCheck,
                          onChanged: (vl) {
                            setState(() {
                              // isCheck =val;
                            });
                          },
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '您已阅读并同意',
                                style: TextStyle(
                                    color: Color(0xffd2d2d2), fontSize: 12)),
                            TextSpan(
                                text: '《用户协议》',
                                style: TextStyle(
                                    color: Color(0xff22d47e), fontSize: 12),
                                recognizer: useragreeall
                                  ..onTap = () {
                                    print(1);
                                  }),
                            TextSpan(
                                text: '和',
                                style: TextStyle(
                                    color: Color(0xffd2d2d2), fontSize: 12)),
                            TextSpan(
                                text: '《隐私政策》',
                                style: TextStyle(
                                    color: Color(0xff22d47e), fontSize: 12),
                                recognizer: privacypolicy..onTap = () {}),
                          ]),
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
                            child: Text("登录",
                                style: TextStyle(
                                    color: Color(0xffffffff), fontSize: 16)),
                          ),
                          onTap: () {})),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Text("忘记密码?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff22d47e), fontSize: 13)),
                          onTap: () {}),
                      SizedBox(width: 20),
                      Container(
                        width: 1,
                        height: 12,
                        color: Color(0xffe2e2e2),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                          child: Text("随便看看",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff22d47e), fontSize: 13)),
                          onTap: () {})
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
