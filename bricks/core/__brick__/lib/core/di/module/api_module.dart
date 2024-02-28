import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../interceptor/error_interceptor.dart';
import '../../interceptor/log_interceptor.dart';
import '../../../feature/data/service/app_service.dart';
import '../../../feature/data/service/mock_app_service.dart';

@module
abstract class ApiModule {
  @Order(-1)
  @lazySingleton
  Dio get injectRetrofitAPI {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://api.example.com/",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "accept": "*/*",
        },
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
        sendTimeout: const Duration(minutes: 1),
      ),
    );

    // dio.interceptors.add(CertificatePinningInterceptor2(
    //     allowedSHAFingerprints: [
    //       getIt<AppConfig>().certificateFingerprintSHA256
    //     ]));

    dio.interceptors.add(ErrorInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(LoggerInterceptor());
    }
    return dio;
  }

  @Environment(Environment.prod)
  @lazySingleton
  AppService get appService => AppService(injectRetrofitAPI);

  @Environment(Environment.dev)
  @lazySingleton
  AppService get appServiceMock => MockAppService();
}
