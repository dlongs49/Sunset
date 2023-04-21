import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
// 提示 Toast
void toast(text, {double y = -0.5}) {
  var showText = BotToast.showText(
      text: text,
      align: Alignment(0, y),
      contentColor: Color(0xbf000000),
      borderRadius: BorderRadius.all(Radius.circular(6)),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      textStyle: TextStyle(fontSize: 15, color: Colors.white),
      animationDuration: Duration(milliseconds: 1) // 动画执行
      );
  const timeout = const Duration(seconds: 1);
  Timer(timeout, (){
    showText();
  });
}

// 服务器异常 Toast
void errToast({double y = -0.5}) {
  BotToast.showText(
      text: "服务器异常",
      align: Alignment(0, y),
      contentColor: Color(0xbf000000),
      borderRadius: BorderRadius.all(Radius.circular(6)),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      textStyle: TextStyle(fontSize: 15, color: Colors.white),
      animationDuration: Duration(milliseconds: 1) // 动画执行
      );
}

//加载 Toast
Function loading({double y = 0, final seconds = null}) {
 return BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) {
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              color: Color(0xbf000000),
              borderRadius: BorderRadius.circular(10)),
          child: Image.asset("assets/gif/loading.gif"),
        );
      },
      backgroundColor: Color(0x0),
      align: Alignment(0, y),
      duration: seconds == null ? null : Duration(seconds: seconds));
}

// 提示
void showToast(msg) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: msg,
      timeInSecForIosWeb: 1,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Color(0xd23b3b3b),
      textColor: Colors.white,
      fontSize: 16.0);
}
// 未登录 Dialog
void showIsLogDialog(BuildContext context) {
  final width = MediaQueryData.fromWindow(window).size.width;
  showDialog(
      context: context,
      builder: (ctx) => Container(
        color: Color(0x7e000000),
        child: Center(
            child: Container(
              width: width - 80,
              height: 150,
              padding:
              EdgeInsets.only(right: 24, left: 24, top: 20, bottom: 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(children: [
                Text("登录提示",
                    style:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                SizedBox(height: 10),
                Text("暂未登录，请先登录~",
                    style: TextStyle(color: Color(0xff808080), fontSize: 15)),
                SizedBox(height: 15),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text("取消",
                                  style: TextStyle(
                                      color: Color(0xffb8b8b8),
                                      fontSize: 16)),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text("立即登录",
                                  style: TextStyle(
                                      color: Color(0xff22d47e),
                                      fontSize: 16)),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, "phoneLog");
                            },
                          ),
                        )
                      ],
                    ))
              ]),
            )),
      ));
}