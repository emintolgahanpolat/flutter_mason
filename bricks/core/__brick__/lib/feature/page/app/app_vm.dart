import '../../../core/base/base_view_model.dart';
import '../../../core/source/local_data_source.dart';
import '../../../core/logger.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppViewModel extends BaseViewModel {
  final LocalDataSource _localDataSource;
  AppViewModel(this._localDataSource);

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

  final ValueNotifier<int> counter = ValueNotifier(0);
}
