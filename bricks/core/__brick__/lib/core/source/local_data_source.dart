import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Locale? get locale;
  String get languageCode;
  Future setLocale(Locale locale);

  ThemeMode get appearance;
  Future setAppearance(ThemeMode themeMode);
  Future<void> clear();
}

@Singleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences _getStorage;
  LocalDataSourceImpl(this._getStorage);

  @override
  Future<void> clear() async {
    return;
  }

  @override
  ThemeMode get appearance =>
      ThemeMode.values[_getStorage.getInt("appearance") ?? 0];

  @override
  Future setAppearance(ThemeMode themeMode) {
    return _getStorage.setInt("appearance", themeMode.index);
  }

  @override
  Locale? get locale => _getStorage.getString("locale") == null
      ? null
      : Locale(_getStorage.getString("locale")!);

  @override
  Future setLocale(Locale locale) {
    return _getStorage.setString("locale", locale.languageCode);
  }

  @override
  String get languageCode => locale?.languageCode ?? "en";
}
