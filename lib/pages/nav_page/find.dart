import 'dart:ui';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/home_req.dart';
import 'package:sunset/utils/request.dart';
import 'package:url_launcher/url_launcher.dart';

class Find extends StatefulWidget {
  const Find({Key? key, arguments}) : super(key: key);

  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  HomeReq homeReq = new HomeReq();
  List<Map<dynamic, dynamic>> goodList = [];

  void initState() {
    super.initState();
    getBanner();
    getGoods();
  }

  List<Map> banner = [];

  // 轮播图
  void getBanner() async {
    try {
      Map res = await homeReq.getBanner();
      print("data>>> ${res}");
      if (res['code'] == 200) {
        Map<String, String> map = new Map();
        map["images"] = baseUrl + res["data"][0]["images"];
        map["url"] = res["data"][0]["url"];
        banner.add(map);
        setState(() {});
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  // 好物列表
  void getGoods() async {
    try {
      Map res = await homeReq.getGoods();
      print("好物精选>>> ${res}");
      if (res['code'] == 200) {
        goodList = res["data"].cast<Map<String, dynamic>>();
        setState(() {});
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  void toPage(String path, dynamic arg) {
    Navigator.pushNamed(context, path, arguments: arg);
  }

  //跳转浏览器 【废弃】
  void toLauncher(String url) async {
    // 跳转的 url 淘宝的链接
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
            child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(), // IOS的回弹属性
                itemCount: banner.length,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      InkWell(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(banner[index]["images"]),
                        ),
                        onTap: () => toPage("shopDetail",
                            {"url": banner[index]["url"]}),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: new NeverScrollableScrollPhysics(),
                          //禁用滑动事件
                          itemCount: goodList.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width: 5,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Color(0xffee602e),
                                          borderRadius:
                                          BorderRadius.circular(
                                              4))),
                                  SizedBox(width: 6),
                                  Text(goodList[index]["name"],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight.w600))
                                ],
                              ),
                              SizedBox(height: 20),
                              GridView.builder(
                                padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: goodList[index]
                                  ["listItem"]
                                      .length,
                                  physics: BouncingScrollPhysics(),
                                  // IOS的回弹属性
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // 主轴一行的数量
                                    mainAxisSpacing: 15, // 主轴每行间距
                                    crossAxisSpacing: 10, // 交叉轴每行间距
                                    childAspectRatio:
                                    1 / 1.6, // item的宽高比
                                  ),
                                  itemBuilder: (context, idx) =>
                                      InkWell(
                                          child: Container(
                                              width:
                                              double.infinity,
                                              decoration: BoxDecoration(
                                                  color:
                                                  Colors.white,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      10)),
                                              child: Column(
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio:
                                                      1 / 1,
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                          child: Image.network(
                                                            goodList[index]["listItem"][idx]
                                                            [
                                                            "icon"],
                                                            width: double
                                                                .infinity,
                                                            height:
                                                            170,
                                                            fit: BoxFit
                                                                .fitWidth,
                                                          )),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.only(
                                                            left:
                                                            12,
                                                            right:
                                                            12),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                  goodList[index]["listItem"][idx]["title"],
                                                                  softWrap: true,
                                                                  textAlign: TextAlign.left,
                                                                  overflow: TextOverflow.visible,
                                                                  maxLines: 1,
                                                                  style: TextStyle(color: Colors.black, fontSize: 14, height: 2.0)),
                                                              SizedBox(
                                                                  height: 4),
                                                              Text(
                                                                  goodList[index]["listItem"][idx]["subTitle"],
                                                                  softWrap: true,
                                                                  textAlign: TextAlign.left,
                                                                  overflow: TextOverflow.visible,
                                                                  maxLines: 2,
                                                                  style: TextStyle(color: Color(0xff9c9c9c), fontSize: 12, height: 1.4)),
                                                              SizedBox(
                                                                  height: 6),
                                                              Row(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                                children: [
                                                                  Text("￥${goodList[index]["listItem"][idx]["currentPrice"]}", textAlign: TextAlign.left, style: TextStyle(color: Color(0xffe46135), fontSize: 16, fontWeight: FontWeight.w600)),
                                                                  SizedBox(width: 6),
                                                                  Text("￥${goodList[index]["listItem"][idx]["originalPrice"]}",
                                                                      style: TextStyle(
                                                                        color: Color(0xffb8b7bd),
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight.w600,
                                                                        decoration: TextDecoration.lineThrough,
                                                                      ))
                                                                ],
                                                              )
                                                            ]))
                                                  ])),
                                          onTap: () => toPage(
                                              "shopDetail", {
                                            "url": goodList[
                                            index]
                                            ["listItem"]
                                            [idx]["url"]
                                          }))),
                              SizedBox(height: 20)
                            ],
                          )),
                    ],
                  ),
                )))
      ],
    );
  }
}
