import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/provider/global.dart'; // 弹框插件
class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {

  //解除绑定
  @override
  void onRemoveBind(){
    Navigator.of(context).pop();
  }
  @override
  void onGuide(){
    Fluttertoast.showToast(
        msg: "操作指南",
        toastLength: Toast.LENGTH_SHORT, // 停留时长短 & 长
        gravity: ToastGravity.CENTER, // 弹框是否居中
        backgroundColor: Color(0xd23b3b3b),
        textColor: Colors.white,
        fontSize: 16.0);
  }
  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    final skinColor = Provider.of<Global>(context).color;
    return Scaffold(
        body: Column(
      children: [
        Column(children: [
          CustomTabBar(title: "操作指南", bgColor: skinColor, fontColor: 0xffffffff),
          Container(
            width: double.infinity,
            height: 140,
            padding: EdgeInsets.only(bottom: 20),
            color: Color(skinColor),
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/images/tzc.png", width: 70, height: 70),
          ),
        ]),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.3, //宽度
                    color: Color(0xffe0e0e0), //边框颜色
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("合并频繁称重记录", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text(
                    "体重间隔30秒内，只保留最后一次",
                    style: TextStyle(fontSize: 12, color: Color(0xffacacac)),
                  )
                ],
              ),
            ),
            InkWell(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.3, //宽度
                        color: Color(0xffe0e0e0), //边框颜色
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("蓝牙智能秤操作指南", style: TextStyle(fontSize: 16)),
                      Icon(IconData(0xeb8a, fontFamily: 'sunfont'),
                          color: Color(0xffbdbdbd), size: 14)
                    ],
                  ),
                ),
                onTap: onGuide),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.3, //宽度
                    color: Color(0xffe0e0e0), //边框颜色
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("蓝牙地址", style: TextStyle(fontSize: 16)),
                  Text("20230318",
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 14,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Spacer(flex: 1),
            InkWell(
                borderRadius: new BorderRadius.all(
                    new Radius.circular(30.0)), // 点击水波纹是圆角的，默认是矩形的
                child: Container(
                  alignment: Alignment(0, 0),
                  width: mWidth - 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Color(0xffe82916)),
                      borderRadius: BorderRadius.circular(30)),
                  child: Align(
                      child: Text("解除绑定",
                          style: TextStyle(
                              color: Color(0xffe82916),
                              fontSize: 20,
                              fontWeight: FontWeight.w600))),
                ),
                onTap: onRemoveBind),
            SizedBox(height: 30)
          ],
        ))
      ],
    ));
  }
}
