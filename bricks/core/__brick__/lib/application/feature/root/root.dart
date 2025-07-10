import '../../../core/base/base_widget.dart';
import '../../../core/res/l10n/l10n.dart';
import '../../router/app_router.dart';
import '../../../core/extension/screen_ex.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const RootPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (!context.isCompact)
            NavigationRail(
              labelType: context.isExpanded
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              extended: context.isExpanded,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.home),
                  label: Text(context.l10n.home),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings),
                  label: Text(context.l10n.settings),
                ),
              ],
            ),
          if (!context.isCompact) const VerticalDivider(),
          Expanded(child: SafeArea(child: navigationShell)),
        ],
      ),
      bottomNavigationBar: context.isCompact
          ? BottomNavigationBar(
              currentIndex: navigationShell.currentIndex > 3
                  ? 3
                  : navigationShell.currentIndex,
              onTap: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: context.l10n.home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: context.l10n.settings,
                ),
              ],
            )
          : null,
    );
  }
}
