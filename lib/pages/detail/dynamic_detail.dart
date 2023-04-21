import 'dart:async';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sunset/components/loading.dart';
import 'package:sunset/components/no_more.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/api/trends_req.dart';
import 'package:sunset/utils/request.dart';

class DynamicDetail extends StatefulWidget {
  final arguments; // 路由带的参数
  const DynamicDetail({Key? key, this.arguments}) : super(key: key);

  @override
  State<DynamicDetail> createState() =>
      _DynamicDetailState(arguments: this.arguments);
}

class _DynamicDetailState extends State<DynamicDetail> {
  TextEditingController ContentController = TextEditingController();

  /* 拿到路由传的值 */
  final arguments;

  _DynamicDetailState({this.arguments});

  TrendsReq trendsReq = new TrendsReq();
  @override
  void initState() {
    super.initState();
    commParams["trends_id"] = pageMap["trends_id"] = arguments["trends_id"];
    getUInfo();
    getDetail();
    getCommnet();
  }

  Sign sign = new Sign();
  Map uinfo = new Map();

  // 个人信息
  void getUInfo() async {
    try {
      Map res = await sign.getUInfo();
      if (res["code"] == 200) {
        uinfo = res["data"];
        uinfo["avator"] = baseUrl + res["data"]["avator"];
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  Map detail = {
    "text": "",
    "avator": "",
    "nickname": "",
    "create_time": "",
    "isfollow": false,
    "images": []
  };

  // 动态详情
  Future<void> getDetail() async {
    try {
      Map res = await trendsReq
          .getTrendsDetail({"trends_id": arguments["trends_id"]});
      if (res["code"] == 200) {
        detail = res["data"];
        detail["avator"] = baseUrl + res["data"]["avator"];
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  // 关注 & 取消关注
  @override
  void handleFollow(String uid) async {
    if(uinfo["uid"] == null){
      showIsLogDialog(context);
      return;
    }
    try {
      Map res = await trendsReq.setFollow({"uid": uid});
      if (res["code"] == 200) {
        print("关注 & 取消关注>>${uid}--${res}");
        // 成功 假状态修改保持交互
        detail["isfollow"] = !detail["isfollow"];
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  // 监听输入的文本
  @override
  void textChanged(String value) {
    if (value.length >= 50) {
      toast("最多输入50个字符评语~");
      return;
    }
    commParams["content"] = value;
    print("输入的评论值>>>${value.length}-${value}");
  }

  Map<String, dynamic> commParams = {};

  // 发送评论
  @override
  Future<void> pubComment() async {
    if(uinfo["uid"] == null){
      showIsLogDialog(context);
      return;
    }
    if (commParams["content"].length <= 0) {
      toast("请输入友善的评语");
      return;
    }
    if (commParams["trends_id"] == null) {
      return;
    }
    try {
      Map res = await trendsReq.pubComment(commParams);
      if (res["code"] == 200) {
        commentList.insert(0, {
          "avator": uinfo["avator"],
          "nickname": uinfo["nickname"],
          "content": commParams["content"],
          "create_time": new DateTime.now().toString(),
          "star": 0,
          "isstar": false
        });
        // 重置输入框
        ContentController = TextEditingController.fromValue(TextEditingValue(
            text: "",
            selection: TextSelection.fromPosition(
                TextPosition(affinity: TextAffinity.downstream, offset: 0))));
        commParams["content"] = "";
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {});
      } else {
        toast("评论失败");
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }
  List commentList = [];
  int commentTotal = 0;
  Map<String, dynamic> pageMap = {"page_num": 1, "page_rows": 10};

  bool isPoint = false;

  // 监听滑动结束 分页加载
  bool scrollEnd(ScrollNotification n) {
    print("${commentList.length}---${commentTotal}");
    if (commentList.length >= commentTotal) {
      return true;
    } else {
      // isPoint 解决多次触发置底操作，导致上一次请求未完成，多次请求bug
      if (isPoint) {
        isPoint = false;
        print(pageMap);
        pageMap["page_num"] = pageMap["page_num"] + 1;
        var timeout = Duration(seconds: 1);
        Timer(timeout, () {
          getCommnet();
        });
      }
    }
    return false;
  }

  // 评论列表
  @override
  Future<void> getCommnet() async {
    try {
      Map res = await trendsReq.getComment(pageMap);
      if (res["code"] == 200) {
        commentList.insertAll(commentList.length, res["data"]["list"]);
        commentTotal = res["data"]["total"];
        isPoint = true;
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      errToast();
    }
  }

  // 评论点赞
  @override
  Future<void> handleCommStar(params, index) async {
    if(uinfo["uid"] == null){
      showIsLogDialog(context);
      return;
    }
    try {
      Map res = await trendsReq.setCommentStar(
          {"comment_id": params["id"], "trends_id": detail["id"]});
      if (res["code"] == 200) {
        print(">>>>>$res");
        // 成功 加状态修改
        commentList[index]["isstar"] = !commentList[index]["isstar"];
        int star = commentList[index]["star"];
        if (commentList[index]["isstar"]) {
          commentList[index]["star"] = star + 1;
        } else {
          commentList[index]["star"] = star - 1;
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

  @override
  void toPage(String path, dynamic arg) {
    Map<String, dynamic> arguments = new Map();
    if (path == "userInfo") {
      arguments["uid"] = arg["uid"];
    }
    Navigator.pushNamed(context, path, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomTabBar(title: "动态详情", bgColor: null, fontColor: null),
            Expanded(
              child: NotificationListener<ScrollEndNotification>(
                  onNotification: (notification) => scrollEnd(notification),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(), // IOS的回弹属性
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
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
                                            "${detail["avator"]}",
                                            fit: BoxFit.cover,
                                            errorBuilder: (ctx, err,
                                                    stackTrace) =>
                                                Image.asset(
                                                    'assets/images/sunset.png',
                                                    //默认显示图片
                                                    height: 38,
                                                    width: double.infinity)))),
                                onTap: () =>
                                    toPage("userInfo", {"uid": detail["uid"]}),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(detail["nickname"],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800)),
                                  SizedBox(height: 2),
                                  Text(detail["create_time"],
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xffc1c1c1)))
                                ],
                              ),
                              Spacer(flex: 1),
                              detail["uid"] != uinfo["uid"]
                                  ? InkWell(
                                      borderRadius: BorderRadius.circular(22),
                                      highlightColor: Color(0xfff2f2f2),
                                      splashColor: Color(0xffe2e2e2),
                                      child: Container(
                                        width: 60,
                                        height: 26,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.0,
                                                color: Color(!detail["isfollow"]
                                                    ? 0xff22d47e
                                                    : 0xffdddddd)),
                                            borderRadius:
                                                BorderRadius.circular(22)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            !detail["isfollow"]
                                                ? Icon(
                                                    IconData(0xeaf3,
                                                        fontFamily: 'sunfont'),
                                                    size: 10,
                                                    color: Color(0xff22d47e))
                                                : Container(),
                                            Text(
                                                !detail["isfollow"]
                                                    ? "关注"
                                                    : "已关注",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(
                                                        !detail["isfollow"]
                                                            ? 0xff22d47e
                                                            : 0xffdddddd)))
                                          ],
                                        ),
                                      ),
                                      onTap: () => handleFollow(detail["uid"]))
                                  : Container()
                            ]),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(detail["text"],
                                  style: TextStyle(fontSize: 14, height: 1.7)),
                            ),
                            detail["images"] != null &&
                                    detail["images"].length != 0
                                ? Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: GridView.builder(
                                      padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: detail["images"].length,
                                        physics: NeverScrollableScrollPhysics(),
                                        // 禁止滑动
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3, // 主轴一行的数量
                                          mainAxisSpacing: 6, // 主轴每行间距
                                          crossAxisSpacing: 6, // 交叉轴每行间距
                                          childAspectRatio: 1, // item的宽高比
                                        ),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xffe3e3e3),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                  "${baseUrl}${detail["images"][index]}",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (ctx, err,
                                                          stackTrace) =>
                                                      Image.asset(
                                                          'assets/images/lazy.png',
                                                          fit: BoxFit.fill,
                                                          width:
                                                              double.infinity)),
                                            ),
                                          );
                                        }))
                                : Container(),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 12, bottom: 12),
                          child: Text("全部评论(${commentList.length})",
                              style: TextStyle(fontSize: 14))),
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          //解决无限高度问题
                          physics: new NeverScrollableScrollPhysics(),
                          //禁用滑动事件
                          itemCount: commentList.length,
                          itemBuilder: (ctx, index) =>
                              /* 如果列表长度 不等于 当前的索引值即没有到底部 则展示列表，
                            否 在进行二次三元判断，判断列表的长度 是否大于等于总条数，在进行是否 加载中还是到底部
                          */
                              index + 1 != commentList.length
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 14),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFF1F1F1)))),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            child: Container(
                                                width: 32,
                                                height: 32,
                                                margin:
                                                    EdgeInsets.only(right: 8),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32),
                                                    child: Image.network(
                                                        "${baseUrl}${commentList[index]["avator"]}",
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (ctx, err,
                                                                stackTrace) =>
                                                            Image.asset(
                                                                'assets/images/sunset.png',
                                                                //默认显示图片
                                                                height: 38,
                                                                width: double
                                                                    .infinity)))),
                                            onTap: () => toPage(
                                                "userInfo", commentList[index]),
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 5, bottom: 6),
                                                  child: Text(
                                                      commentList[index][
                                                                  "nickname"] !=
                                                              null
                                                          ? commentList[index]
                                                              ["nickname"]
                                                          : "",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight
                                                              .w600))),
                                              Text(
                                                  commentList[index]
                                                              ["content"] !=
                                                          null
                                                      ? commentList[index]
                                                          ["content"]
                                                      : "",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      height: 1.5)),
                                              SizedBox(height: 10),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      formatDate(
                                                          DateTime.parse(
                                                              commentList[index]
                                                                  [
                                                                  "create_time"]),
                                                          [
                                                            yyyy,
                                                            '.',
                                                            mm,
                                                            '.',
                                                            dd
                                                          ]),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffcccccc),
                                                          fontSize: 13)),
                                                  Spacer(flex: 1),
                                                  InkWell(
                                                      highlightColor:
                                                          Colors.white,
                                                      splashColor:
                                                          Colors.white,
                                                      child: Container(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                width: 30,
                                                                child: Text(
                                                                    commentList[index]["star"] !=
                                                                            null
                                                                        ? commentList[index]["star"]
                                                                            .toString()
                                                                        : "0",
                                                                    style: TextStyle(
                                                                        color: Color(commentList[index]["isstar"]
                                                                            ? 0xff22d47e
                                                                            : 0xffbbbbbb),
                                                                        fontSize:
                                                                            14))),
                                                            SizedBox(width: 10),
                                                            Icon(
                                                                IconData(
                                                                    commentList[index]
                                                                            [
                                                                            "isstar"]
                                                                        ? 0xec8c
                                                                        : 0xec7f,
                                                                    fontFamily:
                                                                        'sunfont'),
                                                                size: 16,
                                                                color: Color(commentList[
                                                                            index]
                                                                        [
                                                                        "isstar"]
                                                                    ? 0xff22d47e
                                                                    : 0xffbbbbbb)),
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () =>
                                                          handleCommStar(
                                                              commentList[
                                                                  index],
                                                              index)),
                                                  SizedBox(width: 10),
                                                  Icon(
                                                      IconData(0xe600,
                                                          fontFamily:
                                                              'sunfont'),
                                                      size: 18,
                                                      color: Color(0xffbbbbbb))
                                                ],
                                              ),
                                              // Container(
                                              //     margin: EdgeInsets.only(top: 10),
                                              //     padding: EdgeInsets.only(top: 10),
                                              //     decoration: BoxDecoration(
                                              //         border: Border(
                                              //             top: BorderSide(
                                              //                 width: 1,
                                              //                 color:
                                              //                     Color(0xFFF1F1F1)))),
                                              //     child: Row(
                                              //         crossAxisAlignment:
                                              //             CrossAxisAlignment.start,
                                              //         children: [
                                              //           Container(
                                              //               width: 32,
                                              //               height: 32,
                                              //               margin: EdgeInsets.only(
                                              //                   right: 8),
                                              //               child: ClipRRect(
                                              //                   borderRadius:
                                              //                       BorderRadius
                                              //                           .circular(32),
                                              //                   child: Image.asset(
                                              //                       "assets/images/400x400.jpg",
                                              //                       fit:
                                              //                           BoxFit.cover))),
                                              //           Expanded(
                                              //               child: Column(
                                              //                   crossAxisAlignment:
                                              //                       CrossAxisAlignment
                                              //                           .start,
                                              //                   children: [
                                              //                 Container(
                                              //                     margin:
                                              //                         EdgeInsets.only(
                                              //                             top: 5,
                                              //                             bottom: 6),
                                              //                     child: Text("Sept",
                                              //                         style: TextStyle(
                                              //                             fontSize: 13,
                                              //                             fontWeight:
                                              //                                 FontWeight
                                              //                                     .w600))),
                                              //                 Text(
                                              //                     "浔阳江头夜送客，枫叶荻花秋瑟瑟。",
                                              //                     style: TextStyle(
                                              //                         fontSize: 13,
                                              //                         height: 1.5)),
                                              //                 SizedBox(height: 10),
                                              //                 Row(
                                              //                   crossAxisAlignment:
                                              //                       CrossAxisAlignment
                                              //                           .center,
                                              //                   children: [
                                              //                     Text("2023-03-17",
                                              //                         style: TextStyle(
                                              //                             color: Color(
                                              //                                 0xffcccccc),
                                              //                             fontSize:
                                              //                                 13)),
                                              //                     Spacer(flex: 1),
                                              //                     Text("0",
                                              //                         style: TextStyle(
                                              //                             color: Color(
                                              //                                 0xffbbbbbb),
                                              //                             fontSize:
                                              //                                 14)),
                                              //                     SizedBox(width: 10),
                                              //                     Icon(
                                              //                         IconData(0xec7f,
                                              //                             fontFamily:
                                              //                                 'sunfont'),
                                              //                         size: 16,
                                              //                         color: Color(
                                              //                             0xffbbbbbb)),
                                              //                     SizedBox(width: 10),
                                              //                     Icon(
                                              //                         IconData(0xe600,
                                              //                             fontFamily:
                                              //                                 'sunfont'),
                                              //                         size: 18,
                                              //                         color: Color(
                                              //                             0xffbbbbbb))
                                              //                   ],
                                              //                 ),
                                              //               ]))
                                              //         ]))
                                            ],
                                          ))
                                        ],
                                      ),
                                    )
                                  : commentList.length != commentTotal
                                      ? Loading()
                                      : NoMore())
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(5, 35), // 阴影与容器的距离
                    blurRadius: 50.0, // 偏差值。
                    spreadRadius: 0.0, // 膨胀量。
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Color(0xffeeeff3),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                        controller: ContentController,
                        cursorHeight: 16,
                        // 光标颜色
                        cursorColor: Color(0xff22d47e),
                        // 取消自动获取焦点
                        autofocus: false,
                        maxLines: 1,
                        style: TextStyle(fontSize: 13),
                        inputFormatters: [
                          //限制长度
                          LengthLimitingTextInputFormatter(50),
                        ],
                        decoration: InputDecoration(
                            isCollapsed: true,
                            //可以设置自己的
                            contentPadding: EdgeInsets.all(10),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            // 取消边框
                            hintText: '友善评论',
                            helperStyle: TextStyle(
                                color: Color(0xffd0d0d0), fontSize: 13)),
                        onChanged: textChanged),
                  )),
                  SizedBox(width: 10),
                  InkWell(
                    child: Container(
                        height: 34,
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 26),
                        decoration: BoxDecoration(
                          color: Color(0xff22d47e),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment(0, 0),
                        child: Text(
                          "发送",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                    onTap: pubComment,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
