import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';
@RouteMap()
class {{name.camelCase()}}Page extends StatefulWidget {
  const {{name.camelCase()}}Page({ Key? key }) : super(key: key);
  @override
  State<{{name.camelCase()}}Page> createState() => _{{name.camelCase()}}PageState();
}
class _{{name.camelCase()}}PageState extends BaseState<{{name.camelCase()ViewModel}},{{name.camelCase()}}Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:const Text('{{name.camelCase()}}Page'),),);
  }
}