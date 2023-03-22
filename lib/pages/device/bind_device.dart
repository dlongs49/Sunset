import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BindDevice extends StatefulWidget {
  const BindDevice({Key? key}) : super(key: key);

  @override
  _BindDeviceState createState() => _BindDeviceState();
}

class _BindDeviceState extends State<BindDevice> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  String Id = '123';

  @override
  void initState() {}

  void openBlue()  {
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    var device;
    var ss = flutterBlue.scanResults.listen((results) async{
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

  @override
  Widget build(BuildContext context) {
    // CustomTabBar(title: "绑定设备", bgColor: null, fontColor: null),
    return Scaffold(
      body: InkWell(
          child: Container(
              margin: EdgeInsets.only(top: 40),
              width: 120,
              height: 120,
              color: Color(0xff2cdfef),
              child: Text(Id)),
          onTap: openBlue),
    );
  }
}
