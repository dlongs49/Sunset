import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key,this.bgColor,this.title,this.fontColor}) : super(key: key);
  final bgColor;
  final fontColor;
  final title;
  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    final bgColor = widget.bgColor != null ? widget.bgColor : 0xffffffff;
    final fontColor = widget.fontColor != null ? widget.fontColor : 0xff000000;
    final title = widget.title != null ? widget.title : '未知页面';
    print("页面标题>> ${title}");
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    void toBack(){
      Navigator.of(context).pop();
    }
    return  Column(children: [
      Container(
          width: double.infinity,
          padding: EdgeInsets.only(top:topBarHeight,bottom: 4),
          color: Color(bgColor),
          child: Stack(
            children: [
              GestureDetector(
                  child: Container(
                      width: 50,
                      height: 40,
                      child: Icon(IconData(0xec8e, fontFamily: 'sunfont'),
                          color: Color(fontColor), size: 18.0)),
                  behavior: HitTestBehavior.opaque, // 点击整个区域有响应事件，
                  onTap: toBack),
              Positioned(
                  left: 0,
                  right: 0,
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(fontColor),
                          fontSize: 18,
                          height: 2.2,
                          decoration: TextDecoration.none)))
            ],
          )
      ),
    ]);
  }
}

