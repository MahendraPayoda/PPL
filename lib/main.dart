import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/pref/pref_service.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/router/routes.dart';
import 'package:payoda/utills/constant.dart';

import 'localization/translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefsService = await SharedPreferencesService.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppTranslations appTranslations = AppTranslations();
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PayodaApp',
        localizationsDelegates: const [
          AppTranslations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: AppTranslations.supportedLocales,
        locale: appTranslations.locale,
        navigatorKey: AppRouter.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRoutes.splashRoute,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme);
  }
}
