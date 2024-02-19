import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/common_text_form_field.dart';
import 'package:payoda/common/email_validator.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/forgot_password_provider.dart';
import 'package:payoda/utills/constant.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ForgotPasswordProvider forgotPasswordProvider;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    forgotPasswordProvider = ForgotPasswordProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordProvider>(
      create: (context) => forgotPasswordProvider,
      child: Consumer<ForgotPasswordProvider>(
        builder: (context, value, child) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: AppColors.lightPrimary,
              image: DecorationImage(
                  image: AssetImage(Assets.images.lineImage.path),
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.fitWidth)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 400,
              leading: Row(children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 20),
                        child: SvgPicture.asset(Assets.icons.backIcon, width: 30))),
                const SizedBox(width: 10),
                Text('forgotPassword'.tr(),
                    style: textTheme().bodyMedium?.copyWith(color: AppColors.pureWhite, fontSize: 15))
              ]),
            ),
            body: Stack(
              children: [
                Container(
                  width: Constants.width,
                  height: Constants.height,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 130),
                          Text('forgotPassword?'.tr(),
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.pureWhite, fontSize: 20, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text('pleaseEnterYourEmailAddressToReceiveAVerificationCode'.tr(),
                              style:
                                  textTheme().bodyMedium?.copyWith(color: AppColors.pureWhite, fontSize: 15)),
                          const SizedBox(height: 40),
                          CommonTextFormField(
                              controller: value.emailController, hintText: 'emailAddress'.tr(),
                              validator: (validatorValue) {
                                if (validatorValue == null || validatorValue.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                if (validateEmail(validatorValue)) {
                                  return 'Please enter valid email address';
                                }
                                return null;
                              }
                          ),
                          const SizedBox(height: 25),
                          CommonElevatedButton(
                              text: 'sendVerificationCode'.tr(),
                              loading: value.isLoading,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  value.forgotPassword(context,email: value.emailController.text);
                                }
                              },
                              borderRadius: 5,
                              backgroundColor: AppColors.buttonColor,
                              showBorder: false),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                if (value.isLoading)
                  Container(width: Constants.width, height: Constants.height, color: Colors.black12)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
