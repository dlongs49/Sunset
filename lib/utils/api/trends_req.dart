import 'package:sunset/utils/request.dart';

Http http = new Http();

class TrendsReq {
  // 发表动态
  Future<Map> publishTrends(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/trends/pub_trends", data);
  }

}
