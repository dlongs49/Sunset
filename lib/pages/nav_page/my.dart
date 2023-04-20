import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/provider/global.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/request.dart';

class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive =>true;
  List card1 = [
    {"icon": 0xeeee, "title": "关于App/作者", "path": "aboutApp"},
    {"icon": 0xe720, "title": "我的设备", "path": "myDevice"},
    {"icon": 0xe899, "title": "家庭成员", "path": "family"},
    {"icon": 0xe65d, "title": "历史记录", "path": ""},
  ];
  List card2 = [
    {"icon": 0xe8ba, "title": "主题皮肤", "path": "themeSkin"},
    {"icon": 0xe642, "title": "问题反馈", "path": ""},
    {"icon": 0xe746, "title": "称重提醒", "path": ""},
    {"icon": 0xe625, "title": "我的收藏", "path": "myLike"},
  ];

  @override
  void initState() {
    // getUInfo();

  }

  Sign sign = new Sign();

  // Map<String, dynamic> uinfo = {"nickname":"未登录","avator":"/avator/sunset202303311711.png",};
  // // 个人信息
  // void getUInfo() async {
  //   try {
  //     Map res = await sign.getUInfo();
  //     print("个人信息>>> $res");
  //     if (res["code"] == 200) {
  //       setState(() {
  //         uinfo = res["data"];
  //       });
  //     }
  //     if (res['code'] == 401) {
  //       Navigator.pushNamed(context, 'phoneLog');
  //     }
  //   } catch (e) {
  //     print(e);
  //     errToast();
  //   }
  // }

  //设置 个人信息
  void toPages(String path) {
    Navigator.pushNamed(context, path);
  }
  void toUserinfo() async{
    // 将用户 uid 存储在缓存中
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs
    //     .setString("uid", uinfo["uid"]);
    // Navigator.pushNamed(context, "userInfo",arguments: {"uid":uinfo["uid"]});
  }
  // 卡片跳转页面
  void toPage(dynamic val, int index) {
    Map item = Map<String, dynamic>.from(val);
    if (item["path"].length != 0 && item["path"] != null) {
      Navigator.pushNamed(context, item["path"]);
      // Navigator.push(
      //     context, CupertinoPageRoute(builder: (context) => AboutApp()));
    } else {
      // 暂无页面
      Fluttertoast.showToast(
          msg: item["title"],
          toastLength: Toast.LENGTH_SHORT,
          // 停留时长短 & 长
          gravity: ToastGravity.CENTER,
          // 弹框是否居中
          backgroundColor: Color(0xd23b3b3b),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //邀请好友 & 商城 【webview】
  void toview(String webViewName) {
    Navigator.pushNamed(context, webViewName);
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // if(mounted){
    //   Golbal nf = Provider.of<Golbal>(context);
    //   // nf.get();
    //   print("NF-uinfo>>>>:${nf.uinfo}");
    //   // setState(() {  });
    // }
    Golbal nf = Provider.of<Golbal>(context);
    Map uinfo = nf.uinfo;
    // nf.get();
    print("NF-uinfo>>>>:${nf.uinfo}");
    // uinfo = nf.uinfo;
    double topBarHeight =
        MediaQueryData.fromWindow(window).padding.top; // 沉浸栏高度
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(children: [
          Container(
            height: topBarHeight,
            color: Color(0xff22d47e),
          ),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 46.0,
              color: Color(0xff22d47e),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                  IconData(0xe601, fontFamily: 'sunfont'),
                                  color: Colors.white,
                                  size: 24.0)),
                          onTap: () => toPages("scan")),
                      Text("我的",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      Row(
                        children: [
                          InkWell(
                              child: Container(
                                  width: 30,
                                  height: 40,
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                      IconData(0xe636, fontFamily: 'sunfont'),
                                      color: Colors.white,
                                      size: 22.0)),
                              onTap: () => toPages("setting")),
                          InkWell(
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                      IconData(0xe60a, fontFamily: 'sunfont'),
                                      color: Colors.white,
                                      size: 22.0)),
                              onTap: () {
                                print("铃铛");
                              })
                        ],
                      )
                    ],
                  ),
                ],
              )),
        ]),
        Expanded(
            child: Stack(children: [
          MediaQuery.removePadding(
              // 去除顶部留白
              context: context,
              removeTop: true,
              removeBottom: true,
              child: ListView(physics: BouncingScrollPhysics(),
                  // ClampingScrollPhysics 安卓滑动效果 BouncingScrollPhysics IOS滑动效果
                  children: [
                    Container(
                      color: Color(0xFFF6F7FB),
                      child: Stack(
                        children: [
                          Positioned(
                              child: Container(
                            width: double.infinity,
                            height: 130,
                            color: Color(0xff22d47e),
                            child: CustomPaint(
                              painter: arcBg(),
                            ),
                          )),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          child: Image.network(
                                              "${baseUrl}${uinfo["avator"]}",
                                              fit: BoxFit.cover,
                                              errorBuilder: (ctx, err, stackTrace) => Image.asset(
                                                  'assets/images/sunset.png',
                                                  width: double.infinity)
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(70),
                                            color: Colors.white),
                                      ),
                                      onTap: () => toPages("myInfo"),
                                    ),
                                    SizedBox(width: 15),
                                    InkWell(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(uinfo["nickname"],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text("个人主页",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xb7ffffff))),
                                                SizedBox(width: 4),
                                                Icon(
                                                    IconData(0xeb8a,
                                                        fontFamily: 'sunfont'),
                                                    color: Color(0xb7ffffff),
                                                    size: 10)
                                              ],
                                            )
                                          ],
                                        ),
                                        onTap: toUserinfo
                                    ),
                                    Spacer(flex: 1),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Color(0x28000000),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Icon(
                                          IconData(0xe703,
                                              fontFamily: 'sunfont'),
                                          color: Colors.white,
                                          size: 16),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("香豆商城",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffe8ae65),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800)),
                                                      SizedBox(height: 4),
                                                      Text("可兑换海量商品",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffe7c192),
                                                              fontSize: 12))
                                                    ],
                                                  ),
                                                  Image.asset(
                                                    "assets/images/mall.png",
                                                    width: 30,
                                                    height: 30,
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () => toview("mall"))),
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: InkWell(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("邀请享好礼",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffe08278),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800)),
                                                      SizedBox(height: 4),
                                                      Text("天天香豆赚不停",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffd2b0ae),
                                                              fontSize: 12))
                                                    ],
                                                  ),
                                                  Image.asset(
                                                    "assets/images/gift.png",
                                                    width: 30,
                                                    height: 30,
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () => toview("invite"))),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:
                                          card1.asMap().entries.map((entry) {
                                        int index = entry.key;
                                        var item = entry.value;
                                        return InkWell(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: index != 3 ? 30 : 0),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  item['icon'] == 0xeeee
                                                      ? Image.asset(
                                                          "assets/images/author.png",
                                                          width: 30,
                                                          height: 30,
                                                        )
                                                      : Icon(
                                                          IconData(item["icon"],
                                                              fontFamily:
                                                                  'sunfont'),
                                                          size: 20,
                                                          color: Colors.black),
                                                  SizedBox(width: 8),
                                                  Text(item["title"],
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                  Spacer(flex: 1),
                                                  Icon(
                                                      IconData(0xeb8a,
                                                          fontFamily:
                                                              "sunfont"),
                                                      size: 14,
                                                      color: Color(0xffb8b7bd))
                                                ],
                                              ),
                                            ),
                                            onTap: () => toPage(item, index));
                                      }).toList()),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:
                                          card2.asMap().entries.map((entry) {
                                        int index = entry.key;
                                        var item = entry.value;
                                        return InkWell(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: index != 3 ? 30 : 0),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                      IconData(item["icon"],
                                                          fontFamily:
                                                              'sunfont'),
                                                      size: 20,
                                                      color: Colors.black),
                                                  SizedBox(width: 8),
                                                  Text(item["title"],
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                  Spacer(flex: 1),
                                                  Icon(
                                                      IconData(0xeb8a,
                                                          fontFamily:
                                                              "sunfont"),
                                                      size: 14,
                                                      color: Color(0xffb8b7bd))
                                                ],
                                              ),
                                            ),
                                            onTap: () => toPage(item, index));
                                      }).toList()),
                                ),
                                SizedBox(height: 30)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]))
        ]))
      ],
    );
  }
}

