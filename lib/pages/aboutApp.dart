import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sunset/components/tabbar.dart';
class AboutApp extends StatefulWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  void toLauncher(String str) async {
    String url = "https://www.dillonl.com";
    if (str == 'gitee') {
      url = "https://gitee.com/dlongs49/sunset";
    } else if (str == 'github') {
      url = "https://github.com/dlongs49/sunset";
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("异常");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title:"关于我们",bgColor:null,fontColor:null),
          SizedBox(height: 50),
          Align(
            child: Image.asset(
              "assets/images/3044.jpg",
              width: 60,
              height: 60,
            ),
          ),
          SizedBox(height: 50),
          Align(
            child: Text("Sunset",
                style: TextStyle(
                    color: Color(0xff22d47e),
                    fontSize: 23,
                    fontWeight: FontWeight.w800)),
          ),
          SizedBox(height: 10),
          Align(
            child: Text("v1.0.1",
                style: TextStyle(
                    color: Color(0xffbdbdbd),
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: 30),
          InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("码云", style: TextStyle(fontSize: 18)),
                        Icon(Icons.chevron_right_outlined,
                            color: Color(0xffc2c2c2), size: 24)
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () => toLauncher('gitee')),
          InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("GitHub", style: TextStyle(fontSize: 18)),
                        Icon(Icons.chevron_right_outlined,
                            color: Color(0xffc2c2c2), size: 24)
                      ],
                    )
                  ],
                ),
              ),
              onTap: () => toLauncher('github')),
          InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("个站", style: TextStyle(fontSize: 18)),
                        Icon(Icons.chevron_right_outlined,
                            color: Color(0xffc2c2c2), size: 24)
                      ],
                    )
                  ],
                ),
              ),
              onTap: () => toLauncher('website')),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 0.5, color: Color(0xffe7e7e8))))),
          SizedBox(height: 26),
          Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 80),
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xfff1f1f1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                  "该软件仅用于学习开发使用，已在Gitee(码云), github 上开源，请勿用于商业用途,原版App为Sunri，如有侵权请立即联系作者 dillonl.dl49@gmail.com",
                  style: TextStyle(fontSize: 13, height: 1.6)))
        ],
      ),
    );
  }
}
