import 'dart:convert';
import 'dart:core';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/local_data/info.dart';
import 'package:sunset/utils/api/sign_req.dart';
import 'package:sunset/utils/request.dart';
// import 'package:image_picker/image_picker.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  _MyInfoState createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  // final ImagePicker imgPicker = ImagePicker(); // 相机，图库权限
  String headimg = "";
  List sexList = ["女", "男"];

  // 重写选择器的样式
  PickerStyle customPickStyle() {
    // 确定按钮样式
    Widget _commitButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      margin: const EdgeInsets.only(right: 22),
      child:
          Text('确定', style: TextStyle(fontSize: 14, color: Color(0xff22d47e))),
    );
    return PickerStyle(
      commitButton: _commitButton,
    );
  }

  void initState() {
    getUInfo();
  }

  Sign sign = new Sign();
  Map<String, dynamic> uinfo = {
    "nickname": "Sunset",
    "avator": "/avator/sunset202303311711.png",
    "showid": "20230402", // 2023-4-2 AM 2:02
    "description": "暂无",
    "sex": 1,
    "height": "181",
    "birthday": "1998-04-09",
    "weight": "80",
    "waistline": "80",
  };

  // 个人信息
  void getUInfo() async {
    try {
      Map res = await sign.getUInfo();
      print("data>>> ${res["code"]} ${res["data"]}");
      if (res["code"] == 200) {
        setState(() {
          uinfo = res["data"];
        });
        print(uinfo);
      }
      if (res['code'] == 401) {
        Navigator.pushNamed(context, 'phoneLog');
      }
    } catch (e) {
      print(e);
      errToast();
    }

  }
  // 更新用户信息
  void handleInfo() async{
    try {
      Map res = await sign.updateUInfo(uinfo);
      print("data>>> ${res["code"]} ${res["message"]}");
      if (res["code"] != 200) {
        toast("更新信息失败");
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }
  // 选择出生日期
  void changeBirth(BuildContext context) {
    Pickers.showDatePicker(context,
        mode: DateMode.YMD,
        pickerStyle: customPickStyle(),
        onConfirm: (params) {
          // 月数补零
          final month = params.month! < 10 ? "0${params.month}" : params.month;
          // 天数补零
          final day = params.day! < 10 ? "0${params.day}" : params.day;
          uinfo["birthday"] = "${params.year}-${month}-${day}";
          setState(() {});
          handleInfo();
        },
        onChanged: (val) => print('选择的出生日期为：$val'));
  }

  // 重写 showModalBottomSheet 布局样式
  Widget CustomBottomSheet(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                width: double.infinity,
                alignment: Alignment(0, 0),
                height: 130 / 2 - 4,
                child:
                    InkWell(child: Text("拍照", style: TextStyle(fontSize: 18))),
              ),
              onTap: () async {
                // try {
                //   final XFile? imgFile = await imgPicker.pickImage(
                //       source: ImageSource.camera);
                //   if (imgFile != null) {
                //     print("拍摄图片>> ${imgFile.path}");
                //     File file = File(imgFile.path);
                //     final imageBytes = await file.readAsBytes();
                //     String base64Img = base64Encode(imageBytes);
                //     setState(() {
                //       headimg = base64Img;
                //     });
                //     Navigator.pop(context); // 用于底部弹框关闭
                //     print("图片base64 >> $base64Img");
                //   }
                // } catch (e) {
                //   print("异常>> $e");
                // }
              },
            ),
            InkWell(
              child: Container(
                width: double.infinity,
                alignment: Alignment(0, 0),
                height: 55,
                child: Text(
                  "选取相册照片",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              onTap: () async {
                // final XFile? imgFile = await imgPicker.pickImage(source: ImageSource.gallery);
                // if (imgFile != null) {
                //   print("选择图片>> ${imgFile.path}");
                //   File file = File(imgFile.path);
                //   final imageBytes = await file.readAsBytes();
                //   String base64Img = base64Encode(imageBytes);
                //   setState(() {
                //     headimg = base64Img;
                //   });
                //   Navigator.pop(context); // 用于底部弹框关闭
                //   print("图片base64 >> $base64Img");
                // }
              },
            ),
          ],
        ));
  }

  // 头像
  void onHeadImg(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false, // 是否滚动
        backgroundColor: Colors.transparent, // 透明是为了自定义样式，例如圆角等
        builder: (context) {
          return CustomBottomSheet(context);
        });
  }

  // 个人简介
  void toPage(String path) {
    Navigator.pushNamed(context, path);
  }
  // 图片加载失败 【待定】
  Widget initImage(){
    Image images;
    images = Image.network(
      "http://192.168.2.102:801/avator/sunset202303311711.png",
      width: 36,
      height: 36);
    var resolve = images.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_,__){

    },onError: (e,s){
      print("失败");
      setState(() {
        images = Image.asset(
          "assets/images/3044.jpg",
          width: 36,
          height: 36,
        );
      });
    }));
    return images;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title: "个人信息", bgColor: null, fontColor: null),
          Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: MediaQuery.removePadding(
                      // 去除顶部留白
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: ListView(
                          padding: EdgeInsets.only(bottom: 40),
                          physics: BouncingScrollPhysics(), // IOS的回弹属性
                          children: [
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("头像", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(36),
                                    child:
                                    headimg == ""
                                        ? Image.network(
                                        baseUrl + uinfo["avator"],
                                            width: 36,
                                            height: 36)
                                        : Image.memory(base64.decode(headimg),
                                            width: 36, height: 36),
                                  ),
                                  onTap: () => onHeadImg(context),
                                ),
                                SizedBox(width: 15),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("ID", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                Text(uinfo["showid"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffb4b4b4))),
                                SizedBox(width: 10)
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("昵称", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                    child: Text(uinfo["nickname"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    onTap: () {}),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("个人简介", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkResponse(
                                    // 取消点击水波纹使用 InkResponse
                                    highlightColor: Colors.transparent,
                                    radius: 0.0,
                                    child: Text(uinfo["description"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffb3b3b3))),
                                    onTap: () => toPage("myProfile")),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Color(0xfff2f2f2)))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("性别", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                Row(
                                    children: sexList
                                        .asMap()
                                        .entries
                                        .map<Widget>((enry) {
                                  int index = enry.key;
                                  String item = enry.value;
                                  return InkWell(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 26, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Color(uinfo["sex"] == index
                                              ? 0xff22d47e
                                              : 0xffe8e8f2),
                                          borderRadius: index == 0
                                              ? BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(30))
                                              : BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30)),
                                        ),
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Color(uinfo["sex"] == index
                                                  ? 0xffffffff
                                                  : 0xff747474)),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          uinfo["sex"] = index;
                                        });
                                        handleInfo();
                                      });
                                }).toList())
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("身高", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                    child: Text(uinfo["height"] + ".CM",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffb3b3b3))),
                                    onTap: () {
                                      Pickers.showSinglePicker(context,
                                          data: stature,
                                          pickerStyle: customPickStyle(),
                                          selectData:
                                              int.parse(uinfo["height"]),
                                          onConfirm: (val, i) {
                                            setState(() {
                                              uinfo["height"] = val.toString();
                                            });
                                            handleInfo();
                                          },
                                          onChanged: (val, i) =>
                                              print('选择的身高为：$val'));
                                    }),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("生日", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                    child: Text(uinfo["birthday"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffb3b3b3))),
                                    onTap: () => changeBirth(context)),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("体重", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                    child: Text(uinfo["weight"] + "公斤",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffb3b3b3))),
                                    onTap: () {
                                      Pickers.showSinglePicker(context,
                                          data: weight,
                                          pickerStyle: customPickStyle(),
                                          selectData:
                                              double.parse(uinfo["weight"]),
                                          onConfirm: (val, i) {
                                            setState(() {
                                              uinfo["weight"] = val.toString();
                                            });
                                            handleInfo();
                                          },
                                          onChanged: (val, i) =>
                                              print('选择的体重为：$val'));
                                    }),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("腰围", style: TextStyle(fontSize: 17)),
                                Spacer(flex: 1),
                                InkWell(
                                    child: Text(uinfo["waistline"] + ".0CM",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffb3b3b3))),
                                    onTap: () {
                                      Pickers.showSinglePicker(context,
                                          data: waistLine,
                                          pickerStyle: customPickStyle(),
                                          selectData:
                                              int.parse(uinfo["waistline"]),
                                          onConfirm: (val, i) {
                                            setState(() {
                                              uinfo["waistline"] =
                                                  val.toString();
                                            });
                                            handleInfo();
                                          },
                                          onChanged: (val, i) =>
                                              print('选择的腰围为：$val'));
                                    }),
                                SizedBox(width: 5),
                                Icon(IconData(0xeb8a, fontFamily: "sunfont"),
                                    size: 13, color: Color(0xffbababa))
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Color(0xfff8f8fa),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                  "性别、年龄、身高、体重、腰围信息将影响日常活动、体脂数据的准确性。请准确填写以上个人资料，以获取更精准的健康数据",
                                  style: TextStyle(
                                      height: 1.5,
                                      fontSize: 12,
                                      color: Color(0xff6d6d6d))),
                            )
                          ])))),
        ],
      ),
    );
  }
}
