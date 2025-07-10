import '../../../core/base/base_widget.dart';
import 'home_vm.dart';
import 'package:go_router/go_router.dart';
import '../../../core/res/icons.dart';
import '../../../core/res/l10n/l10n.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomeViewModel, HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.home),
        actions: [
          IconButton(
            onPressed: () {
              context.push("/settings");
            },
            icon: const Icon(AppIcons.settings),
          ),
        ],
      ),
    );
  }
}
