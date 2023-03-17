import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Find extends StatefulWidget {
  const Find({Key? key}) : super(key: key);

  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  List list = [];

  @override
  Widget build(BuildContext context) {
    double topBarHeight = MediaQueryData.fromWindow(window).padding.top;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(children: [
          Container(
            height: topBarHeight,
            color: Color(0xffF6F7FB),
          ),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              color: Color(0xffF6F7FB),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: 34,
                      child: Text("好物精选",
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 20,
                              fontWeight: FontWeight.w800))),
                  Container(
                    width: 28,
                    height: 6,
                    decoration: BoxDecoration(
                        color: Color(0xffee602e),
                        borderRadius: BorderRadius.circular(4)),
                  )
                ],
              )),
        ]),
        Expanded(
            child: MediaQuery.removePadding(
                // 去除顶部留白
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 30),
                    physics: BouncingScrollPhysics(), // IOS的回弹属性
                    itemCount: 12,
                    itemBuilder: (context, i) => Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width: 5,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Color(0xffee602e),
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  SizedBox(width: 6),
                                  Text("饮品",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                              SizedBox(height: 20),
                              GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: 6,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // 主轴一行的数量
                                    mainAxisSpacing: 15, // 主轴每行间距
                                    crossAxisSpacing: 10, // 交叉轴每行间距
                                    childAspectRatio: 1, // item的宽高比
                                  ),
                                  itemBuilder: (context, index) => Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      )),
                              SizedBox(height: 20)
                            ],
                          ),
                        ))))
      ],
    );
  }
}
