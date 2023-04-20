import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key,this.bgColor,this.title,this.fontColor, arg}) : super(key: key);
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
              Positioned(
                  left: 0,
                  right: 0,
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(fontColor),
                          fontSize: 18,
                          height: 2.2,
                          decoration: TextDecoration.none))),
              // Position 在上，否则点击无效，由于 Position 应在 Container 上面
              InkWell(
                  child: Container(
                      alignment: Alignment(0,0.4),
                      width: 50,
                      height: 40,
                      child: Icon(IconData(0xec8e, fontFamily: 'sunfont'),
                          color: Color(fontColor), size: 18.0)),
                  onTap: toBack),

            ],
          )
      ),
    ]);
  }
}

