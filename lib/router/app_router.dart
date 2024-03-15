import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payoda/model/team_list_response.dart';
import 'package:payoda/router/routes.dart';
import 'package:payoda/views/create_new_password_screen.dart';
import 'package:payoda/views/dashboard_screen.dart';
import 'package:payoda/views/engagement/create_engagement.dart';
import 'package:payoda/views/forgot_password_screen.dart';
import 'package:payoda/views/login_screen.dart';
import 'package:payoda/views/splash_screen.dart';
import 'package:payoda/views/successfull_screen.dart';
import 'package:payoda/views/teams/add_edit_member_screen.dart';
import 'package:payoda/views/teams/create_team_screen.dart';
import 'package:payoda/views/teams/team_detail_screen.dart';
import 'package:payoda/views/teams/upload_team_screen.dart';
import 'package:payoda/views/verification_code_screen.dart';

class AppRouter {
  AppRouter._();

  static final _instance = AppRouter._();

  factory AppRouter() => _instance;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashRoute:
        return getPageRoute(view: const SplashScreen(), settings: settings);
      case AppRoutes.loginRoute:
        return getPageRoute(view: const LoginScreen(), settings: settings);
      case AppRoutes.dashboardRoute:
        return getPageRoute(view: const DashboardScreen(), settings: settings);
      case AppRoutes.forgotPasswordRoute:
        return getPageRoute(view: const ForgotPasswordScreen(), settings: settings);
      case AppRoutes.verificationCodeRoute:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        final bool isFromForgotPassword = arguments['isFromForgotPassword'] as bool;
        final String email = arguments['email'] as String;
        return getPageRoute(
            view: VerificationCodeScreen(isFromForgotPassword: isFromForgotPassword, email: email),
            settings: settings);
      case AppRoutes.successRoute:
        return getPageRoute(view: const SuccessScreen(), settings: settings);
      case AppRoutes.createTeamRoute:
        return getPageRoute(view: const CreateTeamScreen(), settings: settings);
      case AppRoutes.teamDetailRoute:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        final List<Team>? team = arguments['team'] as List<Team>?;
        final int index = arguments['index'] as int;
        return getPageRoute(view: TeamDetailScreen(team: team, index: index), settings: settings);
      case AppRoutes.uploadTeamRoute:
        return getPageRoute(view: const UploadTeamScreen(), settings: settings);
      case AppRoutes.createPasswordRoute:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        final bool isFromForgotPassword = arguments['isFromForgotPassword'] as bool;
        final String email = arguments['email'] as String;
        return getPageRoute(
            view: CreateNewPasswordScreen(isFromForgotPassword: isFromForgotPassword, email: email),
            settings: settings);
      case AppRoutes.addEditTeamRoute:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        final List<Team>? team = arguments['team'] as List<Team>?;
        final int index = arguments['index'] as int;
        return getPageRoute(view: AddEditMemberScreen(team: team, index: index), settings: settings);
      case AppRoutes.createEngagementRoute:
        return getPageRoute(view: const CreateEngagementScreen(), settings: settings);
      default:
        return getPageRoute(
            view: Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))),
            settings: settings);
    }
  }

  static Route<dynamic> getPageRoute({required Widget view, required RouteSettings settings}) {
    return Platform.isIOS
        ? CupertinoPageRoute(builder: (_) => view, settings: settings)
        : MaterialPageRoute(builder: (_) => view, settings: settings);
  }

  static Future<void> navigateTo(String routeName, {dynamic arguments}) async {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static Future<void> navigatePushReplacementTo(String routeName, {dynamic arguments}) async {
    navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<void> navigatePop() async {
    navigatorKey.currentState?.pop();
  }
}
