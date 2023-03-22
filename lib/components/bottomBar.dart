import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final bottomHeight = MediaQueryData.fromWindow(window).padding.bottom;
    final width = MediaQueryData.fromWindow(window).size.width;
    return Container(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              width: width,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                          width: 0.5, color: Color(0xfff3f3f3))),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x14000000),
                      offset: Offset(0, -2),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                IconData(0xe718,
                                    fontFamily: 'sunfont'),
                                size: 22,
                                color: Color(0xffb4b7be)),
                            SizedBox(height: 5),
                            Text("首页",
                                style: TextStyle(
                                    color: Color(0xffb4b7be),
                                    fontSize: 10))
                          ],
                        ),
                      ),
                      onTap: () {
                        print(123);
                      }),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconData(0xe8c5, fontFamily: 'sunfont'),
                            size: 22, color: Color(0xffb4b7be)),
                        SizedBox(height: 5),
                        Text("社区",
                            style: TextStyle(
                                color: Color(0xffb4b7be),
                                fontSize: 10))
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                    // color:Color(0xffeeeeee),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconData(0xe621, fontFamily: 'sunfont'),
                            size: 22, color: Color(0xffb4b7be)),
                        SizedBox(height: 5),
                        Text("发现",
                            style: TextStyle(
                                color: Color(0xffb4b7be),
                                fontSize: 10))
                      ],
                    ),
                  ),
                  Container(
                    // color:Color(0xffeeeeee),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconData(0xe941, fontFamily: 'sunfont'),
                            size: 22, color: Color(0xffb4b7be)),
                        SizedBox(height: 5),
                        Text("我的",
                            style: TextStyle(
                                color: Color(0xffb4b7be),
                                fontSize: 10))
                      ],
                    ),
                  )
                ],
              )),
          Positioned(
              top: -15,
              left: width / 2 - 22,
              child: InkWell(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(100)),
                        child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                color: Color(0xff22d47e),
                                borderRadius: BorderRadius.circular(40)),
                            child: Icon(
                                IconData(0xe61c, fontFamily: 'sunfont'),
                                size: 18,
                                color: Color(0xffffffff))),
                      ),
                      SizedBox(height: 2),
                      Text("称重",
                          style: TextStyle(
                              color: Color(0xffb4b7be), fontSize: 10))
                    ],
                  ),
                  onTap: () {
                    print("称重");
                  }))
        ],
      ),
    );
  }
}
