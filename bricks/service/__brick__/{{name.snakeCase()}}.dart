import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

@RestApi()
abstract class {{name.camelCase()}}Service {
  factory {{name.camelCase()}}Service(Dio dio, {String baseUrl}) = _{{name.camelCase()}}Service;
}
