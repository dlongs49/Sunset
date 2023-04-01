import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunset/utils/api/sign_req.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TapGestureRecognizer useragreeall = TapGestureRecognizer();
  TapGestureRecognizer privacypolicy = TapGestureRecognizer();
  TextEditingController PhoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  String phone = '';
  String verCode = '';

  // 输入值
  void inputChange(String type, String str) {
    if (type == 'phone') {
      setState(() {
        phone = str;
      });
    }
    if (type == 'clear') {
      PhoneController.clear(); // 清除输入的值
      setState(() {
        phone = '';
      });
    }
    if (type == 'code') {
      setState(() {
        verCode = str;
      });
    }
  }

  Sign sign = new Sign();

  // 登录
  void handleLogin() async {
    print(phone);
    print(verCode);
    Map<String, String> map = new Map();
    map["phone"] = "18794388410";
    map["verCode"] = "123";
    Map res = await sign.codeLogin(map);
    print(">>${res["data"]}");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("ms_token", res["data"]);
    final String? ms_token = prefs.getString("ms_token");
    print(ms_token);

  }

  // 验证码
  void onCode() {

  }

  void toPage(dynamic item) {
    Navigator.pushNamed(context, item);
  }

  void toLook() {
    Navigator.pushNamed(context, '/');
  }

  bool isCheck = false;

  void handleCheck() {
    setState(() {
      isCheck = !isCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    return Scaffold(
      resizeToAvoidBottomInset: false, // 解决键盘弹起容器溢出bug
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        child: Text("密码登录",
                            style: TextStyle(
                                color: Color(0xffb8b8b8), fontSize: 14)),
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
                    padding:
                        EdgeInsets.only(left: 2, right: 8, top: 5, bottom: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.5, color: Color(0xffe8e8e8)))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                child: TextField(
                                    controller: PhoneController,
                                    cursorColor: Color(0xff22d47e),
                                    autofocus: false,
                                    style: TextStyle(fontSize: 16),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11),
                                      //限制长度
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                      // 数字键盘
                                    ],
                                    decoration: InputDecoration(
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: '手机号码',
                                        hintStyle: TextStyle(
                                            color: Color(0xffacacac))),
                                    onChanged: (value) =>
                                        inputChange('phone', value)))),
                        InkWell(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Icon(Icons.cancel,
                                    size: 16, color: Color(0xff8b8b8b))),
                            onTap: () => inputChange('clear', ''))
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding:
                        EdgeInsets.only(left: 2, right: 8, top: 5, bottom: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.5, color: Color(0xffe8e8e8)))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                child: TextField(
                                    cursorColor: Color(0xff22d47e),
                                    autofocus: false,
                                    style: TextStyle(fontSize: 16),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(6),
                                      //限制长度
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                      // 数字键盘
                                    ],
                                    decoration: InputDecoration(
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: '随机生成验证码',
                                        hintStyle: TextStyle(
                                            color: Color(0xffacacac))),
                                    onChanged: (value) =>
                                        inputChange("code", value)))),
                        Container(
                          width: 1,
                          height: 16,
                          color: Color(0xffb4b4b4),
                        ),
                        SizedBox(width: 30),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              color: Color(0xffffff),
                              child: Text("获取验证码",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff22d47e)))),
                          onTap: onCode,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        InkWell(
                            child: Icon(
                              IconData(isCheck ? 0xe645 : 0xe614,
                                  fontFamily: 'sunfont'),
                              size: 16,
                              color: Color(isCheck ? 0xff22d47e : 0xffb4b3b3),
                            ),
                            onTap: handleCheck),
                        SizedBox(width: 5),
                        Expanded(
                            child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '您已阅读并同意',
                                style: TextStyle(
                                    color: Color(0xffd2d2d2), fontSize: 14)),
                            TextSpan(
                                text: '《用户协议》',
                                style: TextStyle(
                                    color: Color(0xff22d47e), fontSize: 14),
                                recognizer: useragreeall
                                  ..onTap = () {
                                    print(1);
                                  }),
                            TextSpan(
                                text: '和',
                                style: TextStyle(
                                    color: Color(0xffd2d2d2), fontSize: 14)),
                            TextSpan(
                                text: '《隐私政策》',
                                style: TextStyle(
                                    color: Color(0xff22d47e), fontSize: 14),
                                recognizer: privacypolicy..onTap = () {}),
                          ]),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    child: Ink(
                        decoration: BoxDecoration(
                            color: Color(0xff22d47e),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            highlightColor: Color(0xff11a55f), // 水波纹高亮颜色
                            child: Container(
                              alignment: Alignment(0, 0),
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text("登录",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800)),
                            ),
                            onTap: handleLogin)),
                  ),
                  SizedBox(height: 10),
                  Align(
                      child: InkWell(
                          child: Text("随便看看",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff22d47e), fontSize: 15)),
                          onTap: toLook))
                ],
              ))
        ],
      ),
    );
  }
}
