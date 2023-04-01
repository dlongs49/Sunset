import 'package:dio/dio.dart';
import 'package:sunset/utils/request.dart';

Http http = new Http();

class Sign {
  // 验证码登录 & 注册
  Future<Map> codeLogin(params) async {
    Map<String, String> data = params;
    return await http.post("/sign/code_login", data);
  }

  // 密码登录
  Future<Map> pwdLogin(params) async {
    Map<String, String> data = params;
    return await http.post("/sign/pwd_login", data);
  }
}
