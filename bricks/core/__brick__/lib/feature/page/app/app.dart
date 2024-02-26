import '../../../core/base/base_widget.dart';
import '../../../core/res/theme.dart';
import './app_vm.dart';
import '../../router/app_router.dart';
import '../../router/app_router.routes.dart';
import '../../../core//siren/siren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

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
        builder: (context, child) {
          if (viewModel.sirenType == SirenType.force) {
            return ForceUpdatePage(update: () {
              if (Platform.isIOS) {
                launchUrl(Uri.parse(
                    "https://apps.apple.com/tr/app/{appname}/{appId}"));
              }

              if (Platform.isAndroid) {
                launchUrl(Uri.parse(
                    "https://play.google.com/store/apps/details?id=${viewModel.packageName}"));
              }
            });
          }
          return GestureDetector(
            child: child ?? Container(),
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          );
        },
        supportedLocales: AppLocalizations.supportedLocales);
  }
}
