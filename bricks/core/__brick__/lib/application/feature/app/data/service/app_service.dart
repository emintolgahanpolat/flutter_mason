import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part '../../../../../feature/data/service/app_service.g.dart';

/*
  @Environment(Environment.prod)
  @lazySingleton
  AppService get appService => AppService(injectRetrofitAPI);

  @Environment(Environment.dev)
  @lazySingleton
  AppService get appServiceMock => MockAppService();

*/
@RestApi()
abstract class AppService {
  factory AppService(Dio dio, {String baseUrl}) = _AppService;

  @GET("/app/version")
  Future<String> getAppVersion();
}
