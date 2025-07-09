import '../../../core/base/base_view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

@injectable
class SettingsViewModel extends BaseViewModel {
  final PackageInfo _packageInfo;

  final DeviceInfoPlugin _deviceInfo;
  SettingsViewModel(this._packageInfo, this._deviceInfo);

  String get appVersion =>
      "${_packageInfo.version} (${_packageInfo.buildNumber})";
  String get appName => _packageInfo.appName;

  Future<int> get sdk async => (await _deviceInfo.androidInfo).version.sdkInt;
}
