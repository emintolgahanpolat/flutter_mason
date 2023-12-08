import 'package:{{name.snakeCase()}}/app_environment.dart';
import 'package:{{name.snakeCase()}}/bootstrap.dart';

void main() {
  bootstrap(builder: () => const App(), environment: AppEnvironment.prod);
}
