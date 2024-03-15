import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';

class CreateEngagementScreen extends StatefulWidget {
  const CreateEngagementScreen({super.key});

  @override
  State<CreateEngagementScreen> createState() => _CreateEngagementScreenState();
}

class _CreateEngagementScreenState extends State<CreateEngagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.greyColor,
        leadingWidth: 400,
        leading: Row(children: [
          const SizedBox(width: 10),
          InkWell(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                  height: 40,
                  child: SvgPicture.asset(Assets.icons.backIcon,
                      width: 30,
                      colorFilter: const ColorFilter.mode(AppColors.gmailButtonColor, BlendMode.srcIn)))),
          const SizedBox(width: 10),
          Text('createEngagement'.tr(),
              style: textTheme().bodyMedium?.copyWith(color: AppColors.gmailButtonColor, fontSize: 15))
        ]),
      ),
      body: Column(children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          child: SizedBox(
              height: MediaQuery.sizeOf(context).width * 0.8,
              width: MediaQuery.sizeOf(context).width,
              child: Text('dragOrDropCsvHere'.tr(),
                  style: textTheme().bodyMedium?.copyWith(
                      color: AppColors.drawerButtonColor, fontWeight: FontWeight.w500, fontSize: 14))),
        ),
      ]),
    );
  }
}