// 弧形 【百度大神】
class arcBg extends CustomPainter {
  Paint _paint = Paint()
    ..color = Color(0xff22d47e) //画笔颜色
    ..strokeCap = StrokeCap.butt //画笔笔触类型
    // ..isAntiAlias = true //是否启动抗锯齿
    // ..blendMode = BlendMode.exclusion //颜色混合模式
    ..style = PaintingStyle.fill //绘画风格，默认为填充
    // ..colorFilter = ColorFilter.mode(Colors.redAccent,
    //     BlendMode.exclusion) //颜色渲染模式，一般是矩阵效果来改变的,但是flutter中只能使用颜色混合模式
    // ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3.0) //模糊遮罩效果，flutter中只有这个
    ..filterQuality = FilterQuality.high //颜色渲染模式的质量
    ..strokeWidth = 0.0; //

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(0.0, 0.0), Offset(0.0, 0.0), _paint);
    const PI = 3.1415926;

    var controlPoint1 = Offset(size.width / 4, size.height / 3 * 4); //控制点
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 3 * 4); //控制点
    var endPoint = Offset(size.width, size.height); //结束位置

    var path = Path();
    path.moveTo(0, 130); //开始位置,容器的高度
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, _paint);
  }

  //避免重绘开销
  @override
  bool shouldRepaint(arcBg oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(arcBg oldDelegate) => false;
}
