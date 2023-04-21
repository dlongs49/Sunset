import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/pages/sign/phone_log.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/tools.dart';

class PwdLogin extends StatefulWidget {
  const PwdLogin({Key? key}) : super(key: key);

  @override
  State<PwdLogin> createState() => _PwdLoginState();
}

class _PwdLoginState extends State<PwdLogin> {
  TapGestureRecognizer useragreeall = TapGestureRecognizer();
  TapGestureRecognizer privacypolicy = TapGestureRecognizer();
  TextEditingController PhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool isShowPwd = true;
  String phone = '';
  String password = '';
  bool isPhone = false;
  bool isPwd = false;

  // 输入值
  void inputChange(String type, String str) {
    if (type == 'phone') {
      isPhone = str != "" ? true : false; // 登录高亮
      phone = str;
      setState(() {});
    }
    if (type == 'pwd') {
      password = str;
      isPwd = str != "" ? true : false; // 登录高亮
      setState(() {});
    }
    if (type == 'clear') {
      PhoneController.clear(); // 清除输入的值
      isPhone = false;
      phone = '';
      setState(() {});
    }
  }

  // 密码是否可见
  void handleIsShowPwd() {
    isShowPwd = !isShowPwd;
    setState(() {});
  }

  Sign sign = new Sign();

  // 登录
  Future<void> handleLogin() async {
    // 手机号 验证码 选中协议 登录按钮高亮
    if (!isPhone || !isPwd || !isCheck) {
      return;
    }
    final p = md5Tools(password); // 密码 md5 加密  后台在加一层密
    Map<String, String> map = new Map();
    map["phone"] = phone;
    map["password"] = p.toString();
    try {
      var ld = loading(seconds: 3);

      Map res = await sign.pwdLogin(map);
      print("ms_token>>> ${res["data"]}");
      if (res["code"] == -1) {
        toast(res["message"]);
        return;
      }
      // 将 token 存在缓存中
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("ms_token", res["data"]);
      Navigator.pushNamed(context, '/');
    } catch (e) {
      errToast();
    }
  }

  void toPage(dynamic item) {
    Navigator.pushNamed(context, item);
  }

  //跳转并关闭并销毁当前页面 验证码登录页面
  void toPhoneLog(context) {
    Navigator.pushAndRemoveUntil(
      context,
      new CupertinoPageRoute(builder: (context) => new PhoneLogin()),
      (route) => route == null,
    );
  }
  // 随便看看
  void toLook(context) async{
    if(!isCheck){
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
              color: Colors.white,
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
                        onTap: () => toPhoneLog(context)),
                  )
                ],
              ),
            ),
          ]),
          Container(
            constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
            margin: EdgeInsets.symmetric(vertical: 50),
            child: Image.asset("assets/images/200x200.png",width: 80,height: 80,),
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
                          onTap: () {
                            inputChange('clear', '');
                          },
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
                                    obscureText: isShowPwd,
                                    // 下一步
                                    textInputAction: TextInputAction.next,
                                    // 数字键盘
                                    keyboardType: TextInputType.number,
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
                                    onChanged: (value) =>
                                        inputChange('pwd', value)))),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                  IconData(isShowPwd ? 0xe66b : 0xe624,
                                      fontFamily: 'sunfont'),
                                  size: 24,
                                  color: Color(0xffbababa))),
                          onTap: handleIsShowPwd,
                        )
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
                                    color: Color(0xffb4b3b3), fontSize: 14)),
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
                            color: Color(isPhone && isPwd && isCheck
                                ? 0xff22d47e
                                : 0xffebebeb),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            highlightColor: Color(isPhone && isPwd && isCheck
                                ? 0xff11a55f
                                : 0xffebebeb), // 水波纹高亮颜色
                            child: Container(
                              alignment: Alignment(0, 0),
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text("登录",
                                  style: TextStyle(
                                      color: Color(isPhone && isPwd && isCheck
                                          ? 0xffffffff
                                          : 0xffcacaca),
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
                          onTap: () => toPage('forgetPwd')),
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
                          onTap: () => toLook(context))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
