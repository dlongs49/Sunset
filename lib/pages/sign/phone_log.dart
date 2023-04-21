import 'dart:ui';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/pages/sign/pwd_log.dart';
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
  TextEditingController CodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    CodeController = TextEditingController.fromValue(TextEditingValue(
        text: "1234",
        selection: TextSelection.fromPosition(
            TextPosition(affinity: TextAffinity.downstream, offset: 4))));
    PhoneController = TextEditingController.fromValue(TextEditingValue(
        text: "13096954409",
        selection: TextSelection.fromPosition(
            TextPosition(affinity: TextAffinity.downstream, offset: 4))));
  }

  String phone = '13096954409';
  String verCode = '123456';

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

  // 登录
  void handleLogin() async {
    // 手机号 验证码 选中协议 登录按钮高亮
    if (!isPhone || !isCode || !isCheck) {
      return;
    }
    Map<String, String> map = new Map();
    map["phone"] = phone;
    map["verCode"] = verCode;
    try {
      var l = loading();
      Map res = await sign.codeLogin(map);
      print("ms_token>>> ${res["data"]}");
      // 将 token 存在缓存中
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("ms_token", res["data"]);
      l();
      FocusManager.instance.primaryFocus?.unfocus(); // 收起键盘
      // Navigator.pushNamed(context, '/');
    } catch (e) {
      errToast();
    }
  }

  //跳转并关闭并销毁当前页面 密码登录页面
  void toPwdLog(context) {
    Navigator.pushAndRemoveUntil(
      context,
      new CupertinoPageRoute(builder: (context) => new PwdLogin()),
      (route) => route == null,
    );
  }

  // 随便看看
  void toLook(context) async{
    if (!isCheck) {
      toast("勾选用户协议");
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("role", "UN");
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
                        onTap: () => toPwdLog(context)),
                  )
                ],
              ),
            ),
          ]),
          Container(
            constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
            margin: EdgeInsets.symmetric(vertical: 50),
            child: Image.asset("assets/images/200x200.png",width: 80,height: 80),
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
                                        hintText: '随机生成验证码【随便填】',
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
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                            child: Container(
                              width: 30,
                              height: 30,
                              child: Icon(
                                IconData(isCheck ? 0xe645 : 0xe614,
                                    fontFamily: 'sunfont'),
                                size: 16,
                                color: Color(isCheck ? 0xff22d47e : 0xffb4b3b3),
                              ),
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
                                    toast("《用户协议》");
                                  }),
                            TextSpan(
                                text: '和',
                                style: TextStyle(
                                    color: Color(0xffd2d2d2), fontSize: 14)),
                            TextSpan(
                                text: '《隐私政策》',
                                style: TextStyle(
                                    color: Color(0xff22d47e), fontSize: 14),
                                recognizer: privacypolicy
                                  ..onTap = () {
                                    toast("《隐私政策》");
                                  }),
                          ]),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    child: Ink(
                        decoration: BoxDecoration(
                            color: Color(isPhone && isCode && isCheck
                                ? 0xff22d47e
                                : 0xffebebeb),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            highlightColor: Color(isPhone && isCode && isCheck
                                ? 0xff11a55f
                                : 0xffebebeb0), // 水波纹高亮颜色
                            child: Container(
                              alignment: Alignment(0, 0),
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text("登录",
                                  style: TextStyle(
                                      color: Color(isPhone && isCode && isCheck
                                          ? 0xffffffff
                                          : 0xffcacaca),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800)),
                            ),
                            onTap: handleLogin)),
                  ),
                  SizedBox(height: 10),
                  Align(
                      child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Text("随便看看",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff22d47e), fontSize: 15)),
                          onTap: () => toLook(context)))
                ],
              ))
        ],
      ),
    );
  }
}
