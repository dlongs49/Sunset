import 'dart:io';
import 'dart:ui';
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
              child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: [Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
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
                                        borderRadius: BorderRadius.circular(4),
                                        color:
                                            Color.fromRGBO(246, 247, 251, 1)),
                                    child: Icon(
                                        IconData(0xeb8a, fontFamily: 'sunfont'),
                                        color: Colors.black,
                                        size: 8),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )]),
            )
          ],
        ),
      ),
    );
  }
}
