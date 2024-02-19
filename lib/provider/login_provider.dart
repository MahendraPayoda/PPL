import 'package:flutter/material.dart';
import 'package:payoda/main.dart';
import 'package:payoda/model/login_response.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/router/routes.dart';
import 'package:payoda/service/api_service.dart';
import 'package:payoda/service/api_urls.dart';
import 'package:payoda/utills/constant.dart';
import 'package:payoda/utills/snackbar_manager.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> loginUser(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _apiService.postData(ApiUrls.login,
          {'OfficialEmail': emailController.text.trim(), 'Password': passwordController.text.trim()});
      final loginResponse = LoginResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        isLoading = false;
        if (context.mounted) {
          SnackbarManager.showSuccessSnackbar(message: loginResponse.message ?? '', context: context);
          if (loginResponse.success ?? false) {
            Constants.prefsService.saveString('token', loginResponse.token ?? "");
            AppRouter.navigateTo(AppRoutes.dashboardRoute);
          } else {
            if (loginResponse.isFirstLogin ?? true) {
              AppRouter.navigateTo(AppRoutes.createPasswordRoute,
                  arguments: {'isFromForgotPassword': false, 'email': emailController.text});
            }
          }
        }
      } else {
        isLoading = false;
        if (context.mounted) {
          SnackbarManager.showErrorSnackbar(message: loginResponse.message ?? '', context: context);
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
