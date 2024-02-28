import '../../../core/base/base_widget.dart';
import '../../../core/di/locator.dart';
import '../../../core/res/icons.dart';
import '../../../core/res/l10n/l10n.dart';
import '../app/app_vm.dart';
import '../settings/settings_vm.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';
import 'package:app_settings/app_settings.dart';

@RouteMap(name: "settings")
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends BaseState<SettingsViewModel, SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            ListTile(
              onTap: () {
                AppSettings.openAppSettings(type: AppSettingsType.appLocale);
              },
              title: const Text("Localization"),
              trailing: const Icon(AppIcons.language),
            ),
            const Divider(),
            Consumer(
                viewModel: getIt<AppViewModel>(),
                builder: (context, vm) {
                  return ListTile(
                    onTap: () {
                      vm.setDarkMode(!vm.isDarkMode);
                    },
                    title: const Text("Dark Theme"),
                    trailing: Switch(
                        value: vm.isDarkMode,
                        onChanged: (v) {
                          vm.setDarkMode(v);
                        },
                        thumbIcon: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Icon(
                              AppIcons.darkMode,
                              color: Colors.white,
                            );
                          }
                          return const Icon(
                            AppIcons.lightMode,
                            color: Colors.white,
                          );
                        })),
                  );
                }),
            const Divider(),
            ListTile(
              title: const Text("App Version"),
              subtitle: Text(viewModel.appVersion),
            ),
            const Divider(),
            ListTile(
              title: const Text("Licenses"),
              trailing: const Icon(AppIcons.chevronRight),
              onTap: () {
                showLicensePage(
                    context: context,
                    useRootNavigator: true,
                    applicationName: viewModel.appName,
                    applicationVersion: viewModel.appVersion);
              },
            )
          ],
        ),
      ),
    );
  }
}
