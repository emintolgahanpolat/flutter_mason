import 'package:injectable/injectable.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

@module
abstract class AppModule {
  @Environment(Environment.dev)
  @Environment(Environment.prod)
  @preResolve
  @Singleton(order: -99)
  Future<SharedPreferences> get localDataSource =>
      SharedPreferences.getInstance();

  @Environment(Environment.test)
  @preResolve
  Future<SharedPreferences> get localDataSourceTest async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    return SharedPreferences.getInstance();
  }

  @Environment(Environment.dev)
  @Environment(Environment.prod)
  @preResolve
  Future<PackageInfo> get info => PackageInfo.fromPlatform();

  @Environment(Environment.dev)
  @Environment(Environment.prod)
  Connectivity get connectivity => Connectivity();

  @Environment(Environment.dev)
  @Environment(Environment.prod)
  DeviceInfoPlugin get deviceInfo => DeviceInfoPlugin();
}
