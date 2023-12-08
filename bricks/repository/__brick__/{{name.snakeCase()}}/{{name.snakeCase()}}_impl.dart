import 'package:injectable/injectable.dart';


@LazySingleton(as: {{name.camelCase()}}Repository)
class {{name.camelCase()}}RepositoryImpl extends {{name.camelCase()}}Repository {}