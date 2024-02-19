import 'package:flutter/material.dart';
import 'package:payoda/pref/pref_service.dart';
import 'package:payoda/router/app_router.dart';

class Constants {
  static late SharedPreferencesService prefsService;
  static double height = MediaQuery.sizeOf(AppRouter.navigatorKey.currentState!.context).height;
  static double width = MediaQuery.sizeOf(AppRouter.navigatorKey.currentState!.context).width;
}
