import '../../../core/base/base_view_model.dart';
import '../../../core/source/local_data_source.dart';
import '../../../core/logger.dart';
import '../../../core/siren/siren/siren.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@singleton
class AppViewModel extends BaseViewModel {
  final PackageInfo _packageInfo;
  final LocalDataSource _localDataSource;
  AppViewModel(this._localDataSource, this._packageInfo) {
    checkForUpdate();
  }

  Locale? get locale => _localDataSource.locale;
  Future setLocale(Locale locale) =>
      _localDataSource.setLocale(locale).then((value) {
        notifyListeners();
      });

  bool get isDarkMode => _localDataSource.isDark;
  Future setDarkMode(bool isDark) =>
      _localDataSource.setIsDark(isDark).then((value) {
        Log.i("$isDark", tag: "Changed Theme");
        notifyListeners();
      });
  SirenType sirenType = SirenType.none;
  String get packageName => _packageInfo.packageName;
  void checkForUpdate() {
    Siren()
      ..majorUpdateAlertType = SirenType.force
      ..minorUpdateAlertType = SirenType.option
      ..patchUpdateAlertType = SirenType.skip
      ..checkVersionName(
          //  TODO : Add your app's min version
          minVersion: "1.0.0",
          currentVersion: _packageInfo.version,
          onDetectNewVersion: (version, type) {
            sirenType = type;
            notifyListeners();
          });
  }
}
