import 'bootstrap.dart';
import 'application/feature/app/app.dart';
import 'package:injectable/injectable.dart';

void main() async {
  bootstrap(() => const App(), Environment.prod);
}
