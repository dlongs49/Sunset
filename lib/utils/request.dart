import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "http://192.168.2.102:801";
// String baseUrl = "http://192.168.0.152:801";

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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? ms_token = prefs.getString("ms_token");
      print("[ms_token]>>>$ms_token");
      // 赋值请求头
      // options.headers["ms_token"] = ms_token;
      // options.headers["ms_token"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiI4NDU0MTJGRi1DREVGLTQxNTgtODIyMS1CRjM5NkYwQzQwNEIiLCJzdGFtcCI6MTY4MTMwMzYzODI4NSwiZXhwIjoxNjgxNTE5NjM4fQ.joPKBfbDeFzvPK85LkqvVr1fxXad32pycvFFMv50II0";
      options.headers["ms_token"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiI4MjgxNjExRi00RkEwLTQyMzgtQkFCRC03MUY0NkVCMjVCODgiLCJzdGFtcCI6MTY4MTgyMzUxMjkxNCwiZXhwIjoxNjgyMDM5NTEyfQ.3fbldW5LEzc3fh9mYojXLCmURyGs8_72jsKwC2n1oI8";
      print("开始请求：${options.baseUrl}");
      return handler.next(options);
    }, onResponse: (response, handler) async {
      int code = response.data['code'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (code == 401) {
        await prefs.remove("ms_token");
      }

      print("请求成功>> ${response.data["code"]}");
      return handler.next(response);
    }, onError: (DioError e, handler) {
      print("请求失败>> $e");
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
    Response response = await dios.post(url, data: map,queryParameters:map);
    return response.data;
  }
  // 图片上传接口
  uploadPost(url, data) async {
    Dio dios = await createInstace("POST");
    Response response = await dios.post(url, data: data);
    return response.data;
  }
}
