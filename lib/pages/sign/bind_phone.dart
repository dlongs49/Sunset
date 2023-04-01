import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/sign_req.dart';

class BindPhone extends StatefulWidget {
  const BindPhone({Key? key}) : super(key: key);

  @override
  State<BindPhone> createState() => _BindPhoneState();
}

class _BindPhoneState extends State<BindPhone> {
  TextEditingController PhoneController = TextEditingController();
  TextEditingController CodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  String phone = '';
  String verCode = '';

  bool isPhone = false;
  bool isCode = false;

  // 输入值
  void inputChange(String type, String str) {
    if (type == 'phone') {
      isPhone = str != "" ? true : false; // 登录高亮
      phone = str;
      setState(() {});
    }
    if (type == 'clear') {
      PhoneController.clear(); // 清除输入的值
      isPhone = false;
      phone = '';
      setState(() {});
    }
    if (type == 'code') {
      isCode = str != "" ? true : false; // 登录高亮
      setState(() {
        verCode = str;
      });
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
    isCode = true; // 判断验证码是否赋值，登录高亮
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

  Sign sign = new Sign();

  // 绑定
  void handleBind() async {
// 手机号 验证码 绑定按钮高亮
    if (!isPhone || !isCode) {
      return;
    }
    Map<String, String> map = new Map();
    map["phone"] = phone;
    map["verCode"] = verCode;
    try {
      loading(seconds: 3);
      Map res = await sign.changePhone(map);

      if (res["code"] == 200) {
        toast("换绑成功");
        FocusManager.instance.primaryFocus?.unfocus(); // 收起键盘
        Navigator.pop(context);
      }
      if (res["code"] == -1) {
        toast(res["message"]);
      }

    } catch (e) {
      errToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title: "换绑手机号", bgColor: null, fontColor: null),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                    controller: PhoneController,
                                    cursorColor: Color(0xff22d47e),
                                    autofocus: false,
                                    style: TextStyle(fontSize: 16),
                                    // 下一步
                                    textInputAction: TextInputAction.next,
                                    // 数字键盘
                                    keyboardType: TextInputType.number,
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
                                        hintText: '手机号码【随便填】',
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
                          onTap: () => inputChange('clear', ''),
                        )
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
                                    // 下一步
                                    textInputAction: TextInputAction.next,
                                    // 数字键盘
                                    keyboardType: TextInputType.number,
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
                                        inputChange("code", value),
                                    controller: CodeController))),
                        Container(
                          width: 1,
                          height: 16,
                          color: Color(0xffb4b4b4),
                        ),
                        SizedBox(width: 30),
                        isOnCode
                            ? InkWell(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    color: Color(0xffffff),
                                    child: Text("获取验证码",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff22d47e)))),
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
                  SizedBox(height: 30),
                  Align(
                    child: Ink(
                        decoration: BoxDecoration(
                            color: Color(isPhone && isCode
                                ? 0xff22d47e
                                : 0xffebebeb),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            highlightColor: Color(isPhone && isCode
                                ? 0xff11a55f
                                : 0xffebebeb), // 水波纹高亮颜色
                            child: Container(
                              alignment: Alignment(0, 0),
                              width: 320,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text("绑定",
                                  style: TextStyle(
                                      color: Color(isPhone && isCode
                                          ? 0xffffffff
                                          : 0xffcacaca),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800)),
                            ),
                            onTap: handleBind)),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
