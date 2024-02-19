import 'package:flutter/material.dart';
import 'package:payoda/model/common_response.dart';
import 'package:payoda/model/forgot_password_response.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/router/routes.dart';
import 'package:payoda/service/api_service.dart';
import 'package:payoda/service/api_urls.dart';
import 'package:payoda/utills/snackbar_manager.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final _apiService = ApiService();
  final emailController = TextEditingController();
  final verificationCodeController = TextEditingController();
  bool isLoading = false;

  Future<void> forgotPassword(BuildContext context,
      {bool isFromResend = false, required String email}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response =
          await _apiService.postData(ApiUrls.forgotPasswordRequest, {'OfficialEmail': email.trim()});
      final forgotPasswordResponse = ForgotPasswordResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        isLoading = false;
        if (context.mounted) {
          SnackbarManager.showSuccessSnackbar(
              message: forgotPasswordResponse.message ?? '', context: context);

          if (forgotPasswordResponse.success ?? false) {
            if (!isFromResend) {
              AppRouter.navigateTo(AppRoutes.verificationCodeRoute,
                  arguments: {'isFromForgotPassword': true, 'email': emailController.text});
            } else {
              verificationCodeController.clear();
            }
          }
        }
      } else {
        isLoading = false;
        if (context.mounted) {
          SnackbarManager.showErrorSnackbar(message: forgotPasswordResponse.message ?? '', context: context);
        }
      }
    } catch (error) {
      isLoading = false;
      debugPrint('Error: $error');
      if (context.mounted) {
        SnackbarManager.showErrorSnackbar(message: 'Error: $error', context: context);
      }
    }
    notifyListeners();
  }

  Future<void> otpVerify(
      {required BuildContext context, required String email, required bool isFromForgotPassword}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _apiService
          .postData(ApiUrls.verifyOtp, {'VerificationCode': verificationCodeController.text.trim()});
      final commonResponse = CommonResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        isLoading = false;
        if (context.mounted) {
          SnackbarManager.showSuccessSnackbar(message: commonResponse.message ?? '', context: context);
          AppRouter.navigatePushReplacementTo(AppRoutes.createPasswordRoute,
              arguments: {'isFromForgotPassword': isFromForgotPassword, 'email': email});
        }
      } else {
        isLoading = false;
        if (context.mounted) {
          SnackbarManager.showErrorSnackbar(message: commonResponse.message ?? '', context: context);
        }
      }
    } catch (error) {
      isLoading = false;
      debugPrint('Error: $error');
      if (context.mounted) {
        SnackbarManager.showErrorSnackbar(message: 'Error: $error', context: context);
      }
    }
    notifyListeners();
  }
}
