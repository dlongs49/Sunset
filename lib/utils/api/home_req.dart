import 'package:sunset/utils/request.dart';

Http http = new Http();

class HomeReq {
// 轮播图
  Future<Map> getBanner() async {
    DateTime currentTime = DateTime.now();
    return await http.get(
        "/goods/get_banner", {"stamp": currentTime.microsecondsSinceEpoch});
  }
}
