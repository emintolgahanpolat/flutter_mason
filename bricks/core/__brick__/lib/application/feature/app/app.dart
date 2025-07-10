import 'dart:io';
import 'package:collection/collection.dart';
import '../../../core/base/base_widget.dart';
import '../../../core/res/l10n/app_localizations.dart';
import '../no_connectivity/no_connectivity.dart';
import 'app_vm.dart';
import '../../router/app_router.dart';
import '../../../core/res/theme/dark_theme.dart';
import '../../../core/res/theme/light_theme.dart';
import '../../../core/siren/siren.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends BaseState<AppViewModel, App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: LightTheme().theme(),
      darkTheme: DarkTheme().theme(),
      themeMode: viewModel.appearance,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      localeResolutionCallback: (locale, supportedLocales) {
        var mLocale = supportedLocales.firstWhereOrNull(
          (supportedLocale) =>
              supportedLocale.languageCode ==
              locale?.languageCode.split("_").firstOrNull,
        );
        if (mLocale != null) {
          viewModel.setLocale(mLocale);
          return mLocale;
        }
        return viewModel.locale ?? supportedLocales.first;
      },
      builder: (context, child) {
        if (viewModel.sirenType == SirenType.force) {
          return ForceUpdatePage(
            update: () {
              if (Platform.isIOS) {
                launchUrl(
                  Uri.parse("https://apps.apple.com/tr/app/{appname}/{appId}"),
                );
              }

              if (Platform.isAndroid) {
                launchUrl(
                  Uri.parse(
                    "https://play.google.com/store/apps/details?id=${viewModel.packageName}",
                  ),
                );
              }
            },
          );
        }
        return GestureDetector(
          child: Stack(
            children: [
              child!,
              if (!viewModel.isConnect) const NoConnectivityPage(),
            ],
          ),
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        );
      },
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
