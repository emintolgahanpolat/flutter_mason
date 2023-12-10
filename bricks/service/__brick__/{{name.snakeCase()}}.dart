import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

@RestApi()
abstract class {{name.pascalCase()}}Service {
  factory {{name.pascalCase()}}Service(Dio dio, {String baseUrl}) = _{{name.pascalCase()}}Service;
}
