import 'package:dio/dio.dart';
import '../../constants/global.dart';

class DioUtil {
  late Dio _instance;

  Dio getInstance() {
    _instance = createDioInstance();
    return _instance;
  }

  Dio createDioInstance() {
    BaseOptions options = BaseOptions(
        baseUrl: apiPath,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(milliseconds: 15 * 1000), // 15 seconds
        receiveTimeout: const Duration(milliseconds: 15 * 1000), // 15 seconds
    );
    var dio = Dio(options);
    dio.interceptors.clear();
    return dio;
  }
}
