import 'package:sunset/utils/request.dart';

Http http = new Http();

class KnowReq {
  // 知识精选
  Future<Map> getKnow(params) async {
    Map<String, dynamic> data = params;
    return await http.get(
        "/know/list", data);
  }
  // 文章详情
  Future<Map> getKnowDetail(params) async {
    Map<String, dynamic> data = params;
    return await http.get(
        "/know/detail", data);
  }
  // 收藏文章
  Future<Map> likeKnow(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/know/like", data);
  }
  // 我的收藏
  Future<Map> getMyLike(params) async {
    Map<String, dynamic> data = params;
    return await http.get(
        "/know/my_like", data);
  }
}
