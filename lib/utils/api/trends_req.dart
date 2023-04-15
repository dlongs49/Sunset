import 'package:sunset/utils/request.dart';

Http http = new Http();

class TrendsReq {
  // 发表动态
  Future<Map> publishTrends(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/trends/pub_trends", data);
  }
  // 删除动态
  Future<Map> delTrends(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/trends/del_trends", data);
  }
  // 动态列表 & 用户的动态列表
  Future<Map> getTrends(params) async {
    Map<String, dynamic> data = params;
    return await http.get(
        "/trends/get/list", data);
  }
  // 动态详情
  Future<Map> getTrendsDetail(params) async {
    Map<String, dynamic> data = params;
    return await http.get(
        "/trends/get/detail", data);
  }
  // 粉丝，关注，获赞
  Future<Map> getFollow(params) async {
    Map<String, dynamic> data = params;
    return await http.get(
        "/trends/user/follow", data);
  }
  // 发送评论
  Future<Map> pubComment(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/trends/pub/comment", data);
  }
  // 删除评论
  Future<Map> delComment(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/trends/del/comment", data);
  }
  // 获取评论列表
  Future<Map> getComment(params) async {
    Map<String, dynamic> data = params;
    return await http.get(
        "/trends/get/comment", data);
  }
  // 动态文章点赞
  Future<Map> setTrendsStar(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/trends/set_star", data);
  }
  // 评论点赞
  Future<Map> setCommentStar(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/trends/comment/set_star", data);
  }
  // 关注
  Future<Map> setFollow(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/trends/follow/set", data);
  }
  // 关注列表
  Future<Map> getFollowList(params) async {
    Map<String, dynamic> data = params;
    return await http.post(
        "/trends/follow/list", data);
  }
}
