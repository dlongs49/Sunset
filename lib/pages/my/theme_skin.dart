import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/provider/global.dart';
import 'package:sunset/utils/tools.dart';

class ThemeSkin extends StatefulWidget {
  const ThemeSkin({Key? key}) : super(key: key);

  @override
  _ThemeSkinState createState() => _ThemeSkinState();
}

class _ThemeSkinState extends State<ThemeSkin> {
  // 主题集合
  List list = [
    0xff22d47e,
    0xff605af2,
    0xff8682a3,
    0xfffd8f3a,
    0xff11bff1,
    0xff456da1
  ];

  void initState() {
    super.initState();
    getSkinStorage();
  }
  void getSkinStorage()async{
     var index = await getStorage('skin_index');
     activeIndex = index != null ? index : 0;
     if (mounted) {
       setState(() {});
     }

  }
  // 选中的主题索引
  int activeIndex = 0;

  // 主题色切换
  void handleSkin(int index) async {
    activeIndex = index;
    await setStorage("skin", list[index]);
    await setStorage("skin_index", index);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final prof = Provider.of<Global>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomTabBar(title: "主题色", bgColor: null, fontColor: null),
            Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        physics: BouncingScrollPhysics(),
                        // IOS的回弹属性
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 主轴一行的数量
                          mainAxisSpacing: 20, // 主轴每行间距
                          crossAxisSpacing: 26, // 交叉轴每行间距
                          childAspectRatio: 1, // item的宽高比
                        ),
                        itemBuilder: (ctx, i) => InkWell(
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(list[i]),
                                    borderRadius: BorderRadius.circular(14)),
                                child: Visibility(
                                    visible: i == activeIndex ? true : false,
                                    child: Icon(
                                        IconData(0xe645, fontFamily: 'sunfont'),
                                        color: Colors.white,
                                        size: 26))),
                            onTap: () {
                              handleSkin(i);
                              prof.handleTheme(list[i]);
                            }))))
          ],
        ));
  }
}
