import 'dart:async';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/trends_req.dart';
import 'package:sunset/utils/request.dart';

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
  String u_id = "";

  void initState() {
    super.initState();
    getUid();
  }

  // 从缓存中获取 uid
  Future<void> getUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final action = prefs.getString('uid');
    u_id = action != null ? action : "";
    setState(() {});
    pageMap["uid"] = arguments["uid"];
    getFollow();
    getList();
  }

  List list = [];
  int total = 0; // 动态总数
  Map<String, dynamic> pageMap = {"page_num": 1, "page_rows": 6};
  Map uinfo = {
    "nickname": "",
    "avator": "",
    "description": "",
    "constellation": "",
    "following": "0",
    "followers": "0",
    "star": "0"
  };

  // 动态列表
  Future<void> getList() async {
    try {
      Map res = await trendsReq.getTrends(pageMap);
      print("动态列表【用户】>>${res["data"]}");
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

  // 粉丝，关注，获赞
  Future<void> getFollow() async {
    try {
      Map res = await trendsReq.getFollow({"uid": arguments["uid"]});
      print("粉丝，关注，获赞>>${res}");
      if (res["code"] == 200) {
        uinfo = res["data"];
        setState(() {});
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  @override
  void toPage(String path, dynamic arg) {
    Map<String, dynamic> arguments = new Map();
    if (path == "dynamicDetail") {
      arguments["uid"] = arg["uid"];
      arguments["trends_id"] = arg["id"];
    }
    Navigator.pushNamed(context, path, arguments: arguments);
  }

  // 编辑资料
  @override
  void toEditUinfo() {
    Navigator.pushNamed(context, "myInfo");
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width; // 屏幕宽度
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: ListView(
            physics: BouncingScrollPhysics(),
            // ClampingScrollPhysics 安卓滑动效果 BouncingScrollPhysics IOS滑动效果
            children: [
              Container(
                child: ClipRect(
                  child: Stack(children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: Image.network("${baseUrl}${uinfo["avator"]}",
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stackTrace) => Image.asset(
                              'assets/images/sunset.png',
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
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  width: mWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(36),
                                              child: Image.network(
                                                  "${baseUrl}${uinfo["avator"]}",
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
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 3,
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                      color: Color(0x68eaeaee),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          IconData(
                                                              uinfo["sex"] == 1
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
                                                        uinfo["constellation"],
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Column(children: [
                                              Text(
                                                  uinfo["following"].toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              SizedBox(height: 5),
                                              Text(
                                                "关注",
                                                style: TextStyle(
                                                    color: Color(0xfff3f3f3),
                                                    fontSize: 14),
                                              )
                                            ]),
                                            SizedBox(width: 40),
                                            Column(children: [
                                              Text(
                                                  uinfo["followers"].toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              SizedBox(height: 5),
                                              Text(
                                                "粉丝",
                                                style: TextStyle(
                                                    color: Color(0xfff3f3f3),
                                                    fontSize: 14),
                                              )
                                            ]),
                                            SizedBox(width: 40),
                                            Column(children: [
                                              Text(uinfo["star"].toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              SizedBox(height: 5),
                                              Text(
                                                "获赞",
                                                style: TextStyle(
                                                    color: Color(0xfff3f3f3),
                                                    fontSize: 14),
                                              )
                                            ])
                                          ]),
                                          u_id == ""
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      right: 30),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 16),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.white)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                          IconData(0xeaf3,
                                                              fontFamily:
                                                                  'sunfont'),
                                                          size: 10,
                                                          color: Color(
                                                              0xffffffff)),
                                                      Text("关注",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xffffffff)))
                                                    ],
                                                  ),
                                                )
                                              : InkWell(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 12),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.white)),
                                                    child: Text("编辑资料",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13)),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Text("Ta的动态",
                            style: TextStyle(
                                color: Color(0xff22d47e),
                                fontSize: 16,
                                fontWeight: FontWeight.w600))),
                    SizedBox(height: 15),
                    ListView.builder(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Container(
                                          width: 38,
                                          height: 38,
                                          margin: EdgeInsets.only(right: 8),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(38),
                                              child: Image.network(
                                                  "${baseUrl}${uinfo["avator"]}",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (ctx, err,
                                                      stackTrace) =>
                                                      Image.asset(
                                                          'assets/images/sunset.png',
                                                          //默认显示图片
                                                          height: 65,
                                                          width: 65)
                                              ))),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(uinfo["nickname"],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800)),
                                          SizedBox(height: 2),
                                          Text(
                                              formatDate(
                                                  DateTime.parse(list[index]
                                                      ["create_time"]),
                                                  [yyyy, '.', mm, '.', dd]),
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xffc1c1c1)))
                                        ],
                                      ),
                                      Spacer(flex: 1),
                                      Container(
                                        width: 60,
                                        height: 26,
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
                                                IconData(0xeaf3,
                                                    fontFamily: 'sunfont'),
                                                size: 10,
                                                color: Color(0xff22d47e)),
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
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 15),
                                        width: double.infinity,
                                        child: Text(list[index]["text"],
                                            style: TextStyle(
                                                fontSize: 14, height: 1.7)),
                                      ),
                                      onTap: () =>
                                          toPage("dynamicDetail", list[index]),
                                    ),
                                    Container(
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                list[index]["images"].length,
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
                                              childAspectRatio: 1, // item的宽高比
                                            ),
                                            itemBuilder: (context, idx) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xffe3e3e3),
                                                    borderRadius: BorderRadius.circular(8)
                                                ),
                                                child:ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
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
                                                ) ,
                                              );
                                            })),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 12, bottom: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Color(0xfff3f3f3),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Text("#运动就是坚持#",
                                            style: TextStyle(
                                                color: Color(0xff22d47e),
                                                fontSize: 12))),
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
                                                size: 18,
                                                color: Color(0xffbbbbbb)),
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
                                        Row(
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
                                            Text(list[index]["comment_num"].toString(),
                                                style: TextStyle(
                                                    color: Color(0xffbbbbbb),
                                                    height: 1.4,
                                                    fontSize: 14))
                                          ],
                                        ),
                                        Icon(
                                            IconData(0xe617,
                                                fontFamily: 'sunfont'),
                                            size: 18,
                                            color: Color(0xffbbbbbb)),
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
                                                          margin: EdgeInsets
                                                              .only(bottom: 6),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  text: item[
                                                                          "nickname"] +
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
                                                              color: Color(
                                                                  0xff7b7b7b)))
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                            onTap: () => toPage(
                                                "dynamicDetail", list[index]))
                                        : Container()
                                  ]));
                        })
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
