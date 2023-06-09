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

  // 忘记密码 -- 查询手机号
  Future<Map> findPhone(params) async {
    Map<String, String> data = params;
    return await http.post("/sign/get_isPhone", data);
  }
  // 忘记密码 -- 重置密码
  Future<Map> forgetPwd(params) async {
    Map<String, String> data = params;
    return await http.post("/sign/reset_pwd", data);
  }
  // 设置密码
  Future<Map> setPwd(params) async {
    Map<String, String> data = params;
    return await http.post("/sign/set_pwd", data);
  }
  // 换绑手机号
  Future<Map> changePhone(params) async {
    return await http.post("/sign/change_phone", params);
  }
  // 个人信息
  Future<Map> getUInfo() async {
    return await http.get("/sign/get/userinfo", null);
  }
  // 更新个人信息
  Future<Map> updateUInfo(params) async {
    Map<String, dynamic> data = params;
    return await http.post("/sign/update/userinfo", data);
  }
  // 注销账号
  Future<Map> distryUInfo() async {
    DateTime currentTime = DateTime.now();
    return await http.post("/sign/distry_info", {"stamp": currentTime.microsecondsSinceEpoch});
  }
}
