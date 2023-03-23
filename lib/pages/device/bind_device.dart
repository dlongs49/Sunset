import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:sunset/components/tabbar.dart';

class BindDevice extends StatefulWidget {
  const BindDevice({Key? key}) : super(key: key);

  @override
  _BindDeviceState createState() => _BindDeviceState();
}

class _BindDeviceState extends State<BindDevice> with TickerProviderStateMixin {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  String Id = '123';

  @override
  void initState() {}

  void openBlue() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    var device;
    var ss = flutterBlue.scanResults.listen((results) async {
      for (ScanResult r in results) {
        device = r.device;
        setState(() {
          Id = r.device.name;
        });
        // Bb-AM-D6-0  10:96:1A:6C:B6:50
        print('设备>>>>${r.device}');
        // if(r.device.name == "AIMA-06639D"){
        //   print('开始连接');
        //   await device.connect();
        //   print('连接成功');
        // }
      }
    });

    // List<BluetoothService> services = await device.discoverServices();
    // services.forEach((service) {
    //   print('SERVICE>> ${service}');
    // });
    // flutterBlue.stopScan();
  }

  late final AnimationController controllAnimate =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat(reverse: true);
  late final Animation<double> opAnimation =
      Tween<double>(begin: 0, end: 1).animate(controllAnimate);

  Widget initDevice() {
    return Column(
      children: [
        Align(
          child: Image.asset(
            "assets/images/3044.jpg",
            width: 60,
            height: 60,
          ),
        ),
        SizedBox(height: 20),
        Align(
          child: Text("冰消叶散",
              style: TextStyle(color: Color(0xffb8b8b8), fontSize: 12)),
        ),
        SizedBox(height: 40),
        Align(
          child: Text("打开蓝牙，保持网络畅通",
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 10),
        Align(
          child: Text("光脚站立在秤上",
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 40),
        Align(
          child: Stack(
            alignment: Alignment.center,
            children: [
              FadeTransition(
                  opacity: opAnimation,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Color(0xff22d47e),
                        borderRadius: BorderRadius.circular(200)),
                  )),
              Positioned(
                  child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    color: Color(0xff22d47e),
                    borderRadius: BorderRadius.circular(200)),
                child: Icon(IconData(0xe61c, fontFamily: 'sunfont'),
                    size: 45, color: Colors.white),
              )),
            ],
          ),
        )
      ],
    );
  }

  Widget notDevice() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          child: Text(
            "未发现设备",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        Align(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                border: Border.all(width: 3, color: Color(0xff22d47e))),
            child: Icon(IconData(0xe61c, fontFamily: 'sunfont'),
                size: 100, color: Color(0xff22d47e)),
          ),
        ),
        Column(
          children: [
            Align(
              child: Text("请确保设备电池电量充足并让靠近手机后重试",
                  style: TextStyle(color: Color(0xffc2c2c2), fontSize: 13)),
            ),
            SizedBox(height: 20),
            Align(
                child: InkWell(
                  child: Container(
                    alignment: Alignment(0, 0),
                    width: double.infinity,
                    height: 48,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xff22d47e),
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: Text("重新搜索",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                )),
            SizedBox(height: 20),
            Align(
              child: InkWell(
                  child: Text("重新搜索",
                      style: TextStyle(fontSize: 16, color: Color(0xff4c4c4c)))),
            )
          ],
        ),
        SizedBox(height: 0)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title: "请上秤", bgColor: null, fontColor: null),
          SizedBox(height: 80),
          Expanded(child: initDevice())
        ],
      ),
    );
  }
}
