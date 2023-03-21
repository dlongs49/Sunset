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
  TextEditingController PhoneController= TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  bool isShowPwd = true;
  String phone = '';
  // 输入值
  void inputChange(String type,String str) {
    if(type == 'phone'){
      setState(() {
        phone = str;
      });
    }
    if(type == 'clear'){
      PhoneController.clear(); // 清除输入的值
      setState(() {
        phone = '';
      });
    }
  }
  void phoneChange(String str) {}
  void pwdChange(String str) {}
  // 密码是否可见
  void handleIsShowPwd(bool isShowPwd) {
    setState(() {
      isShowPwd = !isShowPwd;
    });
  }
  // 登录
  void handleLogin() {}
  void toPage(dynamic item) {
    Navigator.pushNamed(context, item);
  }

  final isCheck = false;


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
                        child: Text("手机登录",
                            style: TextStyle(
                                color: Color(0xff22d47e), fontSize: 14)),
                        onTap: () => toPage("phoneLog")),
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
                    padding: EdgeInsets.only(left: 2, right: 8,top: 5,bottom: 8),
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
                                      LengthLimitingTextInputFormatter(11), //限制长度
                                      FilteringTextInputFormatter.allow(RegExp("[0-9]")) // 数字键盘
                                    ],
                                    decoration: InputDecoration(
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: '手机号码',
                                        hintStyle: TextStyle(
                                            color: Color(0xffacacac))),
                                    onChanged: (value)=>inputChange('phone',value)))),
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
                    padding: EdgeInsets.only(left: 2, right: 8,top: 5,bottom: 8),
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
                                    obscureText: isShowPwd,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9a-zA-Z]')),
                                      LengthLimitingTextInputFormatter(20),
                                    ],
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.all(8),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: '请输入密码',
                                      hintStyle:
                                      TextStyle(color: Color(0xffacacac)),
                                    ),
                                    onChanged: (value) =>pwdChange(value)))),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                  IconData(isShowPwd ? 0xe66b : 0xe624,
                                      fontFamily: 'sunfont'),
                                  size: 24,
                                  color: Color(0xffbababa))),
                          onTap: () => handleIsShowPwd(isShowPwd),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Transform.scale(
                            scale: 0.8,
                            child: Radio(
                              activeColor: Color(0xff22d47e),
                              groupValue: true,
                              value: isCheck,
                              onChanged: (vl) {
                                setState(() {
                                  // isCheck =val;
                                });
                              },
                            ))
                        ,
                        Expanded(child: RichText(
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Text("忘记密码?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff22d47e), fontSize: 14)),
                          onTap: ()=>toPage('forgetPwd')),
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
                                  color: Color(0xff22d47e), fontSize: 14)),
                          onTap: ()=>toPage('/'))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
