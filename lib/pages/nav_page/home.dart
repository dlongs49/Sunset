import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/local_data/home.dart';
import 'package:sunset/provider/global.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/api/home_req.dart';
import 'package:sunset/utils/request.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController navController = ScrollController();

  @override
  void initState() {
    super.initState();
    navController.addListener(() {
      double _barScrollX =
          (navController.offset * navTrackWidth) / listViewWidth;
      setState(() {
        barScrollX = _barScrollX;
      });
      print("滑动的距离>> $barScrollX");
    });

    // startTimer();
    getUInfo();
    getBanner();
    getTrends();
    getKnow();
  }

  Sign sign = new Sign();

  Map uinfo = new Map();

  // 个人信息
  void getUInfo() async {
    try {
      Map res = await sign.getUInfo();
      if (res["code"] == 200) {
        print("个人信息>>> ${res["data"]["nickname"]}");
        uinfo = res["data"];
        isShows = true;
      } else {
        uinfo = {};
        blIsShow = isShows = false;
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("未登录>>$e");
    }
  }

  HomeReq homeReq = new HomeReq();
  List<Map> banner = [];

  // 轮播图
  void getBanner() async {
    try {
      Map res = await homeReq.getBanner();
      if (res['code'] == 200) {
        res["data"].forEach((el) {
          Map<String, String> map = new Map();
          map["images"] = baseUrl + el["images"];
          map["url"] = el["url"];
          banner.add(map);
        });
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  List trendsList = [];

  // 人气动态
  void getTrends() async {
    try {
      Map res = await homeReq.getTrends({"page_num": 1, "page_rows": 7});
      if (res["code"] == 200) {
        trendsList = res["data"]["list"];
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  List knowList = [];

  // 知识精选
  void getKnow() async {
    try {
      Map res =
          await homeReq.getKnow({"page_num": 1, "page_rows": 7, "isimg": true});
      if (res["code"] == 200) {
        knowList = res["data"]["list"];
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  // 页面跳转
  void toPage(String url, dynamic arg) {
    if (url == "community") {
      // Navigator.pushNamed(context, url);
    }
    if (url == "dynamicDetail") {
      Navigator.pushNamed(context, url, arguments: {"trends_id": arg["id"]});
    }
    if (url == "myDevice" || url == "knowList") {
      Navigator.pushNamed(context, url);
    }
    if (url == "knowDetail") {
      Navigator.pushNamed(context, url, arguments: {
        "isthird": arg["isthird"],
        "url": arg["url"],
        "id": arg["id"]
      });
    }
    if (url == "userInfo") {
      if (uinfo["uid"] != null) {
        Navigator.pushNamed(context, url, arguments: {"uid": uinfo["uid"]});
      }
    }
  }

  // 轮播图跳转
  void toBanner(String url) async {
    Navigator.pushNamed(context, "shopDetail", arguments: {"url": url});
  }

  final GlobalKey balanceKey = GlobalKey();
  bool blIsShow = true;
  bool isShows = false;

  void handleIsShow() {
    setState(() {
      blIsShow = !blIsShow;
    });
  }

  // 体秤信息
  Widget balanceInfo(skinColor) {
    return Container(
      key: balanceKey,
      width: double.infinity,
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 176,
      decoration: BoxDecoration(
          color: Color(skinColor),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    blIsShow
                        ? Container(
                            width: 86,
                            height: 42,
                            child: Stack(
                              children: [
                                Container(
                                  height: 42,
                                  child: Text("45",
                                      strutStyle: StrutStyle(
                                        leading: 0,
                                        height: 3.6,
                                        forceStrutHeight: true, // 关键属性 强制改为文字高度
                                      ),
                                      style: TextStyle(
                                          fontSize: 55,
                                          fontFamily: 'GenMonBold',
                                          color: Colors.white)),
                                ),
                                Positioned(
                                    top: 3,
                                    right: 3,
                                    child: Text("公斤",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xfff3f3f3)))),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Text(".10",
                                        strutStyle: StrutStyle(
                                          leading: 0,
                                          forceStrutHeight:
                                              true, // 关键属性 强制改为文字高度
                                        ),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'GenMonBold',
                                            color: Colors.white)))
                              ],
                            ))
                        : Container(
                            width: 86,
                            height: 42,
                            child: Align(
                                child: Text(
                              "**",
                              strutStyle: StrutStyle(
                                leading: 0,
                                height: 4.6,
                                forceStrutHeight: true, // 关键属性 强制改为文字高度
                              ),
                              style:
                                  TextStyle(fontSize: 70, color: Colors.white),
                            ))),
                    Text(uinfo["uid"] != null ? "5天前(03月10日 19:49)" : "暂无数据",
                        style:
                            TextStyle(fontSize: 10, color: Color(0xffeeeeee)))
                  ],
                ),
              ),
              Container(
                  height: 60,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 22,
                          child: Icon(IconData(0xec8d, fontFamily: 'sunfont'),
                              color: Color(blIsShow ? 0xd8ffffff : skinColor),
                              size: 12)),
                      Container(
                          margin: EdgeInsets.only(left: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              blIsShow
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("0.96",
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontFamily: 'GenMonBold',
                                                height: 0.1,
                                                color: Color(0xffffffff))),
                                        Text("公斤",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xffffffff)))
                                      ],
                                    )
                                  : Container(
                                      width: 86,
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "**",
                                        strutStyle: StrutStyle(
                                          leading: 0,
                                          height: 0,
                                          forceStrutHeight:
                                              true, // 关键属性 强制改为文字高度
                                        ),
                                        style: TextStyle(
                                            fontSize: 40, color: Colors.white),
                                      )),
                              SizedBox(height: 8),
                              Text(
                                  uinfo["uid"] != null
                                      ? "与2022.09.12 09:12 相比"
                                      : "暂无相比数据",
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xffeeeeee)))
                            ],
                          ))
                    ],
                  )),
              Container(
                  height: 60,
                  margin: EdgeInsets.only(right: 10),
                  child: isShows
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                              Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                    color: Color(0x40ffffff),
                                    borderRadius: BorderRadius.circular(26)),
                                child: Icon(
                                    IconData(0xe629, fontFamily: 'sunfont'),
                                    size: 12,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 6),
                              InkWell(
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                        color: Color(0x40ffffff),
                                        borderRadius:
                                            BorderRadius.circular(26)),
                                    child: Align(
                                      child: Icon(
                                          IconData(blIsShow ? 0xe66b : 0xe624,
                                              fontFamily: 'sunfont'),
                                          size: 14,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: handleIsShow)
                            ])
                      : Container())
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width - 75,
                    decoration: BoxDecoration(
                        color: Color(0x32fffff0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8))),
                    child: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: compareVos.asMap().entries.map((entry) {
                          int index = entry.key;
                          final item = entry.value;
                          return Container(
                              margin: EdgeInsets.only(
                                  right: 22, left: index == 0 ? 15 : 0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text(item['name'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                      blIsShow
                                          ? Container(
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(
                                                  left: 6,
                                                  right: 6,
                                                  top: 2,
                                                  bottom: 1),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(2)),
                                              child: Align(
                                                  child: Text(item["level"],
                                                      style: TextStyle(
                                                          fontSize: 9,
                                                          color: Color(
                                                              0xffe75d39)))),
                                            )
                                          : Container()
                                    ]),
                                    SizedBox(height: 6),
                                    blIsShow
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(item["num"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12)),
                                              SizedBox(width: 5),
                                              Icon(
                                                  IconData(
                                                      item["upOrDown"] == 1
                                                          ? 0xec8d
                                                          : 0xe630,
                                                      fontFamily: 'sunfont'),
                                                  size: 10,
                                                  color: Color(0xabffffff)),
                                              Text(item["changeValue"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12))
                                            ],
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            child: Text("***",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12)))
                                  ]));
                        }).toList())),
                Container(
                    width: 24,
                    decoration: BoxDecoration(
                        color: Color(0x59ffffff),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Align(
                        child: Icon(IconData(0xeb8a, fontFamily: 'sunfont'),
                            color: Color(0xffffffff), size: 10)))
              ],
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  // 我的设备
  Widget MyDeviceComm() {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      padding: EdgeInsets.only(top: 15, bottom: 10, left: 15, right: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("我的设备",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
              InkWell(
                  child: Container(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Text("更多设备",
                            style: TextStyle(
                                color: Color.fromRGBO(120, 120, 120, 1),
                                fontSize: 12)),
                        SizedBox(width: 5),
                        Icon(IconData(0xeb8a, fontFamily: 'sunfont'),
                            size: 10, color: Color.fromRGBO(120, 120, 120, 1))
                      ])),
                  onTap: () => toPage("myDevice", null))
            ],
          ),
          Container(
              width: double.infinity,
              height: 75,
              margin: EdgeInsets.only(top: 14, bottom: 12),
              child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: deviceList.map((item) {
                    return InkWell(
                      child: Container(
                          margin:
                              EdgeInsets.only(right: item['id'] != 4 ? 50 : 0),
                          child: Column(
                            children: [
                              Container(
                                  width: 46,
                                  height: 46,
                                  margin: EdgeInsets.only(bottom: 7),
                                  child: Align(
                                      child: Image.asset(item['image'],
                                          fit: BoxFit.cover))),
                              SizedBox(height: 4),
                              Text(
                                item['title'],
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )),
                      onTap: () {
                        print(item);
                      },
                    );
                  }).toList()))
        ],
      ),
    );
  }

  // 人气动态
  Widget MyPopTrendComm() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("人气动态",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 14)),
                InkWell(
                    child: Container(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("更多动态",
                                  style: TextStyle(
                                      color: Color.fromRGBO(120, 120, 120, 1),
                                      fontSize: 12)),
                              SizedBox(width: 5),
                              Icon(IconData(0xeb8a, fontFamily: 'sunfont'),
                                  size: 10,
                                  color: Color.fromRGBO(120, 120, 120, 1))
                            ])),
                    onTap: () => toPage("community", null))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: trendsList.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                    child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                        "${baseUrl}${trendsList[index]['images'][0]}",
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 120,
                                        errorBuilder: (ctx, err, stackTrace) =>
                                            Image.asset(
                                                'assets/images/lazy.png',
                                                fit: BoxFit.fill,
                                                height: 120,
                                                width: 120))),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Align(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 3,
                                            bottom: 3),
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Text(
                                            "${trendsList[index]["star"] != null ? trendsList[index]["star"] : "0"}人点赞",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white))),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: 120,
                              height: 34,
                              child: Text(trendsList[index]["text"],
                                  maxLines: 2,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 5),
                                      width: 20,
                                      height: 20,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Image.network(
                                          "${baseUrl}${trendsList[index]["avator"]}",
                                          fit: BoxFit.cover,
                                          errorBuilder: (ctx, err,
                                                  stackTrace) =>
                                              Image.asset(
                                                  'assets/images/sunset.png',
                                                  fit: BoxFit.fill,
                                                  height: 20,
                                                  width: 20))),
                                  Container(
                                    width: 80,
                                    child: Text(trendsList[index]["nickname"],
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                108, 107, 113, 1))),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                    onTap: () => toPage("dynamicDetail", trendsList[index]));
              },
            ),
          ),
        ],
      ),
    );
  }

  // 知识精选
  Widget MyKnowLedgeComm() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("知识精选",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 14)),
                InkWell(
                    child: Container(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("更多知识",
                                  style: TextStyle(
                                      color: Color.fromRGBO(120, 120, 120, 1),
                                      fontSize: 12)),
                              SizedBox(width: 5),
                              Icon(IconData(0xeb8a, fontFamily: 'sunfont'),
                                  size: 10,
                                  color: Color.fromRGBO(120, 120, 120, 1))
                            ])),
                    onTap: () => toPage("knowList", null))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 140,
            // margin: EdgeInsets.only(top: 18),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: knowList.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                      child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 94,
                                          decoration: BoxDecoration(
                                              color: Color(0xffeeeeee),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Image.network(
                                              knowList[index]["isthird"] == 1
                                                  ? knowList[index]["cover_img"]
                                                  : baseUrl +
                                                      knowList[index]
                                                          ["cover_img"],
                                              fit: BoxFit.cover,
                                              width: 120,
                                              height: 94,
                                              errorBuilder: (ctx, err,
                                                      stackTrace) =>
                                                  Image.asset(
                                                      'assets/images/lazy.png',
                                                      fit: BoxFit.fill,
                                                      height: 120,
                                                      width: 120)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Align(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 3,
                                              bottom: 3),
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Text(
                                              knowList[index]["like_num"]
                                                      .toString() +
                                                  "人收藏",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white))),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 120,
                                child: Text(knowList[index]["title"],
                                    maxLines: 2,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                              )
                            ],
                          )),
                      onTap: () => toPage("knowDetail", knowList[index]));
                }),
          ),
        ],
      ),
    );
  }

  double barScrollX = 0;
  double listViewWidth = 76.0 * navList.length; // listView宽度
  double navTrackWidth = 30; // 轨道
  double navBarWidth = 15; // 滑块

  // 公告滚动 [待修正]
  late PageController pageController;
  final Duration duration = Duration(seconds: 3);
  late Timer timer;

  void startTimer() {
    pageController = PageController();
    timer = Timer.periodic(duration, (timer) {
      if (pageController.page == 1.0) {
        pageController.jumpToPage(0);
      } else {
        pageController.jumpToPage(1);
      }
      // print(pageController.page);

      pageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.linear);
    });
  }

  // 跳转设备管理页面
  @override
  void toDevice() {
    Navigator.pushNamed(context, 'myDevice');
  }

  @override
  Widget build(BuildContext context) {
    double topBarHeight = MediaQueryData.fromWindow(window).padding.top;
    final skinColor = Provider.of<Global>(context).color;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(children: [
            Container(
              height: topBarHeight,
              color: Color(0xFFF6F7FB),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 46.0,
              color: Color.fromRGBO(246, 247, 251, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(right: 10),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: Image.network("${baseUrl}${uinfo["avator"]}",
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stackTrace) =>
                                  Image.asset('assets/images/sunset.png',
                                      width: double.infinity)),
                        ),
                        onTap: () => toPage("userInfo", uinfo),
                      ),
                      Text(
                        "我",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  InkWell(
                      child: Row(
                        children: [
                          Text(
                            "设备",
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Icon(
                                  IconData(0xe720, fontFamily: 'sunfont'),
                                  color: Colors.black,
                                  size: 21.0)),
                        ],
                      ),
                      onTap: toDevice)
                ],
              ),
            ),
          ]),
          Expanded(
            child: ListView(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                // ClampingScrollPhysics 安卓滑动效果 BouncingScrollPhysics IOS滑动效果
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            balanceInfo(skinColor),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 15, right: 15),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: Row(
                                children: [
                                  Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Color(skinColor)),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Icon(
                                          IconData(0xe62c,
                                              fontFamily: 'sunfont'),
                                          color: Colors.black,
                                          size: 10.0)),
                                  Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 200),
                                      height: 20,
                                      margin: EdgeInsets.only(left: 8),
                                      child: PageView.builder(
                                          scrollDirection: Axis.vertical,
                                          // controller: pageController,
                                          itemCount: annBanner.length,
                                          itemBuilder: (bubuildContext, index) {
                                            return (Text(
                                                annBanner[index]['title'],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )));
                                          })),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color:
                                            Color.fromRGBO(246, 247, 251, 1)),
                                    child: Icon(
                                        IconData(0xeb8a, fontFamily: 'sunfont'),
                                        color: Colors.black,
                                        size: 8),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Column(children: [
                          Container(
                              width: double.infinity,
                              height: 78,
                              child: ListView(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                controller: navController,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: navList.map((item) {
                                        return InkWell(
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  right:
                                                      item['id'] == 5 ? 0 : 15),
                                              child: Column(
                                                children: [
                                                  Container(
                                                      child: Align(
                                                          child: Image.asset(
                                                              item["image"],
                                                              width: 60))),
                                                  Text(
                                                    item["title"],
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ],
                                              )),
                                          onTap: () {
                                            print(item);
                                          },
                                        );
                                      }).toList())
                                ],
                              )),
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              Container(
                                width: navTrackWidth,
                                height: 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Color(0xffecedf2)),
                              ),
                              Positioned(
                                  left: barScrollX,
                                  child: Container(
                                    width: navBarWidth,
                                    height: 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Color(skinColor)),
                                  ))
                            ],
                          )
                        ]),
                        SizedBox(height: 14),
                        Container(
                          width: double.infinity,
                          height: 110,
                          padding: EdgeInsets.only(right: 16),
                          clipBehavior: Clip.hardEdge,
                          // 超出隐藏，overflow
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 140,
                                    height: 110,
                                    child: Image.asset(
                                        "assets/images/jihua.jpg",
                                        fit: BoxFit.cover)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("立即设置目标体重",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800)),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: Color(skinColor),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Align(
                                          child: Text("开始计划",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white))),
                                    )
                                  ],
                                )
                              ]),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 14),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 16, bottom: 22),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("饮食&运动记录",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 14)),
                                          Container(
                                              // 点击事件
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                Text("更多食谱",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            120, 120, 120, 1),
                                                        fontSize: 12)),
                                                SizedBox(width: 5),
                                                Icon(
                                                    IconData(0xeb8a,
                                                        fontFamily: 'sunfont'),
                                                    size: 10,
                                                    color: Color.fromRGBO(
                                                        120, 120, 120, 1))
                                              ]))
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(children: [
                                                  Text("还可以吃",
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                  SizedBox(width: 5),
                                                  Icon(
                                                      IconData(0xeb8a,
                                                          fontFamily:
                                                              'sunfont'),
                                                      size: 10,
                                                      color: Colors.black)
                                                ]),
                                                SizedBox(height: 3),
                                                Row(children: [
                                                  Text("1998",
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25,
                                                          fontFamily:
                                                              "PingFang SC")),
                                                  Text("千卡",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 10,
                                                          height: 2.6))
                                                ]),
                                                Container(
                                                    width: 120,
                                                    height: 5,
                                                    margin: EdgeInsets.only(
                                                        top: 4, bottom: 4),
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            237, 236, 242, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                                Text("推荐摄入1998千卡",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color.fromRGBO(
                                                            191, 191, 193, 1)))
                                              ],
                                            ),
                                            Container(
                                              width: 150,
                                              height: 90,
                                              child:ClipRRect(
                                                borderRadius: BorderRadius.circular(6),
                                                child: Image.network(
                                                  "https://image.findlinked.cn/xiangrui/2023-01-11/fc00cecd-50f5-4e94-a28d-a2d558069a3a.jpg",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 14, left: 15, right: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: mealsList.map((item) {
                                        return InkWell(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 8,
                                                  bottom: 8),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      246, 247, 251, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                      IconData(item['icon'],
                                                          fontFamily:
                                                              'sunfont'),
                                                      size: 20,
                                                      color: Colors.black),
                                                  SizedBox(height: 5),
                                                  Text(item['title'],
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black))
                                                ],
                                              ),
                                            ),
                                            onTap: () {});
                                      }).toList()),
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 130,
                                    margin: EdgeInsets.only(top: 14),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Swiper(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: new Image.network(
                                                banner[index]["images"],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            onTap: () =>
                                                toBanner(banner[index]['url']));
                                      },
                                      // 图片数量
                                      itemCount: banner.length,
                                      // 分页器
                                      pagination: new SwiperPagination(
                                        builder: DotSwiperPaginationBuilder(
                                          size: 7,
                                          // 未选中点大小
                                          activeSize: 8,
                                          // 选中点大小
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.7),
                                          // 未选中点颜色
                                          activeColor:
                                              Color.fromRGBO(102, 101, 78, 0.8),
                                          // 选中点颜色
                                          space: 3,
                                        ),
                                      ),
                                      // 左右箭头
                                      control: null,
                                      // new SwiperControl(),
                                      // 无限循环
                                      loop: true,
                                      // 自动轮播
                                      autoplay: true,
                                      // 动画时间
                                      duration: 500,
                                    )),
                                MyDeviceComm(), // 我的设备
                                MyPopTrendComm(), // 人气动态
                                MyKnowLedgeComm(), // 知识精选
                                SizedBox(height: 30)
                              ],
                            ))
                      ],
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
