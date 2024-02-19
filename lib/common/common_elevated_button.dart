import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payoda/common/themes.dart';

class CommonElevatedButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;
  final void Function()? onPressed;
  final bool showBorder;
  final bool loading;

  const CommonElevatedButton({
    Key? key,
    required this.text,
    this.width = double.infinity,
    this.height = 50.0,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 16,
    this.showBorder = true,
    this.borderColor = Colors.blue,
    required this.onPressed,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    side: BorderSide(color: showBorder ? borderColor : Colors.transparent))),
            child: loading
                ? Theme(
                    data: ThemeData(
                        cupertinoOverrideTheme: const CupertinoThemeData(
                            brightness: Brightness.dark,
                            primaryColor: CupertinoDynamicColor.withBrightness(
                                color: CupertinoColors.white, darkColor: CupertinoColors.white),
                            barBackgroundColor: CupertinoDynamicColor.withBrightness(
                                color: CupertinoColors.white, darkColor: CupertinoColors.white),
                            scaffoldBackgroundColor: CupertinoDynamicColor.withBrightness(
                                color: CupertinoColors.white, darkColor: CupertinoColors.white))),
                    child: const CupertinoActivityIndicator())
                : Text(text,
                    style: textTheme()
                        .bodyMedium
                        ?.copyWith(color: textColor, fontSize: 14, fontWeight: FontWeight.w600))));
  }
}
