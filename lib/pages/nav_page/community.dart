import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/trends_req.dart';
import 'package:sunset/utils/request.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> with TickerProviderStateMixin {
  List tabBar = ["最新", "精选", "关注"];
  List<dynamic> list = [];
  int total = 0; // 动态总数
  Map<String, dynamic> pageMap = {"page_num": 1, "page_rows": 6};
  int activeBar = 0;
  double tranBar = 75; // 初始值为头像宽度+右边距

  late AnimationController _controller;
  late Animation<Offset> offsetAnimation;
  double sx = 2.7;
  double ex = 2.7;
  TrendsReq trendsReq = new TrendsReq();
  late ScrollController listViewController;


  @override
  void initState() {
    super.initState();
    listViewController = ScrollController();
    listViewController.addListener(() {
      double offset = listViewController.offset;
      double maxOffset = listViewController.position.maxScrollExtent;
      if(offset >= maxOffset){
        toast("到底了");
      }
    });
    changeTabBarAn(0);
    getTrends();
  }

  // 最新的动态列表
  void getTrends() async {
    try {
      Map res = await trendsReq.getTrends(pageMap);
      print("动态列表>>${res["data"]}");
      if (res["code"] == 200) {
        list = res["data"]["list"];
        total = res["data"]["total"];
        setState(() {});
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  @override
  void changeTabBarAn(int index) {
    if (index == 0) {
      sx = 2.7;
      ex = 2.7;
    } else if (index == 1) {
      sx = 2.7;
      ex = 6.1;
    } else {
      sx = 6.1;
      ex = 9.6;
    }
    _controller = AnimationController(
      duration: const Duration(milliseconds: 160),
      vsync: this,
    );
    offsetAnimation = Tween<Offset>(begin: Offset(sx, 0), end: Offset(ex, 0))
        .animate(_controller);
    _controller.forward();
  }

  void toPage(String path, dynamic arg) {
    Map<String, dynamic> arguments = new Map();
    if (path == "userInfo" || path == "dynamicDetail") {
      arguments["uid"] = arg["uid"];
      arguments["trends_id"] = arg["id"];
      Navigator.pushNamed(context, path, arguments: arguments);
    }
    if (path == "pubTrends") {
      Navigator.pushNamed(context, path);
    }
  }

  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
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
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(right: 40),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: Image.asset("assets/images/3044.jpg",
                              fit: BoxFit.cover),
                        ),
                        onTap: () => toPage("userInfo", null),
                      ),
                      Expanded(
                          child: Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: tabBar.asMap().entries.map((entry) {
                              int index = entry.key;
                              String item = entry.value;
                              return Expanded(
                                  child: InkWell(
                                      child: Container(
                                          alignment: index == 0
                                              ? Alignment.centerLeft
                                              : index == 1
                                                  ? Alignment.center
                                                  : Alignment.centerRight,
                                          height: 34,
                                          child: Text(item,
                                              style: TextStyle(
                                                  color: Color(
                                                      activeBar == index
                                                          ? 0xff000000
                                                          : 0xffc2c2c2),
                                                  fontSize: activeBar == index
                                                      ? 20
                                                      : 16,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                      onTap: () {
                                        setState(() {
                                          activeBar = index;
                                          if (index == 0) {
                                            tranBar = 75; // 初始值为头像宽度+右边距
                                          } else if (index == 1) {
                                            tranBar = (mWidth / 2) -
                                                26; // 26：变粗字体的宽度，粗略估计
                                          } else if (index == 2) {
                                            tranBar = mWidth -
                                                55 -
                                                44 -
                                                8 -
                                                20; // 55：左边头像宽度+左边距  44：右边铃铛宽度+右边距  10：字体的宽度取半 粗略估计
                                          }
                                        });
                                        changeTabBarAn(activeBar);
                                      }));
                            }).toList()),
                      )),
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        width: 24,
                        height: 28,
                        child: Stack(
                          children: [
                            Positioned(
                                top: 4,
                                child: Icon(
                                    IconData(0xe60a, fontFamily: 'sunfont'),
                                    color: Colors.black,
                                    size: 20.0)),
                            Positioned(
                                top: 3,
                                right: 4,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 4, right: 4, top: 0, bottom: 0),
                                  decoration: BoxDecoration(
                                      color: Color(0xffff5c5c),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text("2",
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white)),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  // Transform(
                  //     alignment: Alignment.bottomRight,
                  //     transform: Matrix4.translationValues(tranBar, -6, 0),
                  //     child: Container(
                  //       width: 28,
                  //       height: 6,
                  //       margin: EdgeInsets.only(top: 4),
                  //       decoration: BoxDecoration(
                  //           color: Color(0xff22d47e),
                  //           borderRadius: BorderRadius.circular(4)),
                  //     ))
                  SlideTransition(
                      position: offsetAnimation,
                      child: Container(
                        width: 28,
                        height: 6,
                        // margin: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                            color: Color(0xff22d47e),
                            borderRadius: BorderRadius.circular(4)),
                      ))
                ],
              )),
        ]),
        Expanded(
            child: Stack(children: [
          ListView.builder(
              // 取消顶部留白
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              // ClampingScrollPhysics 安卓滑动效果 BouncingScrollPhysics IOS滑动效果
              itemCount: list.length,
              controller: listViewController,
              itemBuilder: (ctx, index) {
                return Container(
                    width: double.infinity,
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            InkWell(
                              child: Container(
                                  width: 38,
                                  height: 38,
                                  margin: EdgeInsets.only(right: 8),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(38),
                                      child: Image.network(
                                          "${baseUrl}${list[index]["avator"]}",
                                          fit: BoxFit.cover))),
                              onTap: () => toPage("userInfo", list[index]),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(list[index]["nickname"],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800)),
                                SizedBox(height: 2),
                                Text(
                                    formatDate(
                                        DateTime.parse(
                                            list[index]["create_time"]),
                                        [yyyy, '.', mm, '.', dd]),
                                    style: TextStyle(
                                        fontSize: 11, color: Color(0xffc1c1c1)))
                              ],
                            ),
                            Spacer(flex: 1),
                            Container(
                              width: 60,
                              height: 26,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Color(0xff22d47e)),
                                  borderRadius: BorderRadius.circular(22)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(IconData(0xeaf3, fontFamily: 'sunfont'),
                                      size: 10, color: Color(0xff22d47e)),
                                  Text("关注",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff22d47e)))
                                ],
                              ),
                            )
                          ]),
                          InkWell(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 10, bottom: 15),
                                child: Text(list[index]["text"],
                                    style:
                                        TextStyle(fontSize: 14, height: 1.7)),
                              ),
                              onTap: () =>
                                  toPage("dynamicDetail", list[index])),
                          list[index]["images"] != null &&
                                  list[index]["images"].length != 0
                              ? Container(
                                  child: GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: list[index]["images"].length,
                                      physics: NeverScrollableScrollPhysics(),
                                      // 禁止滑动
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, // 主轴一行的数量
                                        mainAxisSpacing: 6, // 主轴每行间距
                                        crossAxisSpacing: 6, // 交叉轴每行间距
                                        childAspectRatio: 1, // item的宽高比
                                      ),
                                      itemBuilder: (context, idx) {
                                        return (Container(
                                            decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "$baseUrl${list[index]["images"][idx]}"),
                                                    fit: BoxFit.fitWidth),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(6)))));
                                      }))
                              : Container(),
                          Container(
                              margin: EdgeInsets.only(top: 12, bottom: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Color(0xfff3f3f3),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text("#运动就是坚持#",
                                  style: TextStyle(
                                      color: Color(0xff22d47e), fontSize: 12))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(IconData(0xec7f, fontFamily: 'sunfont'),
                                      size: 18, color: Color(0xffbbbbbb)),
                                  SizedBox(width: 6),
                                  Text("赞",
                                      style: TextStyle(
                                          color: Color(0xffbbbbbb),
                                          height: 1.5,
                                          fontSize: 14)),
                                  SizedBox(width: 4),
                                  Text(
                                      list[index]["star"] != null
                                          ? list[index]["star"]
                                          : "",
                                      style: TextStyle(
                                          color: Color(0xffbbbbbb),
                                          height: 1.7,
                                          fontSize: 14))
                                ],
                              ),
                              InkWell(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                          IconData(0xe600,
                                              fontFamily: 'sunfont'),
                                          size: 20,
                                          color: Color(0xffbbbbbb)),
                                      SizedBox(width: 6),
                                      Text("评论",
                                          style: TextStyle(
                                              color: Color(0xffbbbbbb),
                                              height: 1.4,
                                              fontSize: 14)),
                                      SizedBox(width: 4),
                                      Text(
                                          list[index]["comment_num"].toString(),
                                          style: TextStyle(
                                              color: Color(0xffbbbbbb),
                                              height: 1.4,
                                              fontSize: 14))
                                    ],
                                  ),
                                  onTap: () =>
                                      toPage("dynamicDetail", list[index])),
                              Icon(IconData(0xe617, fontFamily: 'sunfont'),
                                  size: 18, color: Color(0xffbbbbbb)),
                            ],
                          ),
                          list[index]["comment_num"] != 0
                              ? InkWell(
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 14),
                                    constraints: BoxConstraints(minHeight: 50),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Color(0xfff3f3f3),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: list[index]["comment_list"]
                                              .asMap()
                                              .entries
                                              .map<Widget>((entry) {
                                            final item = entry.value;
                                            return Container(
                                                alignment: Alignment.topLeft,
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: item["nickname"] +
                                                            "：",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff22d47e),
                                                            fontSize: 13),
                                                        children: <TextSpan>[
                                                      TextSpan(
                                                          text: item["comment"],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12)),
                                                    ])));
                                          }).toList(),
                                        ),
                                        list[index]["comment_num"] > 3
                                            ? Text("查看全部评论",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff7b7b7b)))
                                            : Container()
                                      ],
                                    ),
                                  ),
                                  onTap: () =>
                                      toPage("dynamicDetail", list[index]))
                              : Container()
                        ]));
              }),
          Positioned(
              bottom: 50,
              right: 30,
              child: InkWell(
                  borderRadius: new BorderRadius.all(
                      new Radius.circular(70.0)), // 点击水波纹是圆角的，默认是矩形的
                  child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xff22d47e),
                          borderRadius: BorderRadius.circular(70),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5), // 阴影颜色
                              offset: Offset(10, 20), // 阴影与容器的距离 x,y
                              blurRadius: 40.0, // 高斯模糊值。
                              spreadRadius: 2.0, // 阴影范围量
                            ),
                          ]),
                      child: Align(
                          child: Icon(IconData(0xe609, fontFamily: 'sunfont'),
                              size: 34, color: Colors.white))),
                  onTap: () => toPage("pubTrends", null)))
        ]))
      ],
    );
  }
}
