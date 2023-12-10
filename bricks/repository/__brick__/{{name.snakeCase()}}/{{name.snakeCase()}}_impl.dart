import 'package:injectable/injectable.dart';


@LazySingleton(as: {{name.pascalCase()}}Repository)
class {{name.pascalCase()}}RepositoryImpl extends {{name.pascalCase()}}Repository {}