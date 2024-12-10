import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part '{{name.snakeCase()}}_service.g.dart';
/*
  @lazySingleton
  {{name.pascalCase()}}Service get {{name.snakeCase()}}Service => {{name.pascalCase()}}Service(injectRetrofitAPI);
*/
@RestApi()
abstract class {{name.pascalCase()}}Service {
  factory {{name.pascalCase()}}Service(Dio dio, {String baseUrl}) = _{{name.pascalCase()}}Service;
}
