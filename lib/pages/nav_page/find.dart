import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class Find extends StatefulWidget {
  const Find({Key? key}) : super(key: key);

  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  List list = [];

  void toPage(String path) {
    Navigator.pushNamed(context, path);
  }

  //跳转浏览器
  void toLauncher() async {
    // 跳转的 url 淘宝的链接
    var url =
        "https://detail.tmall.com/item.htm?id=556923025304&scene=taobao_shop&spm=a312a.7700824.w15913892-23209753121.1.74a332fdQym577";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("异常");
    }
  }

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
                    physics: BouncingScrollPhysics(), // IOS的回弹属性
                    itemCount: 12,
                    itemBuilder: (context, i) => Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              InkWell(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      Image.asset("assets/images/banner_1.jpg"),
                                ),
                                onTap: toLauncher,
                              ),
                              SizedBox(height: 16),
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
                                  physics: BouncingScrollPhysics(),
                                  // IOS的回弹属性
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // 主轴一行的数量
                                    mainAxisSpacing: 15, // 主轴每行间距
                                    crossAxisSpacing: 10, // 交叉轴每行间距
                                    childAspectRatio: 1 / 1.6, // item的宽高比
                                  ),
                                  itemBuilder: (context, index) => InkWell(
                                      child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(children: [
                                            AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                  child: Image.network(
                                                    "https://gw.alicdn.com/imgextra/i2/3086666176/O1CN01NTf5HW1vUerjT60Zq_!!3086666176.jpg_Q75.jpg_.webp",
                                                    width: double.infinity,
                                                    height: 170,
                                                    fit: BoxFit.fitWidth,
                                                  )),
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: 12, right: 12),
                                                child: Column(children: [
                                                  Text("真低脂，无淀粉，少添加，多快乐",
                                                      softWrap: true,
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          height: 2.0)),
                                                  SizedBox(height: 4),
                                                  Text("真低脂，无淀粉，少添加，多快乐",
                                                      softWrap: true,
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff9c9c9c),
                                                          fontSize: 12,
                                                          height: 1.4)),
                                                  SizedBox(height: 6),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("￥14.8",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffe46135),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      SizedBox(width: 6),
                                                      Text("￥24.6",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffb8b7bd),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                          ))
                                                    ],
                                                  )
                                                ]))
                                          ])),
                                      onTap: () => toPage("shopDetail"))),
                              SizedBox(height: 20)
                            ],
                          ),
                        ))))
      ],
    );
  }
}
