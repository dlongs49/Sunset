
import 'package:sunset/utils/request.dart';

Http http = new Http();
class UploadReq{
  // 上传头像
  Future<Map> uploadAvator(params) async {
    return await http.uploadPost("/upload/avator", params);
  }
}