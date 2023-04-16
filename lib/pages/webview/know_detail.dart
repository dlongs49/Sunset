import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/know_req.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KnowDetail extends StatefulWidget {
  final arguments;
  const KnowDetail({Key? key, this.arguments}) : super(key: key);

  @override
  _KnowDetailState createState() => _KnowDetailState(arguments:this.arguments);
}

class _KnowDetailState extends State<KnowDetail> {
  final arguments;
  _KnowDetailState({this.arguments});
  KnowReq knowReq = new KnowReq();
  Map item = {};

  // 收藏 & 取消收藏
  void handleLike () async{
    try {
      Map res =
      await knowReq.likeKnow({"id": 1});
      print("知识精选>>${res["data"]}");
      if (res["code"] == 200) {
        item["islike"] = res["data"]["list"];
        setState(() {});
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
              ? LinearProgressIndicator(
            value: progress,
            backgroundColor: Color(0xffffffff),
            valueColor:
            AlwaysStoppedAnimation<Color>(Color(0xff22d47e)),
          )
              : Container(height: 4),
          Expanded(child: Container(
              color: Color(0xFFF6F7FB),
              child: WebView(
                  initialUrl:
                  "https://www.taobao.com/",
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
                Container(
                  child: Row(
                    children: [
                      Icon(IconData(0xe603,fontFamily: "sunfont"),size: 24,color: Color(0xff999999)),
                      Text("收藏 9",style: TextStyle(color: Color(0xff999999),fontSize: 14))
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(IconData(0xe6ba,fontFamily: "sunfont"),size: 24,color: Color(0xff999999)),
                      Text("评论 9",style: TextStyle(color: Color(0xff999999),fontSize: 14))
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
