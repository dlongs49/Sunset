import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blue_elves/flutter_blue_elves.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  void initState() {
    super.initState();
    initBlue();
  }

  void initBlue() {
    FlutterBlueElves.instance.startScan(1000).listen((scanItem) {
      print(">>>${scanItem.id}--${scanItem.name}");
      if (scanItem.id == "D7:AF:73:3B:A2:55") { // 10:96:1A:6C:B6:50
        Device device = scanItem.connect(connectTimeout: 5000);
        device.stateStream.listen((state) {
          print("连接状态>>>>${state}");
          if(state == DeviceState.connected){
            FlutterBlueElves.instance.stopScan();
            device.serviceDiscoveryStream.listen((serviceItem) {
              if (serviceItem.serviceUuid == "89315c8f-8dae-4746-a270-1954dfcb6108") {
                // device.setNotify(serviceItem.serviceUuid, Global.CHARTIDS, true);
              }
            });
            device.deviceSignalResultStream.listen((result) {
              print("数据>>$result");
            });
          }
        }).onDone(() {
          print("连接异常");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}
