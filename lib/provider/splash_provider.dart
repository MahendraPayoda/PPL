import 'package:flutter/material.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/router/routes.dart';
import 'package:payoda/utills/constant.dart';

class SplashProvider extends ChangeNotifier {
  SplashProvider() {
    if (Constants.prefsService.getString('token') == null) {
      Future.delayed(const Duration(seconds: 3), () => AppRouter.navigatePushReplacementTo(AppRoutes.loginRoute));
    } else {
      Future.delayed(const Duration(seconds: 3), () => AppRouter.navigatePushReplacementTo(AppRoutes.dashboardRoute));
    }
  }
}
