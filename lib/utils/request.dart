import 'package:dio/dio.dart';

String baseUrl = "";

class Http {
  late Dio dio;
  late BaseOptions options;

  Future<Dio> createInstace() async {
    options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 1000,
      responseType: ResponseType.json,
    );
    dio = Dio(options);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("开始请求");
    }, onResponse: (Response response) {
      print("请求成功");
    }, onError: (DioError e) {
      print("失败");
    }));
    return dio;
  }

  get(url, {data, opt, token}) async {
    Dio dios = await createInstace();
    Response response = await dios.get(url);
  }

  post(url, {data, opt, token}) async {
    Dio dios = await createInstace();
    Response response = await dios.get(url);
  }
}
