import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
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

  void initState(){
    super.initState();
    getDetail();
  }
  Map detail = new Map();
  Map uinfo = {
    "nickname": "",
    "avator": "",
    "description": "",
    "constellation": "",
    "following": "0",
    "followers": "0",
    "star": "0"
  };
  // 动态详情 & 粉丝，关注，获赞
  Future<void> getDetail() async {
    try {
      Map trendsRes = await trendsReq.getTrendsDetail({"trends_id":arguments["trends_id"]});
      print("动态详情>>${trendsRes["data"]}");
      if (trendsRes["code"] == 200) {
        detail = trendsRes["data"];
        setState(() {});
      }
      Map follRes = await trendsReq.getFollow({"uid":arguments["uid"]});
      print("粉丝，关注，获赞>>${follRes}");
      if (follRes["code"] == 200) {
        uinfo = follRes["data"];
        setState(() {});
      }

    } catch (e) {
      print(e);
      errToast();
    }
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
                  child:
                      Image.network("${baseUrl}${uinfo["avator"]}", fit: BoxFit.cover),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(36),
                                        child:Image.network("${baseUrl}${uinfo["avator"]}",
                                          width: 65,
                                          height: 65,
                                        )),
                                      SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(uinfo["nickname"],style: TextStyle(color: Colors.white,fontSize: 22)),
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: Color(0x68eaeaee),
                                              borderRadius: BorderRadius.circular(16)
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(IconData(uinfo["sex"] == 1 ? 0xe612 : 0xe632,fontFamily: "sunfont"),size:14,color: Color(uinfo["sex"] == 1 ? 0xff51aefe :0xfffb859d)),
                                                SizedBox(width: 6),
                                                Text(uinfo["constellation"],style: TextStyle(fontSize: 13,color: Colors.white),)
                                              ],
                                            )
                                          )
                                        ],
                                      )
                                    ],),
                                    SizedBox(height: 16),
                                    Text(uinfo["description"] != null ? uinfo["description"] : "",style: TextStyle(fontSize: 14,color: Colors.white)),
                                    SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          Column(children: [
                                            Text(uinfo["following"].toString(),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600)),
                                            SizedBox(height: 5),
                                            Text("关注",style: TextStyle(color: Color(
                                                0xfff3f3f3),fontSize: 14),)
                                          ]),
                                          SizedBox(width: 40),
                                          Column(children: [
                                            Text(uinfo["followers"].toString(),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600)),
                                            SizedBox(height: 5),
                                            Text("粉丝",style: TextStyle(color: Color(
                                                0xfff3f3f3),fontSize: 14),)
                                          ]),
                                          SizedBox(width: 40),
                                          Column(children: [
                                            Text(uinfo["star"].toString(),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600)),
                                            SizedBox(height: 5),
                                            Text("获赞",style: TextStyle(color: Color(
                                                0xfff3f3f3),fontSize: 14),)
                                          ])
                                        ]),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 16),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(width: 1,color: Colors.white)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                  IconData(0xeaf3,
                                                      fontFamily: 'sunfont'),
                                                  size: 10,
                                                  color: Color(0xffffffff)),
                                              Text("关注",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xffffffff)))
                                            ],
                                          ),
                                        )
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
                  margin:EdgeInsets.symmetric(vertical: 20),
                  child: Text("Ta的动态",style: TextStyle(color: Color(0xff22d47e),fontSize: 16,fontWeight: FontWeight.w600))
                ),
                SizedBox(height: 15),
                ListView.builder(
                    shrinkWrap: true, 								//解决无限高度问题
                    physics: new NeverScrollableScrollPhysics(),		//禁用滑动事件
                    itemCount: 15,
                    itemBuilder: (ctx,i){
                      return Container(
                          width: double.infinity,
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 35),
                          // padding:
                          // EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Container(
                                      width: 38,
                                      height: 38,
                                      margin: EdgeInsets.only(right: 8),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(38),
                                          child: Image.asset(
                                              "assets/images/400x400.jpg",
                                              fit: BoxFit.cover))),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("书本书华",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800)),
                                      SizedBox(height: 2),
                                      Text("2023.03.21",
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
                                            width: 1.0, color: Color(0xff22d47e)),
                                        borderRadius: BorderRadius.circular(22)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                SizedBox(height: 10),
                                Text(
                                    "浔阳江头夜送客，枫叶荻花秋瑟瑟，主人下马客在船，举酒欲饮无管弦。醉不成欢惨将别，别时茫茫江浸月。忽闻水上琵琶声，主人忘归客不发。寻声暗问弹者谁？琵琶声停欲语迟。",
                                    style: TextStyle(fontSize: 14, height: 1.7)),
                                Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: 6,
                                        physics: NeverScrollableScrollPhysics(),// 禁止滑动
                                        gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3, // 主轴一行的数量
                                          mainAxisSpacing: 6, // 主轴每行间距
                                          crossAxisSpacing: 6, // 交叉轴每行间距
                                          childAspectRatio: 1, // item的宽高比
                                        ),
                                        itemBuilder: (context, index) {
                                          return (Container(
                                              decoration: ShapeDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/400x400.jpg"),
                                                      fit: BoxFit.fitWidth),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(6)))));
                                        })),
                                Container(
                                    margin: EdgeInsets.only(top: 12, bottom: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Color(0xfff3f3f3),
                                        borderRadius: BorderRadius.circular(12)),
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
                                        Text("2",
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
                                        Text("2",
                                            style: TextStyle(
                                                color: Color(0xffbbbbbb),
                                                height: 1.4,
                                                fontSize: 14))
                                      ],
                                    ),
                                    Icon(IconData(0xe617, fontFamily: 'sunfont'),
                                        size: 18, color: Color(0xffbbbbbb)),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 14),
                                  constraints: BoxConstraints(minHeight: 50),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Color(0xfff3f3f3),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              text: '书本书华：',
                                              style: TextStyle(
                                                  color: Color(0xff22d47e),
                                                  fontSize: 12),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '浔阳江头夜送客，枫叶荻花秋瑟瑟',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12)),
                                              ])),
                                      SizedBox(height: 8),
                                      RichText(
                                          text: TextSpan(
                                              text: '书本书华：',
                                              style: TextStyle(
                                                  color: Color(0xff22d47e),
                                                  fontSize: 12),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '浔阳江头夜送客，枫叶荻花秋瑟瑟',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12)),
                                              ])),
                                      SizedBox(height: 8),
                                      Text("查看全部评论",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff7b7b7b)))
                                    ],
                                  ),
                                )
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
