import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
class ForgetPwd extends StatefulWidget {
  const ForgetPwd({Key? key}) : super(key: key);

  @override
  State<ForgetPwd> createState() => _ForgetPwdState();
}

class _ForgetPwdState extends State<ForgetPwd> {
  TextEditingController PhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  String phone = '';

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
  }

  // 登录
  void handleLogin() {}

  // 验证码
  void onCode() {}

  void toPage(dynamic item) {
    Navigator.pushNamed(context, item);
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
                  Align(
                      alignment: Alignment.center,
                      child: Text("忘记密码",
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
            alignment: Alignment(0,0),
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Text("为了您的安全我们会向您的手机发送验证码",style:TextStyle(color:Color(0xffc2c2c2),fontSize: 16)),
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
                                        inputChange("", value)))),
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
                              child: Text("下一步",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800)),
                            ),
                            onTap: handleLogin)),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
