import 'package:flutter/material.dart';

abstract class SubRouter {
  String get moduleName;

  Widget router(RouteSettings settings);
}
