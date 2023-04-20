import 'package:flutter/cupertino.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/home_req.dart';
import 'package:sunset/utils/api/sign_req.dart';
class Golbal with ChangeNotifier{
  HomeReq homeReq = new HomeReq();
  Sign sign = new Sign();
  Map uinfo = new Map();
  List knowList = [];
  // 个人信息
  void getUInfo() async {
    try {
      Map res = await sign.getUInfo();
      print("Gloabal-用户信息");
      if (res["code"] == 200) {
        uinfo = res["data"];
        // notifyListeners();

      }
    } catch (e) {
      print(e);
      errToast();
    }
  }
  void getKnow() async {
    try {
      Map res =
      await homeReq.getKnow({"page_num": 1, "page_rows": 7, "isimg": true});
      print("Global>>${res["data"]}");
      if (res["code"] == 200) {
        knowList = res["data"]["list"];
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }
}