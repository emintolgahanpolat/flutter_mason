import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

Future<void> bootstrap(
    {required Widget Function() builder, required String environment}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  await setupDI(environment);
  runApp(builder());
}
