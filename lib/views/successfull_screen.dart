import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/router/routes.dart';
import 'package:payoda/utills/constant.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final _controller = StreamController<String>();
  late Timer _timer;
  late int _secondsRemaining;

  Stream<String> get timerStream => _controller.stream;

  @override
  void initState() {
    _secondsRemaining = 05;
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
    super.initState();
  }

  void _updateTimer(Timer timer) {
    if (_secondsRemaining > 0) {
      _secondsRemaining--;
      String formattedTime = _secondsRemaining.toString().padLeft(2, '0');
      if (_secondsRemaining == 0) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute, (route) => false);
      } else {
        _controller.add(formattedTime);
      }
    } else {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.width,
      height: Constants.height,
      decoration: BoxDecoration(
          color: AppColors.lightPrimary,
          image: DecorationImage(
              image: AssetImage(Assets.images.lineImage.path),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.fitWidth)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: Constants.width,
          height: Constants.height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('success'.tr(),
                    style: textTheme()
                        .bodyMedium
                        ?.copyWith(color: AppColors.pureWhite, fontSize: 20, fontWeight: FontWeight.w700)),
                Text('successDesc'.tr(),
                    style: textTheme().bodyMedium?.copyWith(color: AppColors.pureWhite, fontSize: 15)),
                const SizedBox(height: 10),
                CommonElevatedButton(
                    text: 'goToLogin'.tr(),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute, (route) => false);
                    },
                    borderRadius: 5,
                    backgroundColor: AppColors.buttonColor,
                    showBorder: false),
                const SizedBox(height: 10),
                StreamBuilder<String>(
                    stream: timerStream,
                    initialData: '05',
                    builder: (context, snapshot) {
                      return Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'redirectingIn'.tr(),
                                  style: textTheme().bodyMedium?.copyWith(
                                      color: AppColors.pureWhite, fontSize: 14, fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: snapshot.data.toString(),
                                  style: textTheme().bodyMedium?.copyWith(
                                      color: AppColors.pureWhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline)),
                              TextSpan(
                                  text: 'sec'.tr(),
                                  style: textTheme().bodyMedium?.copyWith(
                                      color: AppColors.pureWhite, fontSize: 14, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
