import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 提示 Toast
void toast(text, {double y = -0.5}) {
  BotToast.showText(
      text: text,
      align: Alignment(0, y),
      contentColor: Color(0xbf000000),
      borderRadius: BorderRadius.all(Radius.circular(6)),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      textStyle: TextStyle(fontSize: 15, color: Colors.white),
      animationDuration: Duration(milliseconds: 1) // 动画执行
      );
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
void loading({double y = 0, final seconds = null}) {
  BotToast.showCustomLoading(
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
