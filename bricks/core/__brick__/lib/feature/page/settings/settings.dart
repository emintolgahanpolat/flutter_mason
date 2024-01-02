import '../../../core/base/base_widget.dart';
import '../../../core/di/locator.dart';
import '../../../core/res/icons.dart';
import '../../../core/res/l10n/l10n.dart';
import '../app/app_vm.dart';
import '../settings/settings_vm.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RouteMap()
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
        title: const Text('Settings '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            ListTile(
              onTap: () {
                showModalBottomSheet<Locale?>(
                    showDragHandle: true,
                    context: context,
                    useRootNavigator: true,
                    builder: (c) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: AppLocalizations.supportedLocales.length,
                        itemBuilder: (c, i) {
                          var item = AppLocalizations.supportedLocales[i];
                          return ListTile(
                            onTap: () {
                              Navigator.pop(c, item);
                            },
                            title: Text(item.fullName()),
                          );
                        })).then((value) {
                  if (value != null) {
                    getIt<AppViewModel>().setLocale(value);
                  }
                });
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
          ],
        ),
      ),
    );
  }
}
