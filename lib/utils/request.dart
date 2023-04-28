import 'package:dio/dio.dart';
import 'package:sunset/utils/tools.dart';
// 接口地址
String baseUrl = "http://sunset-server.dillonl.com";

class Http {
  late Dio dio;
  late BaseOptions options;

  Future<Dio> createInstace(String method) async {
    options = new BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 6000,
      responseType: ResponseType.json,
      method: method,
    );
    dio = new Dio(options);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // 从缓存中取 token
      String ms_token  = await getStorage("ms_token");
      // 赋值请求头
      options.headers["ms_token"] = ms_token;
      return handler.next(options);
    }, onResponse: (response, handler) async {
      int code = response.data['code'];
      String role = await getStorage("role");
      if (code == 401 && role == null) {
        await clearStorage();
      }
      return handler.next(response);
    }, onError: (DioError e, handler) {
      print("<<响应失败>>");
      return handler.next(e);
    }));
    return dio;
  }

  // GET 请求
  get(url, data) async {
    Map<String, dynamic> map = data;
    Dio dios = await createInstace("GET");
    Response response = await dios.get(url, queryParameters: map);
    return response.data;
  }

  // POST 请求
  post(url, data) async {
    Map<String, dynamic> map = data;
    Dio dios = await createInstace("POST");
    Response response = await dios.post(url, data: map, queryParameters: map);
    return response.data;
  }

  // 图片上传接口
  uploadPost(url, data) async {
    Dio dios = await createInstace("POST");
    Response response = await dios.post(url, data: data);
    return response.data;
  }
}
