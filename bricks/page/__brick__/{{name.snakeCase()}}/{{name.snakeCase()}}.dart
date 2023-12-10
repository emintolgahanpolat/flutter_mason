import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';
@RouteMap()
class {{name.pascalCase()}}Page extends StatefulWidget {
  const {{name.pascalCase()}}Page({ Key? key }) : super(key: key);
  @override
  State<{{name.pascalCase()}}Page> createState() => _{{name.pascalCase()}}PageState();
}
class _{{name.pascalCase()}}PageState extends BaseState<{{name.pascalCase()}}ViewModel,{{name.pascalCase()}}Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:const Text('{{name.pascalCase()}}Page'),),);
  }
}