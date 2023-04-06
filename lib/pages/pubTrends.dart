import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/api/trends_req.dart';
import 'package:sunset/utils/api/upload_req.dart';

class PubTrends extends StatefulWidget {
  const PubTrends({Key? key, arguments}) : super(key: key);

  @override
  _PubTrendsState createState() => _PubTrendsState();
}

class _PubTrendsState extends State<PubTrends> {
  TextEditingController ProfileController = TextEditingController();
  String maxTextNum = "0/140";
  int maxnum = 140;
  Map<String, dynamic> map = new Map();

  @override
  void initState() {
    super.initState();
  }

  // 监听文字输入
  void textChanged(String value) {
    setState(() {
      map["text"] = value;
      maxTextNum = "${value.length.toString()}/140";
    });
  }

  TrendsReq trendsReq = new TrendsReq();
  UploadReq uploadReq = new UploadReq();

  // 上传图片
  void handleImg() {}

  // 发布动态
  void saveProfile(context) async {
    print(map["text"]);
    return;
    try {
      Map res = await trendsReq.publishTrends(map);
      print("立即发布>>> ${res}");
      if (res["code"] == 200) {
        FocusManager.instance.primaryFocus?.unfocus(); // 收起键盘
        // Navigator.pop(context);
      }
    } catch (e) {
      errToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Column(children: [
            Container(
              height: topBarHeight,
              color: Color(0xffffffff),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 46.0,
              color: Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.centerLeft,
                          child: Icon(IconData(0xec8e, fontFamily: 'sunfont'),
                              color: Colors.black, size: 18.0)),
                      behavior: HitTestBehavior.opaque, // 点击整个区域有响应事件，
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  Text("发布动态",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          height: 1.6,
                          decoration: TextDecoration.none)),
                  InkWell(
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Text("立即发布",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff22d47e)))),
                      onTap: () => saveProfile(context))
                ],
              ),
            )
          ]),
          SizedBox(height: 20),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 120,
              height: 120,
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  color: Color(0xffeaeaea),
                  borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_camera,
                          size: 46, color: Color(0xff22d47e)),
                      SizedBox(height: 4),
                      Text("上传图片", style: TextStyle(fontSize: 14))
                    ],
                  ),
                  onTap: handleImg),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Color(0xfff5f5f5)))),
              child: TextField(
                  // 光标颜色
                  cursorColor: Color(0xff22d47e),
                  // 取消自动获取焦点
                  autofocus: false,
                  maxLines: 6,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                      // 取消内边距 isDense不可忽略
                      isDense: true,
                      // 取消边框
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: '发表动态也是一种收获',
                      hintStyle:
                          TextStyle(color: Color(0xffd9d9d9), fontSize: 16)),
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(maxnum) //限制长度
                  ],
                  controller: ProfileController,
                  onChanged: textChanged),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      maxTextNum,
                      style: TextStyle(color: Color(0xff8d8d8d), fontSize: 14),
                    )))
          ])
        ],
      ),
    );
  }
}
