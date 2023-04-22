import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/pages/nav_page/commun_view/follower_trends.dart';
import 'package:sunset/pages/nav_page/commun_view/new_trends.dart';
import 'package:sunset/pages/nav_page/commun_view/star_trends.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/request.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 缓存页面，保持状态，混入 AutomaticKeepAliveClientMixin

  List tabBar = ["最新", "精选", "关注"];

  @override
  void initState() {
    super.initState();
    getUInfo();
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

  List<Widget> pageList = [NewTrends(), StarTrends(), FollowerTrends()];

  @override
  void dispose() {
    super.dispose();
  }

  PageController pageController =
      new PageController(initialPage: 0, keepPage: true);

  late AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late Animation<Offset> lineSlide =
      Tween(begin: Offset(0.2, 0), end: Offset(0, 0)).animate(_controller);

  GlobalKey TopPageKey = GlobalKey();
  int activeBar = 0;

  double s_offset = 0.2;
  double e_offset = 0.2;
  int line_width = 28;
  // 改变 page 【核心动画过渡】
  void pageChange(i) {
    double? current = TopPageKey.currentContext?.size?.width;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    if (i == 0) {
      lineSlide = Tween(begin: Offset(s_offset, 0), end: Offset(e_offset, 0))
          .animate(_controller);
      s_offset = 0.2;
    }
    if (i == 1) {
      double end = ((current! / 2) - (line_width/2)) / line_width;
      lineSlide = Tween(begin: Offset(s_offset, 0), end: Offset(end, 0))
          .animate(_controller);
      s_offset = end;
    }
    if (i == 2) {
      double end = (current! - 34) / line_width;
      lineSlide = Tween(begin: Offset(s_offset, 0), end: Offset(end, 0))
          .animate(_controller);
      s_offset = end;
    }
    _controller.forward();
    activeBar = i;
    setState(() {});
  }

  void pageChanges(index) {
    pageController.animateToPage(
      index,
      curve: Curves.ease,
      duration: Duration(milliseconds: 200),
    );
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
                                key: TopPageKey,
                                child: Stack(
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children:
                                            tabBar.asMap().entries.map((entry) {
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
                                                    key: ValueKey(index),
                                                    style: TextStyle(
                                                        color: Color(
                                                            activeBar == index
                                                                ? 0xff000000
                                                                : 0xffc2c2c2),
                                                        fontSize:
                                                            activeBar == index
                                                                ? 20
                                                                : 16,
                                                        fontWeight:
                                                            FontWeight.w800))),
                                            onTap: () => pageChanges(index),
                                          ));
                                        }).toList()),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: SlideTransition(
                                            position: lineSlide,
                                            child: Container(
                                              width: 28,
                                              height: 6,
                                              // margin: EdgeInsets.only(top: 4),
                                              decoration: BoxDecoration(
                                                  color: Color(0xff22d47e),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                            )))
                                  ],
                                ))),
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
                  ],
                )),
          ]),
          Expanded(
              child: PageView.builder(
                  itemCount: pageList.length,
                  controller: pageController,
                  itemBuilder: (ctx, index) {
                    return pageList[index];
                  },
                  onPageChanged: (int i) => pageChange(i)))
        ],
      ),
    );
  }
}
