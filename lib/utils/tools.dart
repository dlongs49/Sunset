import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

// MD5 加密
md5Tools(String data) {
  var bytes = utf8.encode(data);
  var str = md5.convert(bytes);
  return str;
}

// 设置缓存
setStorage(String key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final type = value.runtimeType.toString();
  switch (type) {
    case "String":
      prefs.setString(key, value);
      break;
    case "bool":
      prefs.setBool(key, value);
      break;
    case "int":
      prefs.setInt(key, value);
      break;
    case "List<String>":
      prefs.setStringList(key, value);
      break;
  }
}

// 获取缓存
getStorage(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var data = prefs.get(key);
  return data;
}

// 移除缓存
removeStorage(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

// 清除所有的缓存
clearStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
