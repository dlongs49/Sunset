import 'package:flutter/cupertino.dart';
class Global with ChangeNotifier{
  int color = 0xff22d47e;
  // 主题
  void handleTheme(int data) {
    color = data;
    notifyListeners();
  }
}