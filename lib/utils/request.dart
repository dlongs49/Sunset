import 'package:dio/dio.dart';

String baseUrl = "http://192.168.2.102:801";

class Http {
  late Dio dio;
  late BaseOptions options;

  Future<Dio> createInstace(String method) async {
    options = new BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      responseType: ResponseType.json,
      method: method,
    );
    dio = new Dio(options);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // options.headers["ms_token"] =
      // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiJDOEZDMjY2Mi04QzM1LTQwNUMtQTY0NC1CNzExM0UwMTQxODciLCJzdGFtcCI6MTY4MDI3MTg5ODkwNywiZXhwIjoxNjgwNDg3ODk4fQ.MlyKrVqSjBBiPM1oTTGm-JmDtcs-EFfoUi2pRI_HG1A";
      print("开始请求：${options.baseUrl}");
      return options;
    }, onResponse: (Response response) {
      print("请求成功");
      return response;
    }, onError: (DioError e) {
      print("请求失败>> $e");
    }));
    return dio;
  }

  get(url, data) async {
    Map<String, dynamic> map = data;
    Dio dios = await createInstace("GET");
    return await dios.get(url, queryParameters: map);
  }

  post(url, data) async {
    Map<String, dynamic> map = data;
    Dio dios = await createInstace("POST");
    return await dios.post(url,data:map);
  }
}
