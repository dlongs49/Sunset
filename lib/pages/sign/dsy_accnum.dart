import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/sign_req.dart';

class DsyAccnum extends StatefulWidget {
  const DsyAccnum({Key? key}) : super(key: key);

  @override
  State<DsyAccnum> createState() => _DsyAccnumState();
}

class _DsyAccnumState extends State<DsyAccnum> {
  bool isChecked = false;

  void handleChecked(bool val) {}

  Sign sign = new Sign();

  // 注销账号
  Future<void> handleDsy() async {
    try {
      loading(seconds: 3);
      Map res = await sign.distryUInfo();
      print("ms_token>>> ${res["data"]}");
      if (res["code"] == -1) {
        toast(res["message"]);
        return;
      }
      Navigator.pushNamed(context, '/');
    } catch (e) {
      errToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomTabBar(title: "注销账号", bgColor: null, fontColor: null),
        SizedBox(height: 30),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Text("什么原因让你注销该账号",
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                SizedBox(height: 50),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Color(0xffb8b8b8),
                        //选中的颜色
                        fillColor: MaterialStateProperty.all(Color(0xff22d47e)),
                        //打钩的颜色
                        focusColor: Color(0xff22d47e),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    SizedBox(width: 4),
                    Text("体验不好", style: TextStyle(fontSize: 16))
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Color(0xffb8b8b8),
                        //选中的颜色
                        fillColor: MaterialStateProperty.all(Color(0xff22d47e)),
                        //打钩的颜色
                        focusColor: Color(0xff22d47e),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    SizedBox(width: 4),
                    Text("体验不好", style: TextStyle(fontSize: 16))
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Color(0xffb8b8b8),
                        //选中的颜色
                        fillColor: MaterialStateProperty.all(Color(0xff22d47e)),
                        //打钩的颜色
                        focusColor: Color(0xff22d47e),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    SizedBox(width: 4),
                    Text("体验不好", style: TextStyle(fontSize: 16))
                  ],
                ),
                SizedBox(height: 30),
                Align(
                  child: Ink(
                      decoration: BoxDecoration(
                          color: Color(0xfff56f32),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          highlightColor: Color(0xffd44b10), // 水波纹高亮颜色
                          child: Container(
                            alignment: Alignment(0, 0),
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text("注销",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
                          ),
                          onTap: handleDsy)),
                ),
              ],
            ))
      ]),
    );
  }
}
