import 'package:flutter/material.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/themes.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnackbarManager {
  static late AnimationController localAnimationController;

  static void showPersistentSnackbar({required String message, required BuildContext context}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
          message: message,
          textStyle: textTheme()
              .bodyMedium!
              .copyWith(color: AppColors.pureWhite, fontSize: 14, fontWeight: FontWeight.w600)),
      persistent: true,
      onAnimationControllerInit: (controller) {
        localAnimationController = controller;
      },
    );
  }

  static void showDismissableSnackbar(
      {required String message, DismissDirection? direction, required BuildContext context}) {
    showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message: message),
        dismissType: DismissType.onSwipe, dismissDirection: [direction!]);
  }

  static void showErrorSnackbar({required String message, required BuildContext context}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
          message: message,
          textStyle: textTheme()
              .bodyMedium!
              .copyWith(color: AppColors.pureWhite, fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }

  static void showSuccessSnackbar({required String message, required BuildContext context}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
          message: message,
          textStyle: textTheme()
              .bodyMedium!
              .copyWith(color: AppColors.pureWhite, fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }
}
