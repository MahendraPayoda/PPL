import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/utills/constant.dart';

class NoTeamCreated extends StatelessWidget {
  final void Function() onPressedCreateTeam;
  final void Function() onPressedUploadTeam;

  const NoTeamCreated({super.key, required this.onPressedCreateTeam, required this.onPressedUploadTeam});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.images.noTeam),
          const SizedBox(height: 15),
          Text('youHaveNoTeam'.tr(),
              textAlign: TextAlign.center,
              style: textTheme()
                  .titleMedium
                  ?.copyWith(color: AppColors.noTeamColor, fontWeight: FontWeight.w500, fontSize: 12)),
          const SizedBox(height: 25),
          CommonElevatedButton(
              width: Constants.width / 2,
              text: 'createTeam'.tr(),
              borderRadius: 5,
              onPressed: onPressedCreateTeam,
              showBorder: false,
              backgroundColor: AppColors.buttonColor),
          const SizedBox(height: 20),
          Text('or'.tr(),
              style: textTheme()
                  .titleMedium
                  ?.copyWith(color: AppColors.noTeamColor, fontWeight: FontWeight.w500, fontSize: 12)),
          TextButton(
            onPressed: onPressedUploadTeam,
            child: Text('uploadTeams'.tr(),
                style: textTheme()
                    .titleMedium
                    ?.copyWith(color: AppColors.uploadTeamColor, fontWeight: FontWeight.w500, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
