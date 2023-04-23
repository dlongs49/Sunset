import 'dart:async';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:sunset/components/refresh/refresh_footer_ex.dart';
import 'package:sunset/components/refresh/refresh_header_ex.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/trends_req.dart';
import 'package:sunset/utils/request.dart';
import 'package:sunset/utils/tools.dart';

class UserInfo extends StatefulWidget {
  final arguments; // 路由带的参数
  const UserInfo({Key? key, this.arguments}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState(arguments: this.arguments);
}

class _UserInfoState extends State<UserInfo> {
  /* 拿到路由传的值 */
  final arguments;

  _UserInfoState({this.arguments});

  TrendsReq trendsReq = new TrendsReq();
  bool isUser = false;

  void initState() {
    super.initState();
    getUid();
  }

  // 从缓存中获取 uid
  Future<void> getUid() async {
    String u_id = await getStorage("uid");
    isUser = u_id == arguments["uid"];
    print("当前账号值：${u_id} -- ${arguments["uid"]}");
    setState(() {});
    pageMap["uid"] = arguments["uid"];
    getFollow();
    getList();
  }

  List list = [];
  int total = 0; // 动态总数
  Map<String, dynamic> pageMap = {"page_num": 1, "page_rows": 6, "type": 0};
  Map uinfo = {
    "nickname": "",
    "avator": "",
    "description": "",
    "constellation": "",
    "following": 0,
    "followers": 0,
    "star": 0,
    "isfollow": false
  };

  // 动态列表
  Future<IndicatorResult> getList() async {
    try {
      Map res = await trendsReq.getTrends(pageMap);
      if (res["code"] == 200) {
        list.insertAll(list.length, res["data"]["list"]);
        total = res["data"]["total"];
        if (mounted) {
          setState(() {});
        }
        return IndicatorResult.success;
      } else {
        return IndicatorResult.fail;
      }
    } catch (e) {
      print(e);
      errToast();
      return IndicatorResult.fail;
    }
  }

