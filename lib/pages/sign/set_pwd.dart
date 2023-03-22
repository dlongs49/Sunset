import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sunset/components/tabbar.dart';

class SetPwd extends StatefulWidget {
  const SetPwd({Key? key}) : super(key: key);

  @override
  State<SetPwd> createState() => _SetPwdState();
}

class _SetPwdState extends State<SetPwd> {
  bool isPwd1_obs = true; // 密码一控制
  bool isPwd2_obs = true; // 密码一控制
  // 密码输入控制
  void pwdChange(String type, String value) {
    print(type);
    print(value);
    if (type == 'obs_1') {}
  }

  // 密码是否可见
  void handleIsShowPwd(bool type, bool isShowPwd) {
    if (type) {
      setState(() {
        isPwd1_obs = !isShowPwd;
      });
    } else {
      setState(() {
        isPwd2_obs = !isShowPwd;
      });
    }
  }

  // 修改密码
  void handlePwd() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title: "修改密码", bgColor: null, fontColor: null),
          Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  padding: EdgeInsets.only(right: 8, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5, color: Color(0xffe8e8e8)))),
                  child: Row(children: [
                    Expanded(
                        child: Container(
                            child: TextField(
                                cursorColor: Color(0xff22d47e),
                                autofocus: false,
                                style: TextStyle(fontSize: 16),
                                obscureText: isPwd1_obs,
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
                                onChanged: (value) {
                                  this.pwdChange('pwd_1', value);
                                }))),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                              IconData(isPwd1_obs ? 0xe66b : 0xe624,
                                  fontFamily: 'sunfont'),
                              size: 24,
                              color: Color(0xffbababa))),
                      onTap: () => handleIsShowPwd(true, isPwd1_obs),
                    )
                  ])),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  padding: EdgeInsets.only(right: 8, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xffe8e8e8)))),
                  child: Row(children: [
                    Expanded(
                        child: Container(
                            child: TextField(
                                cursorColor: Color(0xff22d47e),
                                autofocus: false,
                                style: TextStyle(fontSize: 16),
                                obscureText: isPwd2_obs,
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
                                onChanged: (value) {
                                  this.pwdChange('pwd_2', value);
                                }))),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                              IconData(isPwd2_obs ? 0xe66b : 0xe624,
                                  fontFamily: 'sunfont'),
                              size: 24,
                              color: Color(0xffbababa))),
                      onTap: () => handleIsShowPwd(false, isPwd2_obs),
                    )
                  ])),
              SizedBox(height: 30),
              Align(
                child: Ink(
                    decoration: BoxDecoration(
                        color: Color(0xff22d47e),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        highlightColor: Color(0xff11a55f), // 水波纹高亮颜色
                        child: Container(
                          alignment: Alignment(0, 0),
                          width: 320,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text("确定",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800)),
                        ),
                        onTap: handlePwd)),
              )
            ],
          )
        ],
      ),
    );
  }
}
