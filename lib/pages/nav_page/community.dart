import 'dart:async';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunset/components/refresh/refresh_footer_ex.dart';
import 'package:sunset/components/refresh/refresh_header_ex.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/pages/nav_page/commun_view/new_trends.dart';
import 'package:sunset/pages/nav_page/commun_view/star_trends.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/api/trends_req.dart';
import 'package:sunset/utils/request.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  // 动画执行参数
  late final AnimationController controller =
      AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  late Animation<Offset> animation =
      Tween(begin: Offset.zero, end: Offset(1.5, 0.0)).animate(controller);

  List tabBar = ["最新", "精选", "关注"];
  List<dynamic> list = [];
  int total = 0; // 动态总数
  Map<String, dynamic> pageMap = {"page_num": 1, "page_rows": 6};
  int activeBar = 0;
  double tranBar = 75; // 初始值为头像宽度+右边距

  // late Animation<Offset> offsetAnimation;
  TrendsReq trendsReq = new TrendsReq();
  bool isLoading = false;

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
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    return Scaffold(
      body: Column(
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
                            child: Image.network("${baseUrl}${uinfo["avator"]}",
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stackTrace) =>
                                    Image.asset('assets/images/sunset.png',
                                        width: double.infinity)),
                          ),
                          onTap: () => toPage("userInfo", uinfo),
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
                                        ));
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
                    // SlideTransition(
                    //     position: offsetAnimation,
                    //     child: Container(
                    //       width: 28,
                    //       height: 6,
                    //       // margin: EdgeInsets.only(top: 4),
                    //       decoration: BoxDecoration(
                    //           color: Color(0xff22d47e),
                    //           borderRadius: BorderRadius.circular(4)),
                    //     ))
                  ],
                )),
          ]),
          Expanded(
             child: PageView(
                children: [
                  NewTrends(),
                  StarTrends()
                ],
              ))
        ],
      ),

    );
  }
}
