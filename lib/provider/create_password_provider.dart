import 'package:flutter/material.dart';
import 'package:payoda/model/common_response.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/router/routes.dart';
import 'package:payoda/service/api_service.dart';
import 'package:payoda/service/api_urls.dart';
import 'package:payoda/utills/snackbar_manager.dart';

class CreatePasswordProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> createPassword(
      {required BuildContext context, required String email, required bool isFromForgotPassword}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _apiService.postData(
          isFromForgotPassword ? ApiUrls.resetPasswordRequest : ApiUrls.changePasswordRequest,
          isFromForgotPassword
              ? {'OfficialEmail': email.trim(), 'NewPassword': confirmPasswordController.text.trim()}
              : {'officialEmail': email.trim(), 'newPassword': confirmPasswordController.text.trim()});
      final commonResponse = CommonResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        isLoading = false;
        if (context.mounted) {
          SnackbarManager.showSuccessSnackbar(message: commonResponse.message ?? '', context: context);
          AppRouter.navigatePushReplacementTo(
              isFromForgotPassword ? AppRoutes.loginRoute : AppRoutes.successRoute);
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
