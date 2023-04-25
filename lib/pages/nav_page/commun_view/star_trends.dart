import 'dart:async';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sunset/components/refresh/refresh_footer_ex.dart';
import 'package:sunset/components/refresh/refresh_header_ex.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/provider/global.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/api/trends_req.dart';
import 'package:sunset/utils/request.dart';
class StarTrends extends StatefulWidget {
  const StarTrends({Key? key}) : super(key: key);

  @override
  _StarTrendsState createState() => _StarTrendsState();
}

class _StarTrendsState extends State<StarTrends> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true; // 缓存页面，保持状态，混入 AutomaticKeepAliveClientMixin
  // 动画执行参数
  late final AnimationController controller =
  AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  late Animation<Offset> animation =
  Tween(begin: Offset.zero, end: Offset(1.5, 0.0)).animate(controller);

  List<dynamic> list = [];
  int total = 0; // 动态总数
  Map<String, dynamic> pageMap = {"page_num": 1, "page_rows": 6,"type":1};

  TrendsReq trendsReq = new TrendsReq();

  @override
  void initState() {
    super.initState();
    getUInfo();
    getTrends();
  }

  Sign sign = new Sign();
  Map uinfo = new Map();

  // 个人信息
  void getUInfo() async {
    try {
      Map res = await sign.getUInfo();
      if (res["code"] == 200) {
        uinfo = res["data"];
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  // 列表滑动中
  bool scrollIng(ScrollNotification n) {
    animation =
        Tween(begin: Offset.zero, end: Offset(1.5, 0.0)).animate(controller);
    // 开始过渡
    controller.forward();
    return false;
  }

  // 滑动结束
  bool scrollEnd(ScrollNotification n) {
    // 滑动结束 过渡过来
    controller.reverse();
    return false;
  }

  // 最新的动态列表
  Future<IndicatorResult> getTrends() async {
    try {
      Map res = await trendsReq.getTrends(pageMap);
      if (res["code"] == 200) {
        list.insertAll(list.length, res["data"]["list"]);
        total = res["data"]["total"];
        if (mounted) {
          setState(() {});
        }
        return IndicatorResult.success;
      }else{
        return IndicatorResult.fail;
      }
    } catch (e) {
      print(e);
      errToast();
      return IndicatorResult.fail;
    }
  }

  // 点赞
  void handleStar(params, index) async {
    if (uinfo["uid"] == null) {
      showIsLogDialog(context);
      return;
    }
    try {
      Map res = await trendsReq.setTrendsStar({"trends_id": params["id"]});
      if (res["code"] == 200) {
        print(">>>>>$res");
        // 成功 加状态修改
        list[index]["isstar"] = !list[index]["isstar"];
        int star = list[index]["star"];
        if (list[index]["isstar"]) {
          list[index]["star"] = star + 1;
        } else {
          list[index]["star"] = star - 1;
        }

        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  // 关注
  void handleFollow(params, index) async {
    if (uinfo["uid"] == null) {
      showIsLogDialog(context);
      return;
    }
    try {
      Map res = await trendsReq.setFollow({"uid": params["uid"]});
      if (res["code"] == 200) {
        print(">>>>>$res");
        // 成功 假状态修改保持交互
        list[index]["isfollow"] = !list[index]["isfollow"];
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  void toPage(String path, dynamic arg) {
    Map<String, dynamic> arguments = new Map();
    if (path == "userInfo" || path == "dynamicDetail") {
      arguments["uid"] = arg["uid"];
      arguments["trends_id"] = arg["id"];
      Navigator.pushNamed(context, path, arguments: arguments);
    }
    if (path == "pubTrends") {
      if (uinfo["uid"] == null) {
        showIsLogDialog(context);
        return;
      } else {
        Navigator.pushNamed(context, path);
      }
    }
  }
// 加载 刷新控制器
  EasyRefreshController _refreshController = new EasyRefreshController(
    controlFinishRefresh: false,
    controlFinishLoad: false,
  );
  // 上拉加载
  Future<IndicatorResult> onLoad() async{
    pageMap["page_num"]++;
    if (list.length >= total) {
      return IndicatorResult.noMore;
    } else {
      IndicatorResult status = await getTrends();
      return status;
    }
  }
  // 下拉刷新
  Future<IndicatorResult> onRefresh() async{
    list = [];
    pageMap["page_num"] = 1;
    IndicatorResult status = await getTrends();
    return status;
  }
  @override
  Widget build(BuildContext context) {
    final skinColor = Provider.of<Global>(context).color;
    return  Stack(children: [
      EasyRefresh(
          header: RefreshHeaderEx(),
          footer: RefreshFooterEx(),
          onRefresh: onRefresh,
          onLoad: onLoad,
          controller: _refreshController,
          child: NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) => scrollIng(notification),
            // ScrollEndNotification：滑动结束
            child: NotificationListener<ScrollEndNotification>(
                onNotification: (notification) => scrollEnd(notification),
                child: ListView.builder(
                  // 取消顶部留白
                    padding: EdgeInsets.zero,
                    itemCount: list.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                          width: double.infinity,
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 8),
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                                            borderRadius:
                                            BorderRadius.circular(38),
                                            child: Image.network(
                                                "${baseUrl}${list[index]["avator"]}",
                                                fit: BoxFit.cover,
                                                errorBuilder: (ctx, err,
                                                    stackTrace) =>
                                                    Image.asset(
                                                        'assets/images/sunset.png',
                                                        //默认显示图片
                                                        height: 38,
                                                        width:
                                                        double.infinity)))),
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
                                              fontSize: 11,
                                              color: Color(0xffc1c1c1)))
                                    ],
                                  ),
                                  Spacer(flex: 1),
                                  !list[index]["isfollow"]
                                      ? InkWell(
                                    child: Container(
                                      width: 60,
                                      height: 26,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0,
                                              color: Color(skinColor)),
                                          borderRadius:
                                          BorderRadius.circular(22)),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                              IconData(0xeaf3,
                                                  fontFamily: 'sunfont'),
                                              size: 10,
                                              color: Color(skinColor)),
                                          Text("关注",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(skinColor)))
                                        ],
                                      ),
                                    ),
                                    onTap: () =>
                                        handleFollow(list[index], index),
                                  )
                                      : Container()
                                ]),
                                InkWell(
                                    child: Container(
                                      width: double.infinity,
                                      padding:
                                      EdgeInsets.only(top: 10, bottom: 15),
                                      child: Text(list[index]["text"],
                                          style: TextStyle(
                                              fontSize: 14, height: 1.7)),
                                    ),
                                    onTap: () =>
                                        toPage("dynamicDetail", list[index])),
                                list[index]["images"] != null &&
                                    list[index]["images"].length != 0
                                    ? Container(
                                    child: GridView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount:
                                        list[index]["images"].length,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        // 禁止滑动
                                        gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3, // 主轴一行的数量
                                          mainAxisSpacing: 6, // 主轴每行间距
                                          crossAxisSpacing: 6, // 交叉轴每行间距
                                          childAspectRatio: 1, // item的宽高比
                                        ),
                                        itemBuilder: (context, idx) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xffe3e3e3),
                                                borderRadius:
                                                BorderRadius.circular(8)),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              child: Image.network(
                                                  "${baseUrl}${list[index]["images"][idx]}",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (ctx, err,
                                                      stackTrace) =>
                                                      Image.asset(
                                                          'assets/images/lazy.png',
                                                          fit: BoxFit.fill,
                                                          width: double
                                                              .infinity)),
                                            ),
                                          );
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
                                            color: Color(skinColor),
                                            fontSize: 12))),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                                IconData(
                                                    list[index]["isstar"]
                                                        ? 0xec8c
                                                        : 0xec7f,
                                                    fontFamily: 'sunfont'),
                                                size: 18,
                                                color: Color(list[index]["isstar"]
                                                    ? skinColor
                                                    : 0xffbbbbbb)),
                                            SizedBox(width: 6),
                                            Text("赞",
                                                style: TextStyle(
                                                    color: Color(list[index]
                                                    ["isstar"]
                                                        ? skinColor
                                                        : 0xffbbbbbb),
                                                    height: 1.5,
                                                    fontSize: 14)),
                                            SizedBox(width: 4),
                                            Container(
                                              width: 20,
                                              child: Text(
                                                  list[index]["star"] != 0
                                                      ? list[index]["star"]
                                                      .toString()
                                                      : "",
                                                  style: TextStyle(
                                                      color: Color(list[index]
                                                      ["isstar"]
                                                          ? skinColor
                                                          : 0xffbbbbbb),
                                                      height: 1.7,
                                                      fontSize: 14)),
                                            )
                                          ],
                                        ),
                                        onTap: () =>
                                            handleStar(list[index], index)),
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
                                                list[index]["comment_num"]
                                                    .toString(),
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
                                      constraints:
                                      BoxConstraints(minHeight: 50),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xfff3f3f3),
                                          borderRadius:
                                          BorderRadius.circular(8)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: list[index]
                                            ["comment_list"]
                                                .asMap()
                                                .entries
                                                .map<Widget>((entry) {
                                              final item = entry.value;
                                              return Container(
                                                  alignment:
                                                  Alignment.topLeft,
                                                  margin: EdgeInsets.only(
                                                      bottom: 6),
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: item[
                                                          "nickname"] +
                                                              "：",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  skinColor),
                                                              fontSize: 13),
                                                          children: <
                                                              TextSpan>[
                                                            TextSpan(
                                                                text: item[
                                                                "comment"],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                    12)),
                                                          ])));
                                            }).toList(),
                                          ),
                                          list[index]["comment_num"] > 3
                                              ? Text("查看全部评论",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                  Color(0xff7b7b7b)))
                                              : Container()
                                        ],
                                      ),
                                    ),
                                    onTap: () =>
                                        toPage("dynamicDetail", list[index]))
                                    : Container()
                              ]));
                    })
            ),
          )),
      Positioned(
          bottom: 50,
          right: 20,
          child: SlideTransition(
              position: animation,
              child: InkWell(
                  borderRadius: new BorderRadius.all(
                      new Radius.circular(70.0)), // 点击水波纹是圆角的，默认是矩形的
                  child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(skinColor),
                          borderRadius: BorderRadius.circular(70),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              // 阴影颜色
                              offset: Offset(10, 20),
                              // 阴影与容器的距离 x,y
                              blurRadius: 40.0,
                              // 高斯模糊值。
                              spreadRadius: 2.0, // 阴影范围量
                            ),
                          ]),
                      child: Align(
                          child: Icon(
                              IconData(0xe609, fontFamily: 'sunfont'),
                              size: 34,
                              color: Colors.white))),
                  onTap: () => toPage("pubTrends", null))))
    ]);
  }
}