  // 粉丝，关注，获赞
  Future<void> getFollow() async {
    try {
      Map res = await trendsReq.getFollow({"uid": arguments["uid"]});
      if (res["code"] == 200) {
        uinfo = res["data"];
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  // 加载 刷新控制器
  EasyRefreshController _controller = new EasyRefreshController(
  );
  // 上拉加载
  Future<IndicatorResult> onLoad() async {
    pageMap["page_num"]++;
    if (list.length >= total) {
      return IndicatorResult.noMore;
    } else {
      IndicatorResult status = await getList();
      return status;
    }
  }

  // 下拉刷新
  Future<IndicatorResult> onRefresh() async {
    list = [];
    pageMap["page_num"] = 1;
    await getFollow();
    IndicatorResult status = await getList();
    return status;
  }

  // 关注 & 取消关注
  void handleFollow(params) async {
    if (!isUser) {
      showIsLogDialog(context);
      return;
    }
    try {
      Map res = await trendsReq.setFollow({"uid": params["uid"]});
      if (res["code"] == 200) {
        print("关注 & 取消关注>>${params["uid"]}--${res}");
        // 成功 假状态修改保持交互
        uinfo["isfollow"] = !uinfo["isfollow"];
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  // 动态点赞
  void handleStar(params, index) async {
    if (!isUser) {
      showIsLogDialog(context);
      return;
    }
    try {
      Map res = await trendsReq.setTrendsStar({"trends_id": params["id"]});
      if (res["code"] == 200) {
        print("动态点赞$res");
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

  void toPage(String path, dynamic arg) {
    Map<String, dynamic> arguments = new Map();
    if (path == "dynamicDetail") {
      arguments["uid"] = arg["uid"];
      arguments["trends_id"] = arg["id"];
    }
    Navigator.pushNamed(context, path, arguments: arguments);
  }

  Map<dynamic, dynamic> delMap = {};

  // 删除动态二次确认
  void delTrends() async {
    print(delMap["item"]["id"]);
    if (delMap["item"]["id"] == null) {
      Navigator.of(context).pop();
      return;
    }
    int index = delMap["index"];
    try {
      Map res = await trendsReq.delTrends({"id": delMap["item"]["id"]});
      if (res["code"] == 200) {
        // 删除成功 加状态更新列表
        list.removeAt(index);
        Navigator.of(context).pop();
        if (mounted) {
          setState(() {});
        }
      } else {
        Navigator.of(context).pop();
        toast(res["message"]);
      }
    } catch (e) {
      print(e);
      Navigator.of(context).pop();
      errToast();
    }
  }

  // 删除动态弹框
  void showModal(BuildContext context) {
    if (!isUser) {
      showIsLogDialog(context);
      return;
    }
    showModalBottomSheet(
        context: context,
        isScrollControlled: false, // 是否滚动
        backgroundColor: Colors.transparent, // 透明是为了自定义样式，例如圆角等
        builder: (context) {
          return CustomBottomSheet(context);
        });
  }

  // 重写 showModalBottomSheet 布局样式
  Widget CustomBottomSheet(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment(0, 0),
                  height: 130 / 2 - 4,
                  child: InkWell(
                      child: Text("删除动态",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xffef1a1e)))),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('确认删除'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('确认'),
                            onPressed: () => delTrends(),
                          ),
                          CupertinoDialogAction(
                            child: Text('取消'),
                            isDestructiveAction: true,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }),
            InkWell(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment(0, 0),
                  height: 55,
                  child: Text(
                    "取消",
                    style: TextStyle(fontSize: 18, color: Color(0xffcccccc)),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                }),
          ],
        ));
  }

  // 编辑资料
  @override
  void toEditUinfo() {
    Navigator.pushNamed(context, "myInfo");
  }

  // 去关注列表页面
  void toFollow() {
    if (!isUser) return;
    Navigator.pushNamed(context, "myFollow");
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: EasyRefresh(
                header: RefreshHeaderEx(),
                footer: RefreshFooterEx(),
                onRefresh: onRefresh,
                onLoad: onLoad,
                controller: _controller,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      child: ClipRect(
                        child: Stack(children: [
                          Container(
                            width: double.infinity,
                            height: 300,
                            child: Image.network("${baseUrl}${uinfo["avator"]}",
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stackTrace) =>
                                    Image.asset('assets/images/sunset.png',
                                        width: double.infinity)),
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 20,
                              sigmaY: 20,
                            ),
                            child: Container(
                              color: Color(0x2C000000),
                              width: double.infinity,
                              height: 300,
                              child: Stack(
                                children: [
                                  Positioned(
                                      bottom: 20,
                                      left: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        width: mWidth,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            36),
                                                    child: Image.network(
                                                        "${baseUrl}${uinfo["avator"]}",
                                                        fit: BoxFit.cover,
                                                        width: 65,
                                                        height: 65,
                                                        errorBuilder: (ctx, err,
                                                                stackTrace) =>
                                                            Image.asset(
                                                                'assets/images/sunset.png',
                                                                //默认显示图片
                                                                height: 65,
                                                                width: 65))),
                                                SizedBox(width: 15),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(uinfo["nickname"],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22)),
                                                    SizedBox(height: 10),
                                                    Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3,
                                                                horizontal: 8),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0x68eaeaee),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                                IconData(
                                                                    uinfo["sex"] ==
                                                                            1
                                                                        ? 0xe612
                                                                        : 0xe632,
                                                                    fontFamily:
                                                                        "sunfont"),
                                                                size: 14,
                                                                color: Color(uinfo[
                                                                            "sex"] ==
                                                                        1
                                                                    ? 0xff51aefe
                                                                    : 0xfffb859d)),
                                                            SizedBox(width: 6),
                                                            Text(
                                                              uinfo[
                                                                  "constellation"],
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ],
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                                uinfo["description"] != null
                                                    ? uinfo["description"]
                                                    : "",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white)),
                                            SizedBox(height: 25),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(children: [
                                                  InkWell(
                                                    child: Column(children: [
                                                      Text(
                                                          uinfo["following"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "关注",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xfff3f3f3),
                                                            fontSize: 14),
                                                      )
                                                    ]),
                                                    onTap: toFollow,
                                                  ),
                                                  SizedBox(width: 40),
                                                  Column(children: [
                                                    Text(
                                                        uinfo["followers"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "粉丝",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xfff3f3f3),
                                                          fontSize: 14),
                                                    )
                                                  ]),
                                                  SizedBox(width: 40),
                                                  Column(children: [
                                                    Text(
                                                        uinfo["star"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "获赞",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xfff3f3f3),
                                                          fontSize: 14),
                                                    )
                                                  ])
                                                ]),
                                                !isUser
                                                    ? InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        highlightColor:
                                                            Color(0xfff2f2f2),
                                                        splashColor:
                                                            Color(0xffe2e2e2),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 30),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 2,
                                                                  horizontal:
                                                                      16),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Color(!uinfo[
                                                                          "isfollow"]
                                                                      ? 0xffffffff
                                                                      : 0xffb1b1b1))),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              !uinfo["isfollow"]
                                                                  ? Icon(
                                                                      IconData(
                                                                          0xeaf3,
                                                                          fontFamily:
                                                                              'sunfont'),
                                                                      size: 10,
                                                                      color: Color(
                                                                          0xffcccccc))
                                                                  : Container(),
                                                              Text(
                                                                  !uinfo["isfollow"]
                                                                      ? "关注"
                                                                      : "已关注",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(!uinfo[
                                                                              "isfollow"]
                                                                          ? 0xffcccccc
                                                                          : 0xffb1b1b1)))
                                                            ],
                                                          ),
                                                        ),
                                                        onTap: () =>
                                                            handleFollow(uinfo),
                                                      )
                                                    : InkWell(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      12),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .white)),
                                                          child: Text("编辑资料",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      13)),
                                                        ),
                                                        onTap: toEditUinfo)
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Text("Ta的动态",
                                  style: TextStyle(
                                      color: Color(0xff22d47e),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))),
                          SizedBox(height: 15),
                          list.length != 0
                              ? ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              //解决无限高度问题
                              physics: new NeverScrollableScrollPhysics(),
                              //禁用滑动事件
                              itemCount: list.length,
                              itemBuilder: (ctx, index) {
                                return Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    margin: EdgeInsets.only(bottom: 35),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Container(
                                                width: 38,
                                                height: 38,
                                                margin:
                                                    EdgeInsets.only(right: 8),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            38),
                                                    child: Image.network(
                                                        "${baseUrl}${uinfo["avator"]}",
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (ctx, err,
                                                                stackTrace) =>
                                                            Image.asset(
                                                                'assets/images/sunset.png',
                                                                //默认显示图片
                                                                height: 65,
                                                                width: 65)))),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(uinfo["nickname"],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                                SizedBox(height: 2),
                                                Text(
                                                    formatDate(
                                                        DateTime.parse(list[
                                                                index]
                                                            ["create_time"]),
                                                        [
                                                          yyyy,
                                                          '.',
                                                          mm,
                                                          '.',
                                                          dd
                                                        ]),
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color:
                                                            Color(0xffc1c1c1)))
                                              ],
                                            ),
                                          ]),
                                          InkWell(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 15),
                                              width: double.infinity,
                                              child: Text(list[index]["text"],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      height: 1.7)),
                                            ),
                                            onTap: () => toPage(
                                                "dynamicDetail", list[index]),
                                          ),
                                          list[index]["images"] != null &&
                                                  list[index]["images"]
                                                          .length !=
                                                      0
                                              ? Container(
                                                  child: GridView.builder(
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      itemCount: list[index]
                                                              ["images"]
                                                          .length,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      // 禁止滑动
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        // 主轴一行的数量
                                                        mainAxisSpacing: 6,
                                                        // 主轴每行间距
                                                        crossAxisSpacing: 6,
                                                        // 交叉轴每行间距
                                                        childAspectRatio:
                                                            1, // item的宽高比
                                                      ),
                                                      itemBuilder:
                                                          (context, idx) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffe3e3e3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            child: Image.network(
                                                                "${baseUrl}${list[index]["images"][idx]}",
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder: (ctx,
                                                                        err,
                                                                        stackTrace) =>
                                                                    Image.asset(
                                                                        'assets/images/lazy.png',
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        width: double
                                                                            .infinity)),
                                                          ),
                                                        );
                                                      }))
                                              : Container(),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 12, bottom: 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Color(0xfff3f3f3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Text("#运动就是坚持#",
                                                  style: TextStyle(
                                                      color: Color(0xff22d47e),
                                                      fontSize: 12))),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                          IconData(
                                                              list[index]
                                                                      ["isstar"]
                                                                  ? 0xec8c
                                                                  : 0xec7f,
                                                              fontFamily:
                                                                  'sunfont'),
                                                          size: 18,
                                                          color: Color(list[
                                                                      index]
                                                                  ["isstar"]
                                                              ? 0xff22d47e
                                                              : 0xffbbbbbb)),
                                                      SizedBox(width: 6),
                                                      Text("赞",
                                                          style: TextStyle(
                                                              color: Color(list[
                                                                          index]
                                                                      ["isstar"]
                                                                  ? 0xff22d47e
                                                                  : 0xffbbbbbb),
                                                              height: 1.5,
                                                              fontSize: 14)),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          constraints:
                                                              BoxConstraints(
                                                                  minWidth: 30),
                                                          child: Text(
                                                              list[index]["star"] !=
                                                                      0
                                                                  ? list[index]
                                                                          [
                                                                          "star"]
                                                                      .toString()
                                                                  : "",
                                                              style: TextStyle(
                                                                  color: Color(list[index]
                                                                          ["isstar"]
                                                                      ? 0xff22d47e
                                                                      : 0xffbbbbbb),
                                                                  height: 1.7,
                                                                  fontSize: 14)))
                                                    ],
                                                  ),
                                                ),
                                                onTap: () => handleStar(
                                                    list[index], index),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                      IconData(0xe600,
                                                          fontFamily:
                                                              'sunfont'),
                                                      size: 20,
                                                      color: Color(0xffbbbbbb)),
                                                  SizedBox(width: 6),
                                                  Text("评论",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffbbbbbb),
                                                          height: 1.4,
                                                          fontSize: 14)),
                                                  SizedBox(width: 4),
                                                  Text(
                                                      list[index]["comment_num"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffbbbbbb),
                                                          height: 1.4,
                                                          fontSize: 14))
                                                ],
                                              ),
                                              isUser
                                                  ? InkWell(
                                                      child: Icon(
                                                          IconData(0xe617,
                                                              fontFamily:
                                                                  'sunfont'),
                                                          size: 18,
                                                          color: Color(
                                                              0xffbbbbbb)),
                                                      onTap: () {
                                                        delMap["item"] =
                                                            list[index];
                                                        delMap["index"] = index;
                                                        showModal(context);
                                                      },
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                          list[index]["comment_num"] != 0
                                              ? InkWell(
                                                  child: Container(
                                                    width: double.infinity,
                                                    margin: EdgeInsets.only(
                                                        top: 14),
                                                    constraints: BoxConstraints(
                                                        minHeight: 50),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff3f3f3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          children: list[index][
                                                                  "comment_list"]
                                                              .asMap()
                                                              .entries
                                                              .map<Widget>(
                                                                  (entry) {
                                                            final item =
                                                                entry.value;
                                                            return Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            6),
                                                                child: RichText(
                                                                    text: TextSpan(
                                                                        text: item["nickname"] +
                                                                            "：",
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xff22d47e),
                                                                            fontSize:
                                                                                13),
                                                                        children: <
                                                                            TextSpan>[
                                                                      TextSpan(
                                                                          text: item[
                                                                              "comment"],
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 12)),
                                                                    ])));
                                                          }).toList(),
                                                        ),
                                                        list[index]["comment_num"] >
                                                                3
                                                            ? Text("查看全部评论",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0xff7b7b7b)))
                                                            : Container()
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () => toPage(
                                                      "dynamicDetail",
                                                      list[index]))
                                              : Container()
                                        ]));
                              }) : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/none.png"),
                              Text(
                                "暂无动态",
                                style: TextStyle(color: Color(0xffcccccc)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
