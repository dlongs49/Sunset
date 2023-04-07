import 'package:sunset/utils/request.dart';

Http http = new Http();

class TrendsReq {
  // 发表动态
  Future<Map> publishTrends(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/trends/pub_trends", data);
  }
  // 动态列表 & 用户的动态列表
  Future<Map> getTrends(params) async {
    Map<String, dynamic> data = params;
    return await http.get(
        "/trends/get/list", data);
  }
}
