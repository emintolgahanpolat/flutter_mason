import 'dart:ui';

import './app_storage.dart';
import 'package:injectable/injectable.dart';

abstract class LocalDataSource {
  Locale get locale;
  Future setLocale(Locale locale);

  bool get isDark;
  Future setIsDark(bool flag);
  Future<void> clear();

  String? get email;
  Future setEmail(String? email);
}

@Environment(Environment.prod)
@Environment(Environment.dev)
@Singleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  final AppStorage _getStorage;
  LocalDataSourceImpl(this._getStorage);

  @override
  Future<void> clear() async {
    return;
  }

  @override
  bool get isDark => _getStorage.read<bool>("isDark") == true;

  @override
  Future setIsDark(bool flag) {
    return _getStorage.write("isDark", flag);
  }

  @override
  String? get email => _getStorage.read("email");

  @override
  Future setEmail(String? email) {
    return _getStorage.write("email", email);
  }

  @override
  Locale get locale => Locale(_getStorage.read<String>("locale") ?? "en");

  @override
  Future setLocale(Locale locale) {
    return _getStorage.write("locale", locale);
  }
}

@Environment(Environment.test)
@Singleton(as: LocalDataSource)
class TestLocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> clear() async {
    return;
  }

  bool _isDark = false;
  @override
  bool get isDark => _isDark;

  @override
  Future setIsDark(bool flag) async {
    _isDark = flag;
  }

  String? _email;
  @override
  String? get email => _email;

  @override
  Future setEmail(String? email) async {
    _email = email;
    return;
  }

  Locale _locale = const Locale("en");
  @override
  Locale get locale => _locale;

  @override
  Future setLocale(Locale locale) async {
    _locale = locale;
    return;
  }
}
