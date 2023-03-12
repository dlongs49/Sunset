import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              child: ListView(physics: ClampingScrollPhysics(), children: [
                Container(
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
                                        IconData(0xe62c, fontFamily: 'sunfont'),
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
                                      borderRadius: BorderRadius.circular(4),
                                      color: Color.fromRGBO(246, 247, 251, 1)),
                                  child: Icon(
                                      IconData(0xeb8a, fontFamily: 'sunfont'),
                                      color: Colors.black,
                                      size: 8),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                          width: double.infinity,
                          height: 70,
                          margin: EdgeInsets.only(top: 20, bottom: 30),
                          child: ListView(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            // 根据不同的平台切换不同的物理效果
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 30),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 46,
                                            height: 46,
                                            margin: EdgeInsets.only(bottom: 7),
                                            child: Align(
                                                child: Icon(
                                                    IconData(0xe636,
                                                        fontFamily: 'sunfont'),
                                                    size: 24,
                                                    color: Colors.white)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                            130, 169, 248, 1)
                                                        .withOpacity(0.2),
                                                    // 阴影的颜色
                                                    offset: Offset(-1, 10),
                                                    // 阴影与容器的距离
                                                    blurRadius: 10.0,
                                                    // 高斯的标准偏差与盒子的形状卷积。
                                                    spreadRadius:
                                                        0.0, // 在应用模糊之前，框应该膨胀的量。
                                                  ),
                                                ],
                                                gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    //右上
                                                    end: Alignment.bottomLeft,
                                                    //左下
                                                    stops: [
                                                      0.0,
                                                      1.0
                                                    ],
                                                    colors: [
                                                      Color.fromRGBO(
                                                          130, 169, 248, 1),
                                                      Color.fromRGBO(
                                                          109, 179, 241, 1),
                                                    ])),
                                          ),
                                          Text(
                                            "每日步数",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(right: 30),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 46,
                                            height: 46,
                                            margin: EdgeInsets.only(bottom: 7),
                                            child: Align(
                                                child: Icon(
                                                    IconData(0xe644,
                                                        fontFamily: 'sunfont'),
                                                    size: 24,
                                                    color: Colors.white)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                            251, 173, 91, 1)
                                                        .withOpacity(0.2),
                                                    // 阴影的颜色
                                                    offset: Offset(-1, 10),
                                                    // 阴影与容器的距离
                                                    blurRadius: 10.0,
                                                    // 高斯的标准偏差与盒子的形状卷积。
                                                    spreadRadius:
                                                        0.0, // 在应用模糊之前，框应该膨胀的量。
                                                  ),
                                                ],
                                                gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    //右上
                                                    end: Alignment.bottomLeft,
                                                    //左下
                                                    stops: [
                                                      0.0,
                                                      1.0
                                                    ],
                                                    colors: [
                                                      Color.fromRGBO(
                                                          251, 173, 91, 1),
                                                      Color.fromRGBO(
                                                          251, 201, 138, 1),
                                                    ])),
                                          ),
                                          Text(
                                            "小目标",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(right: 30),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 46,
                                            height: 46,
                                            margin: EdgeInsets.only(bottom: 7),
                                            child: Align(
                                                child: Icon(
                                                    IconData(0xe606,
                                                        fontFamily: 'sunfont'),
                                                    size: 24,
                                                    color: Colors.white)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                            239, 140, 85, 1)
                                                        .withOpacity(0.2),
                                                    // 阴影的颜色
                                                    offset: Offset(-1, 10),
                                                    // 阴影与容器的距离
                                                    blurRadius: 10.0,
                                                    // 高斯的标准偏差与盒子的形状卷积。
                                                    spreadRadius:
                                                        0.0, // 在应用模糊之前，框应该膨胀的量。
                                                  ),
                                                ],
                                                gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    //右上
                                                    end: Alignment.bottomLeft,
                                                    //左下
                                                    stops: [
                                                      0.0,
                                                      1.0
                                                    ],
                                                    colors: [
                                                      Color.fromRGBO(
                                                          239, 140, 85, 1),
                                                      Color.fromRGBO(
                                                          242, 151, 104, 1),
                                                    ])),
                                          ),
                                          Text(
                                            "食物查询",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(right: 30),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 46,
                                            height: 46,
                                            margin: EdgeInsets.only(bottom: 7),
                                            child: Align(
                                                child: Icon(
                                                    IconData(0xe60b,
                                                        fontFamily: 'sunfont'),
                                                    size: 24,
                                                    color: Colors.white)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                            198, 116, 252, 1)
                                                        .withOpacity(0.2),
                                                    // 阴影的颜色
                                                    offset: Offset(-1, 10),
                                                    // 阴影与容器的距离
                                                    blurRadius: 10.0,
                                                    // 高斯的标准偏差与盒子的形状卷积。
                                                    spreadRadius:
                                                        0.0, // 在应用模糊之前，框应该膨胀的量。
                                                  ),
                                                ],
                                                gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    //右上
                                                    end: Alignment.bottomLeft,
                                                    //左下
                                                    stops: [
                                                      0.0,
                                                      1.0
                                                    ],
                                                    colors: [
                                                      Color.fromRGBO(
                                                          198, 116, 252, 1),
                                                      Color.fromRGBO(
                                                          215, 135, 250, 1),
                                                    ])),
                                          ),
                                          Text(
                                            "历史记录",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(right: 30),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 46,
                                            height: 46,
                                            margin: EdgeInsets.only(bottom: 7),
                                            child: Align(
                                                child: Icon(
                                                    IconData(0xe608,
                                                        fontFamily: 'sunfont'),
                                                    size: 24,
                                                    color: Colors.white)),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                            120, 236, 139, 1)
                                                        .withOpacity(0.2),
                                                    // 阴影的颜色
                                                    offset: Offset(-1, 10),
                                                    // 阴影与容器的距离
                                                    blurRadius: 10.0,
                                                    // 高斯的标准偏差与盒子的形状卷积。
                                                    spreadRadius:
                                                        0.0, // 在应用模糊之前，框应该膨胀的量。
                                                  ),
                                                ],
                                                gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    //右上
                                                    end: Alignment.bottomLeft,
                                                    //左下
                                                    stops: [
                                                      0.0,
                                                      1.0
                                                    ],
                                                    colors: [
                                                      Color.fromRGBO(
                                                          120, 236, 139, 1),
                                                      Color.fromRGBO(
                                                          156, 239, 149, 1),
                                                    ])),
                                          ),
                                          Text(
                                            "体重趋势",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      )),
                                  Container(
                                      child: Column(
                                    children: [
                                      Container(
                                        width: 46,
                                        height: 46,
                                        margin: EdgeInsets.only(bottom: 7),
                                        child: Align(
                                            child: Icon(
                                                IconData(0xe601,
                                                    fontFamily: 'sunfont'),
                                                size: 24,
                                                color: Colors.white)),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                        92, 208, 195, 1)
                                                    .withOpacity(0.2),
                                                // 阴影的颜色
                                                offset: Offset(-1, 10),
                                                // 阴影与容器的距离
                                                blurRadius: 10.0,
                                                // 高斯的标准偏差与盒子的形状卷积。
                                                spreadRadius:
                                                    0.0, // 在应用模糊之前，框应该膨胀的量。
                                              ),
                                            ],
                                            gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                //右上
                                                end: Alignment.bottomLeft,
                                                //左下
                                                stops: [
                                                  0.0,
                                                  1.0
                                                ],
                                                colors: [
                                                  Color.fromRGBO(
                                                      92, 208, 195, 1),
                                                  Color.fromRGBO(
                                                      117, 228, 212, 1),
                                                ])),
                                      ),
                                      Text(
                                        "周报",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ))
                                ],
                              )
                            ],
                          )),
                      Container(
                        width: double.infinity,
                        height: 110,
                        padding: EdgeInsets.only(right:16),
                        clipBehavior: Clip.hardEdge, // 超出隐藏，overflow
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Container(
                              width:140,
                              height: 110,
                              child: Image.asset("assets/images/jihua.jpg",
                              fit: BoxFit.cover)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:CrossAxisAlignment.end,
                            children: [
                            Text("立即设置目标体重",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w800)),
                            Container(
                              height: 30,
                              width:100,
                              margin: EdgeInsets.only(top:10),
                              decoration: BoxDecoration(
                                  color:Color.fromRGBO(34, 212, 126, 1),
                                  borderRadius: BorderRadius.circular(16)
                              ),
                              child: Align(child:Text("开始计划",style:TextStyle(fontSize: 13,color: Colors.white))),
                            )
                          ],)
                        ]),
                      )
                    ],
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
