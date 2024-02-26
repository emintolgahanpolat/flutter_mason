import '../../../core/base/base_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingsViewModel extends BaseViewModel {
  final PackageInfo _packageInfo;
  SettingsViewModel(this._packageInfo);

  String getAppVersion() {
    return "${_packageInfo.version} (${_packageInfo.buildNumber})";
  }
}
