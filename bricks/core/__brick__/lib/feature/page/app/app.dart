import '../../../core/base/base_widget.dart';
import '../../../core/res/theme.dart';
import './app_vm.dart';
import '../../router/app_router.dart';
import '../../router/app_router.routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends BaseState<AppViewModel, App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: LightTheme().theme(),
        darkTheme: DarkTheme().theme(),
        themeMode: viewModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        initialRoute: RouteMaps.root,
        onGenerateRoute: onGenerateRoute,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: viewModel.locale,
        supportedLocales: AppLocalizations.supportedLocales);
  }
}
