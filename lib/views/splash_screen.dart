import 'package:flutter/material.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/provider/splash_provider.dart';
import 'package:payoda/utills/constant.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashProvider splashProvider;

  @override
  void initState() {
    splashProvider = SplashProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashProvider>(
        create: (context) => splashProvider,
        child: Scaffold(
            body: Assets.images.splashImage
                .image(width: Constants.width, height: Constants.height, fit: BoxFit.fill)));
  }
}
