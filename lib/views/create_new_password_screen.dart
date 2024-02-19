import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/common_text_form_field.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/create_password_provider.dart';
import 'package:payoda/utills/constant.dart';
import 'package:provider/provider.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final bool isFromForgotPassword;
  final String email;

  const CreateNewPasswordScreen({super.key, required this.isFromForgotPassword, required this.email});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  late CreatePasswordProvider createPasswordProvider;

  @override
  void initState() {
    createPasswordProvider = CreatePasswordProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('isFromForgotPassword ${widget.isFromForgotPassword}');
    debugPrint('email ${widget.email}');
    return ChangeNotifierProvider<CreatePasswordProvider>(
      create: (context) => createPasswordProvider,
      child: Consumer<CreatePasswordProvider>(
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
                  Text(widget.isFromForgotPassword ? 'forgotPassword'.tr() : 'createPassword'.tr(),
                      style: textTheme().bodyMedium?.copyWith(color: AppColors.pureWhite, fontSize: 15))
                ])),
            body: Container(
              width: Constants.width,
              height: Constants.height,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: value.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      Text('createNewPassword'.tr(),
                          style: textTheme().bodyMedium?.copyWith(
                              color: AppColors.pureWhite, fontSize: 20, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 5),
                      Text('createPasswordDesc'.tr(),
                          style: textTheme().bodyMedium?.copyWith(color: AppColors.pureWhite, fontSize: 15)),
                      const SizedBox(height: 40),
                      CommonTextFormField(
                          controller: value.newPasswordController,
                          hintText: 'enterNewPassword'.tr(),
                          textInputAction: TextInputAction.next,
                          validator: (validatorValue) {
                            if (validatorValue == null || validatorValue.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      CommonTextFormField(
                          controller: value.confirmPasswordController,
                          hintText: 'confirmNewPassword'.tr(),
                          textInputAction: TextInputAction.done,
                          validator: (validatorValue) {
                            if (validatorValue == null || validatorValue.isEmpty) {
                              return 'Please enter confirm password';
                            }
                            if (value.newPasswordController.text.trim() != value.confirmPasswordController.text.trim()) {
                              return "password doesn't match";
                            }
                            return null;
                          }),
                      const SizedBox(height: 25),
                      CommonElevatedButton(
                          text: 'createPassword'.tr(),
                          onPressed: () {
                            if (value.formKey.currentState!.validate()) {
                              value.createPassword(
                                  context: context,
                                  email: widget.email,
                                  isFromForgotPassword: widget.isFromForgotPassword);
                            }
                          },
                          borderRadius: 5,
                          backgroundColor: AppColors.buttonColor,
                          loading: value.isLoading,
                          showBorder: false),
                      const SizedBox(height: 10),
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
