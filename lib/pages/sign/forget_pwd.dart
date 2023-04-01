import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/tools.dart';

class ForgetPwd extends StatefulWidget {
  const ForgetPwd({Key? key}) : super(key: key);

  @override
  State<ForgetPwd> createState() => _ForgetPwdState();
}

class _ForgetPwdState extends State<ForgetPwd> {
  TextEditingController PhoneController = TextEditingController();
  TextEditingController CodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isNext = false; // 下一步状态重置，防止直接进入重置密码界面
    setState(() {});
  }

  String phone = '';
  String verCode = '';

  bool isPhone = false;
  bool isCode = false;

  // 输入值
  void inputChange(String type, String str) {
    if (type == 'phone') {
      isPhone = str != "" ? true : false; // 下一步高亮
      phone = str;
      setState(() {});
    }
    if (type == 'clear') {
      PhoneController.clear(); // 清除输入的值
      phone = '';
      isPhone = false;
      setState(() {});
    }
    if (type == 'code') {
      isCode = str != "" ? true : false; // 下一步高亮
      verCode = str;
      setState(() {});
    }
  }

  late Timer timer;
  int seconds = 5; // 倒计时
  bool isOnCode = true;

  // 验证码
  void onCode() {
    if (phone == "") {
      toast("手机号不能为空");
      return;
    }
    // 模拟获取验证码 时间戳截取
    String value = (new DateTime.now().millisecondsSinceEpoch).toString();
    String code = value.substring(value.length - 6, value.length);
    // 给 验证码 输入框赋值
    CodeController = TextEditingController.fromValue(TextEditingValue(
        text: code,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: code.length))));
    isOnCode = false; // 切换获取验证码 和 倒计时
    isCode = true; // 判断验证码是否赋值，下一步高亮
    verCode = code;
    setState(() {});
    // 倒计时
    const timeout = const Duration(seconds: 1);
    timer = Timer.periodic(timeout, (t) {
      seconds--;
      if (seconds <= 0) {
        isOnCode = true;
        timer.cancel();
        seconds = 5;
      }
      setState(() {});
    });
  }

