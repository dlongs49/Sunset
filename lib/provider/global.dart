import 'package:flutter/cupertino.dart';
import 'package:sunset/utils/tools.dart';
class Global with ChangeNotifier{
  int color = 0xff22d47e;
  // 设置主题
  void handleTheme(int data) {
    color = data;
    notifyListeners();
  }
  // 缓存中的主题
  void getTheme() async{
    int skin_color = await getStorage("skin");
    color = skin_color != null ? skin_color : 0xff22d47e;
  }
}