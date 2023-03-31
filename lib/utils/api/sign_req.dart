import 'package:dio/dio.dart';
import 'package:sunset/utils/request.dart';

Http http = new Http();

class Sign {
  Future<Map> codeLogin(params) async {
    Map<String, String> data = params;
    return await http.post("/sign/code_login", data);
  }
}
