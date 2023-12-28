import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';


/*
  @Environment(Environment.prod)
  @lazySingleton
  AuthService get authService => AuthService(injectRetrofitAPI);

  @Environment(Environment.dev)
  @lazySingleton
  AuthService get authServiceMock => MockAuthService();

*/
@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;
}
