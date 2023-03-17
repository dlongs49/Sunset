import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    double topBarHeight = MediaQueryData.fromWindow(window).padding.top;
    List tabBar = ["最新", "精选", "关注"];
    List list = ['', '', '', ''];
    int activeBar = 0;
    double tranBar = 55;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(children: [
          Container(
            height: topBarHeight,
            color: Color(0xffffffff),
          ),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 46.0,
              color: Color(0xffffffff),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 20),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: Image.asset("assets/images/3044.jpg",
                            fit: BoxFit.cover),
                      ),
                      Expanded(
                          child: Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: tabBar.asMap().entries.map((entry) {
                              int index = entry.key;
                              String item = entry.value;
                              return Container(
                                  child: InkWell(
                                      child: Text(item,
                                          style: TextStyle(
                                              color: Color(activeBar == index
                                                  ? 0xff000000
                                                  : 0xffc2c2c2),
                                              fontSize:
                                                  activeBar == index ? 20 : 14,
                                              fontWeight: FontWeight.w800)),
                                      onTap: () {
                                        setState(() {
                                          activeBar = index;
                                          tranBar = index * tranBar;
                                        });
                                        print(activeBar);
                                        print(tranBar);
                                      }));
                            }).toList()),
                      )),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        width: 24,
                        height: 28,
                        child: Stack(
                          children: [
                            Positioned(
                                top: 4,
                                child: Icon(
                                    IconData(0xe60a, fontFamily: 'sunfont'),
                                    color: Colors.black,
                                    size: 19.0)),
                            Positioned(
                                top: 0,
                                right: 6,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 1, bottom: 1),
                                  decoration: BoxDecoration(
                                      color: Color(0xffff5c5c),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text("1",
                                      style: TextStyle(
                                          fontSize: 7, color: Colors.white)),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  Transform(
                      alignment: Alignment.bottomRight,
                      transform: Matrix4.translationValues(55, 0, 0),
                      child: Container(
                        width: 28,
                        height: 4,
                        margin: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                            color: Color(0xff22d47e),
                            borderRadius: BorderRadius.circular(4)),
                      ))
                ],
              )),
        ]),
        Expanded(
            child: MediaQuery.removePadding(
                // 去除顶部留白
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: list.asMap().entries.map((entry) {
                      int index = entry.key;
                      String item = entry.value;
                      return Container(
                          width: double.infinity,
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Container(
                                      width: 34,
                                      height: 34,
                                      margin: EdgeInsets.only(right: 8),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(34),
                                          child: Image.asset(
                                              "assets/images/400x400.jpg",
                                              fit: BoxFit.cover))),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("书本书华",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800)),
                                      Text("2023.03.21",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xffd9d9d9)))
                                    ],
                                  ),
                                  Spacer(flex: 1),
                                  Container(
                                    width: 50,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: Color(0xff22d47e)),
                                        borderRadius:
                                            BorderRadius.circular(22)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                            IconData(0xe727,
                                                fontFamily: 'sunfont'),
                                            size: 8,
                                            color: Color(0xff22d47e)),
                                        SizedBox(width: 2),
                                        Text("关注",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Color(0xff22d47e)))
                                      ],
                                    ),
                                  )
                                ]),
                                SizedBox(height: 10),
                                Text(
                                    "浔阳江头夜送客，枫叶荻花秋瑟瑟，主人下马客在船，举酒欲饮无管弦。醉不成欢惨将别，别时茫茫江浸月。忽闻水上琵琶声，主人忘归客不发。寻声暗问弹者谁？琵琶声停欲语迟。",
                                    style: TextStyle(fontSize: 12)),
                                Container(
                                    margin:
                                        EdgeInsets.only(top: 12, bottom: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Color(0xfff3f3f3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text("#运动就是坚持#",
                                        style: TextStyle(
                                            color: Color(0xff22d47e),
                                            fontSize: 10))),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                            IconData(0xec7f,
                                                fontFamily: 'sunfont'),
                                            size: 15,
                                            color: Color(0xffbbbbbb)),
                                        SizedBox(width: 6),
                                        Text("赞",
                                            style: TextStyle(
                                                color: Color(0xffbbbbbb),
                                                fontSize: 12)),
                                        SizedBox(width: 3),
                                        Text("2",
                                            style: TextStyle(
                                                color: Color(0xffbbbbbb),
                                                height: 1.5,
                                                fontSize: 12))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                            IconData(0xe600,
                                                fontFamily: 'sunfont'),
                                            size: 15,
                                            color: Color(0xffbbbbbb)),
                                        SizedBox(width: 6),
                                        Text("评论",
                                            style: TextStyle(
                                                color: Color(0xffbbbbbb),
                                                fontSize: 12)),
                                        SizedBox(width: 3),
                                        Text("2",
                                            style: TextStyle(
                                                color: Color(0xffbbbbbb),
                                                height: 1.5,
                                                fontSize: 12))
                                      ],
                                    ),
                                    Icon(
                                        IconData(0xe617, fontFamily: 'sunfont'),
                                        size: 18,
                                        color: Color(0xffbbbbbb)),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  margin:EdgeInsets.only(top:14),
                                  constraints: BoxConstraints(minHeight: 50),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Color(0xfff3f3f3),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              text: '书本书华：',
                                              style: TextStyle(
                                                  color: Color(0xff22d47e),fontSize: 10),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '浔阳江头夜送客，枫叶荻花秋瑟瑟',
                                                    style: TextStyle(
                                                        color: Colors.black,fontSize:10)),
                                              ])),
                                      SizedBox(height: 4),
                                      RichText(
                                          text: TextSpan(
                                              text: '书本书华：',
                                              style: TextStyle(
                                                  color: Color(0xff22d47e),fontSize: 10),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '浔阳江头夜送客，枫叶荻花秋瑟瑟',
                                                    style: TextStyle(
                                                        color: Colors.black,fontSize:10)),
                                              ])),
                                      Text("查看全部评论",style:TextStyle(fontSize: 10,color:Color(
                                          0xff9e9e9e)))
                                    ],
                                  ),
                                )
                              ]));
                    }).toList())))
      ],
    );
  }
}
