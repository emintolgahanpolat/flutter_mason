import 'package:injectable/injectable.dart';

class AppConfig {
  static const String baseUrl = String.fromEnvironment('BASE_URL');
}
