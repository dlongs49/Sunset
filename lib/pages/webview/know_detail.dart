import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunset/components/tabbar.dart';
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
                  "https://main.m.taobao.com/",
                  javascriptMode: JavascriptMode.unrestricted,
                  onProgress: (int gress) {
                    progress = (gress / 100);
                    setState(() {});
                  }))),
          Container(
            child: Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon()
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
