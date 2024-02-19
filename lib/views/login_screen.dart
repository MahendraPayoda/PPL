import 'package:flutter/material.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/common_text_form_field.dart';
import 'package:payoda/common/email_validator.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/login_provider.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/router/routes.dart';
import 'package:payoda/utills/constant.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginProvider loginProvider;

  @override
  void initState() {
    loginProvider = LoginProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => loginProvider,
      child: Consumer<LoginProvider>(
        builder: (context, value, child) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: AppColors.lightPrimary,
              image: DecorationImage(
                  image: AssetImage(Assets.images.lineImage.path),
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.fitWidth)),
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  width: Constants.width,
                  height: Constants.height,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: value.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          Align(
                            alignment: Alignment.center,
                            child: Text('payodaPremiereLeague'.tr(),
                                textAlign: TextAlign.center,
                                style: textTheme()
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.pureWhite, fontSize: 30)),
                          ),
                          const SizedBox(height: 50),
                          Text('proceedWithYour'.tr(),
                              style:
                                  textTheme().bodyMedium?.copyWith(color: AppColors.pureWhite, fontSize: 15)),
                          Text('login'.tr(),
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.pureWhite, fontSize: 20, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 40),
                          CommonTextFormField(
                              controller: value.emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              hintText: 'emailAddress'.tr(),
                              validator: (validatorValue) {
                                if (validatorValue == null || validatorValue.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                if (validateEmail(validatorValue)) {
                                  return 'Please enter valid email address';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20),
                          CommonTextFormField(
                              controller: value.passwordController,
                              hintText: 'password'.tr(),
                              textInputAction: TextInputAction.done,
                              validator: (validatorValue) {
                                if (validatorValue == null || validatorValue.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () => AppRouter.navigateTo(AppRoutes.forgotPasswordRoute),
                              child: Text('forgotPassword?'.tr(),
                                  style: textTheme().bodyMedium?.copyWith(
                                      color: AppColors.pureWhite, fontSize: 14, fontWeight: FontWeight.w400)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CommonElevatedButton(
                              text: 'signIn'.tr(),
                              loading: value.isLoading,
                              onPressed: () async {
                                //  AppRouter.navigateTo(AppRoutes.dashboardRoute);
                                if (value.formKey.currentState!.validate()) {
                                  value.loginUser(context);
                                }
                              },
                              borderRadius: 5,
                              backgroundColor: AppColors.buttonColor,
                              showBorder: false)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (value.isLoading)
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black12)
            ],
          ),
        ),
      ),
    );
  }
}
