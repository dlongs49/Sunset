import 'dart:convert';
import 'package:crypto/crypto.dart';
  // MD5 加密
  md5Tools(String data){
    var bytes = utf8.encode(data);
    var str = md5.convert(bytes);
    return str;
  }
