import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './local_data/home.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  //透明沉浸式状态栏
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunset',
      debugShowCheckedModeBanner: false, // 移除右上角 debug 标志
      // home: HomePage(),

      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          // 设置沉浸式状态栏文字颜色
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController navController = ScrollController();

  // 我的设备
  Widget MyDeviceComm() {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      padding: EdgeInsets.only(top: 15, bottom: 10, left: 15, right: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("我的设备",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
              InkWell(
                  child: Container(
                      // 点击事件
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Text("更多设备",
                            style: TextStyle(
                                color: Color.fromRGBO(120, 120, 120, 1),
                                fontSize: 12)),
                        SizedBox(width: 5),
                        Icon(IconData(0xeb8a, fontFamily: 'sunfont'),
                            size: 10, color: Color.fromRGBO(120, 120, 120, 1))
                      ])),
                  onTap: () {
                    print("跳转更多设备");
                  })
            ],
          ),
          Container(
              width: double.infinity,
              height: 75,
              margin: EdgeInsets.only(top: 14, bottom: 12),
              child: ListView(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: deviceList.map((item) {
                    return InkWell(
                      child: Container(
                          margin:
                              EdgeInsets.only(right: item['id'] != 4 ? 50 : 0),
                          child: Column(
                            children: [
                              Container(
                                  width: 46,
                                  height: 46,
                                  margin: EdgeInsets.only(bottom: 7),
                                  child: Align(
                                      child: Image.asset(item['image'],
                                          fit: BoxFit.cover))),
                              SizedBox(height: 4),
                              Text(
                                item['title'],
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )),
                      onTap: () {
                        print(item);
                      },
                    );
                  }).toList()))
        ],
      ),
    );
  }

  // 人气动态
  Widget MyPopTrendComm() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(top: 15, bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("人气动态",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 14)),
                InkWell(
                    child: Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Text("更多动态",
                              style: TextStyle(
                                  color: Color.fromRGBO(120, 120, 120, 1),
                                  fontSize: 12)),
                          SizedBox(width: 5),
                          Icon(IconData(0xeb8a, fontFamily: 'sunfont'),
                              size: 10, color: Color.fromRGBO(120, 120, 120, 1))
                        ])),
                    onTap: () {})
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            margin: EdgeInsets.only(top: 18),
            child: ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: popTrendList.map((item) {
                return InkWell(
                    child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    children: [
                                      Image.network(item['fileList'][0]['url'],
                                          fit: BoxFit.cover,
                                          width: 120,
                                          height: 120)
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Align(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 3,
                                            bottom: 3),
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Text(
                                            item["tagsNum"].toString() + "人点赞",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white))),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: 120,
                              height: 34,
                              child: Text(item["textShow"],
                                  maxLines: 2,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 5),
                                      width: 20,
                                      height: 20,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Image.network(item["avatar"],
                                          fit: BoxFit.cover)),
                                  Container(
                                    width: 80,
                                    child: Text(item["nickName"],
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                108, 107, 113, 1))),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                    onTap: () {});
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 知识精选
  Widget MyKnowLedgeComm() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("知识精选",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 14)),
                InkWell(
                    child: Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Text("更多知识",
                              style: TextStyle(
                                  color: Color.fromRGBO(120, 120, 120, 1),
                                  fontSize: 12)),
                          SizedBox(width: 5),
                          Icon(IconData(0xeb8a, fontFamily: 'sunfont'),
                              size: 10, color: Color.fromRGBO(120, 120, 120, 1))
                        ])),
                    onTap: () {})
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 140,
            margin: EdgeInsets.only(top: 18),
            child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                // 根据不同的平台切换不同的物理效果
                scrollDirection: Axis.horizontal,
                children: knowLedgeList.map((item) {
                  return InkWell(
                    child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    children: [
                                      Image.network(item["coverUrl"],
                                          fit: BoxFit.cover,
                                          width: 120,
                                          height: 94)
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Align(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 3,
                                            bottom: 3),
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Text(
                                            item["collectNum"].toString() +
                                                "人收藏",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white))),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: 120,
                              child: Text(item["title"],
                                  maxLines: 2,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                            )
                          ],
                        )),
                    onTap: () {},
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }

  double barScrollX = 0;
  double listViewWidth = 76.0 * navList.length; // listView宽度
  double navTrackWidth = 30; // 轨道
  double navBarWidth = 15; // 滑块
  @override
  void initState() {
    navController.addListener(() {
      double _barScrollX = (navController.offset * navTrackWidth) / listViewWidth;
      setState(() {
        barScrollX = _barScrollX;
      });
      print("滑动的距离>> $barScrollX");
    });
  }

  @override
  Widget build(BuildContext context) {
    double topBarHeight = MediaQueryData.fromWindow(window).padding.top;
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 247, 251, 1),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(children: [
              Container(
                height: topBarHeight,
                color: Color.fromRGBO(246, 247, 251, 1),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                height: 46.0,
                color: Color.fromRGBO(246, 247, 251, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(right: 10),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: Image.asset("assets/images/3044.jpg",
                              fit: BoxFit.cover),
                        ),
                        Text(
                          "我",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "设备",
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Icon(IconData(0xe720, fontFamily: 'sunfont'),
                                color: Colors.black, size: 21.0)),
                      ],
                    )
                  ],
                ),
              ),
            ]),
            Expanded(
              child: MediaQuery.removePadding(
                  // 去除顶部留白
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView(physics: ClampingScrollPhysics(), children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 176,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(34, 212, 126, 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10))),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 15, right: 15),
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Color.fromRGBO(
                                                    46, 202, 129, 1)),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Icon(
                                            IconData(0xe62c,
                                                fontFamily: 'sunfont'),
                                            color: Colors.black,
                                            size: 10.0)),
                                    Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Text("您的周报已生成，请查看！",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ))),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color:
                                              Color.fromRGBO(246, 247, 251, 1)),
                                      child: Icon(
                                          IconData(0xeb8a,
                                              fontFamily: 'sunfont'),
                                          color: Colors.black,
                                          size: 8),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(children: [
                            Container(
                                width: double.infinity,
                                height: 78,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  // 根据不同的平台切换不同的物理效果
                                  scrollDirection: Axis.horizontal,
                                  controller: navController,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: navList.map((item) {
                                          return InkWell(
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(right: item['id'] == 5 ? 0 : 15),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: Align(
                                                          child: Image.asset(item["image"], width: 60))
                                                    ),
                                                    Text(
                                                      item["title"],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                )),
                                            onTap: () {
                                              print(item);
                                            },
                                          );
                                        }).toList())
                                  ],
                                )),
                            SizedBox(height: 10),
                            Stack(
                              children: [
                                Container(
                                  width: navTrackWidth,
                                  height: 3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Color(0xffecedf2)),
                                ),
                                Positioned(
                                    left: barScrollX,
                                    child: Container(
                                      width: navBarWidth,
                                      height: 3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Color(0xff6dce87)),
                                    ))
                              ],
                            )
                          ]),
                          SizedBox(height: 14),
                          Container(
                            width: double.infinity,
                            height: 110,
                            padding: EdgeInsets.only(right: 16),
                            clipBehavior: Clip.hardEdge,
                            // 超出隐藏，overflow
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 140,
                                      height: 110,
                                      child: Image.asset(
                                          "assets/images/jihua.jpg",
                                          fit: BoxFit.cover)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("立即设置目标体重",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800)),
                                      Container(
                                        height: 30,
                                        width: 100,
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(34, 212, 126, 1),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Align(
                                            child: Text("开始计划",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white))),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 14),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 16,
                                        bottom: 22),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("饮食&运动记录",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14)),
                                            Container(
                                                // 点击事件
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                  Text("更多食谱",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              120, 120, 120, 1),
                                                          fontSize: 12)),
                                                  SizedBox(width: 5),
                                                  Icon(
                                                      IconData(0xeb8a,
                                                          fontFamily:
                                                              'sunfont'),
                                                      size: 10,
                                                      color: Color.fromRGBO(
                                                          120, 120, 120, 1))
                                                ]))
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Text("还可以吃",
                                                        style: TextStyle(
                                                            fontSize: 12)),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                        IconData(0xeb8a,
                                                            fontFamily:
                                                                'sunfont'),
                                                        size: 10,
                                                        color: Colors.black)
                                                  ]),
                                                  SizedBox(height: 3),
                                                  Row(children: [
                                                    Text("1998",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25,
                                                            fontFamily:
                                                                "PingFang SC")),
                                                    Text("千卡",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontSize: 10,
                                                            height: 2.6))
                                                  ]),
                                                  Container(
                                                      width: 120,
                                                      height: 5,
                                                      margin: EdgeInsets.only(
                                                          top: 4, bottom: 4),
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              237, 236, 242, 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15))),
                                                  Text("推荐摄入1998千卡",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromRGBO(
                                                              191,
                                                              191,
                                                              193,
                                                              1)))
                                                ],
                                              ),
                                              Container(
                                                width: 150,
                                                height: 90,
                                                color: Colors.grey[350],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                        top: 8,
                                        bottom: 14,
                                        left: 15,
                                        right: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: mealsList.map((item) {
                                          return InkWell(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 8,
                                                    bottom: 8),
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        246, 247, 251, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                        IconData(item['icon'],
                                                            fontFamily:
                                                                'sunfont'),
                                                        size: 20,
                                                        color: Colors.black),
                                                    SizedBox(height: 5),
                                                    Text(item['title'],
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black))
                                                  ],
                                                ),
                                              ),
                                              onTap: () {});
                                        }).toList()),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 130,
                                    margin: EdgeInsets.only(top: 14),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  MyDeviceComm(), // 我的设备
                                  MyPopTrendComm(), // 人气动态
                                  MyKnowLedgeComm(), // 知识精选
                                  SizedBox(height: 30)
                                ],
                              ))
                        ],
                      ),
                    )
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
