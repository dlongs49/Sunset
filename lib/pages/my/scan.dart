import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  late QrReaderViewController QrController;
  // 相机权限申请
  void requestAllPermission() async {
    var status = await Permission.phone.status;
    print(">>状态 $status");
    var isGranted = await Permission.contacts.request().isGranted;
    if (isGranted) {
      print("没有权限申请许可");
    }
    // 用户拒绝权限申请，再次申请转至系统设置
    if (await Permission.speech.isPermanentlyDenied) {
      openAppSettings();
    }
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();
    QrController.startCamera(onScan);
  }


  @override
  void initState() {
    requestAllPermission();
  }

  void onScan(String val, List data) {
    print("扫一扫值：>>$val");
    print("list值：>>$data");
    Fluttertoast.showToast(
        msg: val,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color(0xd23b3b3b),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  bool isOpen = false;

  void toBack() {
    QrController.stopCamera();
    Navigator.pop(context);
  }

  void dispose() {
    QrController.stopCamera();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        QrReaderView(
          width: size.width,
          height: size.height,
          callback: (container) {
            QrController = container;
            QrController.startCamera(onScan);
          },
        ),
        Positioned(
            top: (size.height / 3) - 50,
            left: (size.width / 2) - 125,
            child: Container(
              constraints: BoxConstraints(maxWidth: 300, maxHeight: 300),
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white)),
            )),
        Positioned(
            top: 0,
            child: Container(
              width: size.width,
              height: size.height,
            )),
        // 上区域
        Positioned(
            top: 0,
            child: Container(
              width: size.width,
              height: size.height / 3 - 50,
              color: Color(0xA8000000),
            )),
        //左区域
        Positioned(
            top: size.height / 3 - 50,
            child: Container(
              width: (size.width - 250) / 2,
              height: 250,
              color: Color(0xA8000000),
            )),
        // 右区域
        Positioned(
            right: 0,
            top: size.height / 3 - 50,
            child: Container(
              width: (size.width - 250) / 2,
              height: 250,
              color: Color(0xA8000000),
            )),
        // 下区域
        Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: size.height - ((size.height / 3) - 50 + 250),
              color: Color(0xA8000000),
            )),
        Positioned(
            bottom: 50,
            left: size.width / 2 - 20,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Icon(isOpen ? Icons.flashlight_on : Icons.flashlight_off,
                    size: 35, color: Color(0xffffffff)),
              ),
              onTap: () {
                setState(() {
                  isOpen = !isOpen;
                });
                QrController.setFlashlight();
              },
            )),
        Positioned(
            right: 10,
            top: 50,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.cancel, size: 35, color: Color(0xffc9c9c9)),
              ),
              onTap: toBack,
            ))
      ],
    ));
  }
}
