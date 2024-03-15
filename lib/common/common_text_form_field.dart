import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/themes.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final int? maxLength;
  final Color? styleColor;
  final Color? hintColor;
  final void Function()? onTap;
  final bool showSuffix;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final String? labelText;

  const CommonTextFormField(
      {super.key,
      required this.controller,
        this.hintText,
      this.maxLength,
      this.keyboardType,
      this.inputFormatters,
      this.styleColor,
      this.hintColor,
      this.onTap,
      this.showSuffix = false,
      this.readOnly,
      this.validator,
      this.textInputAction,
      this.style, this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        readOnly: readOnly ?? false,
        onTap: onTap,
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        textInputAction: textInputAction,
        validator: validator,
        style: style ??
            textTheme()
                .bodyMedium
                ?.copyWith(color: styleColor ?? AppColors.pureWhite, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          labelText: labelText,
            suffixIcon:
                showSuffix ? const Icon(Icons.keyboard_arrow_down, color: AppColors.noTeamColor) : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            hintText: hintText,
            counterText: '',
            fillColor: Colors.transparent,
            hintStyle: textTheme()
                .bodyMedium
                ?.copyWith(color: hintColor ?? AppColors.pureWhite, fontWeight: FontWeight.w400),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.borderColor)),
            errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.borderColor)),
            focusedErrorBorder:
                const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.borderColor)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.borderColor))));
  }
}
