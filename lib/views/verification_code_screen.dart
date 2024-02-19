import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/common_text_form_field.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/forgot_password_provider.dart';
import 'package:payoda/utills/constant.dart';
import 'package:provider/provider.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;
  final bool isFromForgotPassword;

  const VerificationCodeScreen({super.key, required this.email, required this.isFromForgotPassword});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
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
                          padding: const EdgeInsets.only(left: 20),
                          height: 40,
                          child: SvgPicture.asset(Assets.icons.backIcon, width: 30))),
                  const SizedBox(width: 10),
                  Text('forgotPassword'.tr(),
                      style: textTheme().bodyMedium?.copyWith(color: AppColors.pureWhite, fontSize: 15))
                ])),
            body: Container(
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
                      Text('verification'.tr(),
                          style: textTheme().bodyMedium?.copyWith(
                              color: AppColors.pureWhite, fontSize: 20, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 5),
                      Text('enterTheVerificationCodeWeJustSentToYourEmailAddress'.tr(),
                          style: textTheme().bodyMedium?.copyWith(color: AppColors.pureWhite, fontSize: 15)),
                      const SizedBox(height: 40),
                      CommonTextFormField(
                          controller: value.verificationCodeController,
                          hintText: 'enterCode'.tr(),
                          maxLength: 6,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          validator: (validatorValue) {
                            if (validatorValue == null || validatorValue.isEmpty) {
                              return 'Please enter verification code';
                            }
                            return null;
                          }),
                      const SizedBox(height: 25),
                      CommonElevatedButton(
                          text: 'verify'.tr(),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              value.otpVerify(
                                  context: context,
                                  email: widget.email,
                                  isFromForgotPassword: widget.isFromForgotPassword);
                            }
                          },
                          borderRadius: 5,
                          backgroundColor: AppColors.buttonColor,
                          showBorder: false),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'didReceivedCode'.tr(),
                                  style: textTheme().bodyMedium?.copyWith(
                                      color: AppColors.pureWhite, fontSize: 14, fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: 'Resend',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      value.forgotPassword(context, isFromResend: true, email: widget.email);
                                    },
                                  style: textTheme().bodyMedium?.copyWith(
                                      color: AppColors.pureWhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      decorationThickness: 2,
                                      decoration: TextDecoration.underline)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