// 页面卸载
  @override
  void dispose() {
    // 清空获取验证码 定时器
    timer.cancel();
    super.dispose();
  }

  Sign sign = new Sign();
  bool isNext = false;

  // 下一步
  void handleLogin() async {
    // 手机号 验证码 下一步按钮高亮
    if (!isPhone || !isCode) {
      return;
    }
    Map<String, String> map = new Map();
    map["phone"] = phone;
    map["verCode"] = verCode;
    try {
      loading(seconds: 3);
      Map res = await sign.findPhone(map);
      if (res['code'] == 200) {
        timer.cancel(); // 清空定时器
        setState(() {
          isNext = true;
        });
      }
    } catch (e) {
      errToast();
    }
  }

  bool isPwd1_obs = true; // 密码一控制显隐
  bool isPwd2_obs = true; // 密码二控制显隐
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

  String password1 = "";
  bool isPwd1Value = false; // 控制确定操作高亮
  bool isPwd2Value = false; // 控制确定操作高亮
  // 密码输入控制
  void pwdChange(String type, String value) {
    if (type == 'pwd_1') {
      password1 = value;
      isPwd1Value = value != "" ? true : false; // 确定高亮
    } else {
      password = value;
      isPwd2Value = value != "" ? true : false; // 确定高亮
    }
    setState(() {});
  }

  bool isPwd1 = false; // 控制密码1明文显示
  bool isPwd2 = false; // 控制密码2明文显示
  String password = "";

  // 修改密码
  void handlePwd() async {
    print("两次密码>> $password1 $password");
    if (password == "" || password1 == "") {
      return;
    }
    if (password1 != password) {
      toast("两次输入的密码不一致");
      return;
    }
    final p = md5Tools(password); // 密码 md5 加密  后台在加一层密
    Map<String, String> map = new Map();
    map["phone"] = phone;
    map["password"] = p.toString();
    try {
      loading(seconds: 3);
      Map res = await sign.forgetPwd(map);
      if (res['code'] == 200) {
        toast("密码重置成功");
      } else {
        toast("密码重置失败");
      }
    } catch (e) {
      errToast();
    }
  }

  void toPage(dynamic item) {
    Navigator.pushNamed(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title: "忘记密码", bgColor: null, fontColor: null),
          !isNext
              ? Column(
                  children: [
                    Container(
                      alignment: Alignment(0, 0),
                      margin: EdgeInsets.symmetric(vertical: 30),
                      child: Text("为了您的安全我们会向您的手机发送验证码",
                          style: TextStyle(
                              color: Color(0xffc2c2c2), fontSize: 16)),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 2, right: 8, top: 5, bottom: 8),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: Color(0xffe8e8e8)))),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          child: TextField(
                                              controller: PhoneController,
                                              cursorColor: Color(0xff22d47e),
                                              autofocus: false,
                                              style: TextStyle(fontSize: 16),
                                              // 下一步
                                              textInputAction:
                                                  TextInputAction.next,
                                              // 数字键盘
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    11),
                                                //限制长度
                                                FilteringTextInputFormatter
                                                    .allow(RegExp("[0-9]"))
                                                // 数字键盘
                                              ],
                                              decoration: InputDecoration(
                                                  isCollapsed: true,
                                                  contentPadding:
                                                      EdgeInsets.all(8),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                                  hintText: '手机号码',
                                                  hintStyle: TextStyle(
                                                      color:
                                                          Color(0xffacacac))),
                                              onChanged: (value) => inputChange(
                                                  'phone', value)))),
                                  InkWell(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Icon(Icons.cancel,
                                              size: 16,
                                              color: Color(0xff8b8b8b))),
                                      onTap: () => inputChange('clear', ''))
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 2, right: 8, top: 5, bottom: 8),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: Color(0xffe8e8e8)))),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          child: TextField(
                                              controller: CodeController,
                                              cursorColor: Color(0xff22d47e),
                                              autofocus: false,
                                              style: TextStyle(fontSize: 16),
                                              // 下一步
                                              textInputAction:
                                                  TextInputAction.next,
                                              // 数字键盘
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    6),
                                                //限制长度
                                                FilteringTextInputFormatter
                                                    .allow(RegExp("[0-9]"))
                                                // 数字键盘
                                              ],
                                              decoration: InputDecoration(
                                                  isCollapsed: true,
                                                  contentPadding:
                                                      EdgeInsets.all(8),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                                  hintText: '随机生成验证码',
                                                  hintStyle: TextStyle(
                                                      color:
                                                          Color(0xffacacac))),
                                              onChanged: (value) =>
                                                  inputChange("code", value)))),
                                  Container(
                                    width: 1,
                                    height: 16,
                                    color: Color(0xffb4b4b4),
                                  ),
                                  SizedBox(width: 30),
                                  isOnCode
                                      ? InkWell(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              color: Color(0xffffff),
                                              child: Text("获取验证码",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          Color(0xff22d47e)))),
                                          onTap: onCode,
                                        )
                                      : Container(
                                          width: 50,
                                          padding: EdgeInsets.all(5),
                                          color: Color(0xffffff),
                                          child: Text("$seconds秒",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xffbcbfc4))))
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(height: 20),
                            Align(
                              child: Ink(
                                  decoration: BoxDecoration(
                                      color: Color(isPhone && isCode
                                          ? 0xff22d47e
                                          : 0xffebebeb),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      highlightColor: Color(isPhone && isCode
                                          ? 0xff11a55f
                                          : 0xffebebeb),
                                      // 水波纹高亮颜色
                                      child: Container(
                                        alignment: Alignment(0, 0),
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text("下一步",
                                            style: TextStyle(
                                                color: Color(isPhone && isCode
                                                    ? 0xffffffff
                                                    : 0xffcacaca),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800)),
                                      ),
                                      onTap: handleLogin)),
                            ),
                          ],
                        ))
                  ],
                )
              : Column(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        padding: EdgeInsets.only(right: 8, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xffe8e8e8)))),
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
                              color: Color(isPwd1Value && isPwd2Value
                                  ? 0xff22d47e
                                  : 0xffebebeb),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              highlightColor: Color(isPwd1Value && isPwd2Value
                                  ? 0xff11a55f
                                  : 0xffebebeb), // 水波纹高亮颜色
                              child: Container(
                                alignment: Alignment(0, 0),
                                width: 320,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text("确定",
                                    style: TextStyle(
                                        color: Color(isPwd1Value && isPwd2Value
                                            ? 0xffffffff
                                            : 0xffcacaca),
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
