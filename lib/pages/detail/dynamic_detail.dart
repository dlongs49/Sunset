import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunset/components/tabbar.dart';

class DynamicDetail extends StatefulWidget {
  const DynamicDetail({Key? key}) : super(key: key);

  @override
  State<DynamicDetail> createState() => _DynamicDetailState();
}

class _DynamicDetailState extends State<DynamicDetail> {
  void textChanged(String txt){
    print(txt);
  }


  void toPage(String path, dynamic arg) {
    Navigator.pushNamed(context, path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomTabBar(title: "动态详情", bgColor: null, fontColor: null),
            Expanded(
              child: MediaQuery.removePadding(
                  // 去除顶部留白
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView(
                    physics: BouncingScrollPhysics(), // IOS的回弹属性
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Row(children: [
                              InkWell(
                                child: Container(
                                    width: 38,
                                    height: 38,
                                    margin: EdgeInsets.only(right: 8),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(38),
                                        child: Image.asset(
                                            "assets/images/400x400.jpg",
                                            fit: BoxFit.cover))),
                                onTap: () => toPage("userInfo", {}),
                              ),
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
                                        IconData(0xeaf3, fontFamily: 'sunfont'),
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
                                    physics: NeverScrollableScrollPhysics(),
                                    // 禁止滑动
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
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 12, bottom: 12),
                          child:
                              Text("全部评论(6)", style: TextStyle(fontSize: 14))),
                      ListView.builder(
                          shrinkWrap: true, //解决无限高度问题
                          physics: new NeverScrollableScrollPhysics(), //禁用滑动事件
                          itemCount: 3,
                          itemBuilder: (ctx, i) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 14),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Color(0xFFF1F1F1)))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 32,
                                      height: 32,
                                      margin: EdgeInsets.only(right: 8),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          child: Image.asset(
                                              "assets/images/400x400.jpg",
                                              fit: BoxFit.cover))),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: 5, bottom: 6),
                                          child: Text("书本书华",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                      Text(
                                          "浔阳江头夜送客，枫叶荻花秋瑟瑟，主人下马客在船，举酒欲饮无管弦。醉不成欢惨将别，别时茫茫江浸月。忽闻水上琵琶声，主人忘归客不发。寻声暗问弹者谁？琵琶声停欲语迟。",
                                          style: TextStyle(
                                              fontSize: 13, height: 1.5)),
                                      SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("2023-03-17",
                                              style: TextStyle(
                                                  color: Color(0xffcccccc),
                                                  fontSize: 13)),
                                          Spacer(flex: 1),
                                          Text("0",
                                              style: TextStyle(
                                                  color: Color(0xffbbbbbb),
                                                  fontSize: 14)),
                                          SizedBox(width: 10),
                                          Icon(
                                              IconData(0xec7f,
                                                  fontFamily: 'sunfont'),
                                              size: 16,
                                              color: Color(0xffbbbbbb)),
                                          SizedBox(width: 10),
                                          Icon(
                                              IconData(0xe600,
                                                  fontFamily: 'sunfont'),
                                              size: 18,
                                              color: Color(0xffbbbbbb))
                                        ],
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Color(0xFFF1F1F1)))),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: 32,
                                                    height: 32,
                                                    margin: EdgeInsets.only(
                                                        right: 8),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32),
                                                        child: Image.asset(
                                                            "assets/images/400x400.jpg",
                                                            fit:
                                                                BoxFit.cover))),
                                                Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                            margin:
                                                            EdgeInsets.only(
                                                                top: 5,
                                                                bottom: 6),
                                                            child: Text("Sept",
                                                                style: TextStyle(
                                                                    fontSize: 13,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600))),
                                                        Text(
                                                            "浔阳江头夜送客，枫叶荻花秋瑟瑟，主人下马客在船，举酒欲饮无管弦。醉不成欢惨将别，别时茫茫江浸月。忽闻水上琵琶声，主人忘归客不发。寻声暗问弹者谁？琵琶声停欲语迟。",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                height: 1.5)),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text("2023-03-17",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xffcccccc),
                                                                    fontSize:
                                                                    13)),
                                                            Spacer(flex: 1),
                                                            Text("0",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xffbbbbbb),
                                                                    fontSize:
                                                                    14)),
                                                            SizedBox(width: 10),
                                                            Icon(
                                                                IconData(0xec7f,
                                                                    fontFamily:
                                                                    'sunfont'),
                                                                size: 16,
                                                                color: Color(
                                                                    0xffbbbbbb)),
                                                            SizedBox(width: 10),
                                                            Icon(
                                                                IconData(0xe600,
                                                                    fontFamily:
                                                                    'sunfont'),
                                                                size: 18,
                                                                color: Color(
                                                                    0xffbbbbbb))
                                                          ],
                                                        ),
                                                      ])
                                                )

                                              ]))
                                    ],
                                  ))
                                ],
                              ),
                            );
                          })
                    ],
                  )
                  ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 48,
              child: Row(
                children: [
                  Expanded(child:  Container(
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Color(0xffeeeff3),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                        cursorHeight: 16,
                        // 光标颜色
                        cursorColor: Color(0xff22d47e),
                        // 取消自动获取焦点
                        autofocus: false,
                        maxLines: 1,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                            isCollapsed: true,
                            //可以设置自己的
                            contentPadding: EdgeInsets.all(6),
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            // 取消边框
                            hintText: '友善评论',
                            helperStyle:
                            TextStyle(color: Color(0xffd0d0d0), fontSize: 13)),
                        onChanged: textChanged),
                  )),
                  SizedBox(width: 16),
                  Container(
                    height: 28,
                    padding: EdgeInsets.symmetric(vertical: 3,horizontal: 20),
                    decoration: BoxDecoration(
                      color:Color(0xff22d47e),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment(0,0),
                    child: Text("发送",style:TextStyle(color:Colors.white,fontSize: 12),
                  ))
                ],
              ),
            )
          ],
        ));
  }
}
