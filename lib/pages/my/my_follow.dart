import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/trends_req.dart';
import 'package:sunset/utils/request.dart';

class MyFollow extends StatefulWidget {
  const MyFollow({Key? key}) : super(key: key);

  @override
  _MyFollowState createState() => _MyFollowState();
}

class _MyFollowState extends State<MyFollow> {
  TrendsReq trendsReq = new TrendsReq();
  Map<String, dynamic> pageMap = {"page_num": 1, "page_rows": 6};

  // 关注列表
  List list = [];

  // 关注总条数
  int total = 0;

  @override
  void initState() {
    super.initState();
    getFollowList();
  }

  // 关注列表
  void getFollowList() async {
    try {
      Map res = await trendsReq.getFollowList(pageMap);
      if (res["code"] == 200) {
        print(">>>>$res");
        var lists = res["data"]["list"].map((el) {
          el["isfollow"] = true;
          return el;
        });
        list.insertAll(list.length, lists);
        total = res["data"]["total"];
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
  void handleFollow(params, index) async {
    try {
      Map res = await trendsReq.setFollow({"uid": params["uid"]});
      if (res["code"] == 200) {
        print("关注 & 取消关注>>${params["uid"]}--${res}");
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
  // 去用户的个人中心
  void toUinfo(params){
    Navigator.pushNamed(context, "userInfo",arguments:{"uid":params["uid"]});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          CustomTabBar(title: "我的关注", bgColor: null, fontColor: null),
          Expanded(
            child: list.length != 0
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: list.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.5, color: Color(0xfff6f6f6)))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                      child: Container(
                                          width: 38,
                                          height: 38,
                                          margin: EdgeInsets.only(right: 8),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(38),
                                              child: Image.network(
                                                  baseUrl +
                                                      list[index]["avator"],
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (ctx, err,
                                                          stackTrace) =>
                                                      Image.asset(
                                                          'assets/images/sunset.png',
                                                          //默认显示图片
                                                          height: 38,
                                                          width: double
                                                              .infinity)))),
                                      onTap: () => toUinfo(list[index])),
                                  Container(
                                    constraints: BoxConstraints(maxWidth: 200),
                                    child: Text(list[index]["nickname"],
                                        overflow: TextOverflow.visible,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: 15)),
                                  ),
                                ],
                              ),
                              InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  highlightColor: Color(0xfff2f2f2),
                                  splashColor: Color(0xffe2e2e2),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(!list[index]
                                                    ["isfollow"]
                                                ? 0xff22d47e
                                                : 0xffcccccc))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        !list[index]["isfollow"]
                                            ? Icon(
                                                IconData(0xeaf3,
                                                    fontFamily: 'sunfont'),
                                                size: 10,
                                                color: Color(0xff22d47e))
                                            : Container(),
                                        Text(
                                            !list[index]["isfollow"]
                                                ? "关注"
                                                : "已关注",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(!list[index]
                                                        ["isfollow"]
                                                    ? 0xff22d47e
                                                    : 0xffb1b1b1)))
                                      ],
                                    ),
                                  ),
                                  onTap: () => handleFollow(list[index], index))
                            ]),
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/none.png"),
                      Text("暂无关注",style: TextStyle(color: Color(0xffcccccc)),)
                    ],
                  ),
          )
        ]));
  }
}
