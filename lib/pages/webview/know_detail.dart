import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/know_req.dart';
import 'package:sunset/utils/tools.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custom/CustomLinearProgressIndicator.dart';

class KnowDetail extends StatefulWidget {
  final arguments;

  const KnowDetail({Key? key, this.arguments}) : super(key: key);

  @override
  _KnowDetailState createState() => _KnowDetailState(arguments: this.arguments);
}

class _KnowDetailState extends State<KnowDetail> {
  final arguments;

  _KnowDetailState({this.arguments});

  KnowReq knowReq = new KnowReq();
  Map item = {"islike": false, "like_num": 0, "comment_num": 0};


  void initState() {
    super.initState();
    getKnowDetail();
  }

  String url = "http://sunset-server.dillonl.com/trends_detail.html";

  // 详情
  void getKnowDetail() async {
    try {
      Map res = await knowReq.getKnowDetail({"id": arguments["id"]});
      if (res["code"] == 200) {
        item = res["data"];
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  // 收藏 & 取消收藏
  void handleLike() async {
    String uid = await getStorage("uid");
    // 有token限制
    if (uid == null) {
      showIsLogDialog(context);
      return;
    }
    try {
      Map res = await knowReq.likeKnow({"id": item["id"]});
      print("收藏>>${res}");
      if (res["code"] == 200) {
        int num = item["like_num"];
        item["islike"] = !item["islike"];
        item["like_num"] = item["islike"] ? num + 1 : num - 1;
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }

  // H5 加载进度
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title: "文章详情", bgColor: null, fontColor: null),
          progress != 1.0
              ? CustomLinearProgressIndicator(value: progress)
              : Container(height: 4),
          Expanded(
              child: Container(
                  color: Color(0xFFF6F7FB),
                  child: WebView(
                      initialUrl:
                          arguments["isthird"] == 1 ? arguments["url"] : "${url}?id=${arguments["id"]}",
                      javascriptMode: JavascriptMode.unrestricted,
                      onProgress: (int gress) {
                        progress = (gress / 100);
                        setState(() {});
                      }))),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 36),
            padding: EdgeInsets.only(top: 12),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    child: Row(
                      children: [
                        Icon(IconData(0xe603, fontFamily: "sunfont"),
                            size: 24,
                            color: Color(
                                item['islike'] ? 0xff22d47e : 0xff999999)),
                        Text("收藏 ${item['like_num']}",
                            style: TextStyle(
                                color: Color(
                                    item['islike'] ? 0xff22d47e : 0xff999999),
                                fontSize: 14))
                      ],
                    ),
                  ),
                  onTap: handleLike,
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(IconData(0xe6ba, fontFamily: "sunfont"),
                          size: 24, color: Color(0xff999999)),
                      Text("评论 ${item['comment_num']}",
                          style:
                              TextStyle(color: Color(0xff999999), fontSize: 14))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
