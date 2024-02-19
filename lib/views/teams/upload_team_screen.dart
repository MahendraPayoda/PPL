import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/create_team_provider.dart';
import 'package:payoda/widgets/dotted_border.dart';
import 'package:provider/provider.dart';

class UploadTeamScreen extends StatefulWidget {
  const UploadTeamScreen({super.key});

  @override
  State<UploadTeamScreen> createState() => _UploadTeamScreenState();
}

class _UploadTeamScreenState extends State<UploadTeamScreen> {
  late CreateTeamProvider createTeamProvider;

  @override
  void initState() {
    createTeamProvider = CreateTeamProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateTeamProvider>(
      create: (context) => createTeamProvider,
      child: Consumer<CreateTeamProvider>(
        builder: (context, value, child) => Scaffold(
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
                            width: 25,
                            colorFilter:
                                const ColorFilter.mode(AppColors.gmailButtonColor, BlendMode.srcIn)))),
                const SizedBox(width: 10),
                Text('uploadTeam'.tr(),
                    style: textTheme().bodyMedium?.copyWith(color: AppColors.gmailButtonColor, fontSize: 15))
              ]),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: SizedBox(
                      height: MediaQuery.sizeOf(context).width * 0.8,
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        SvgPicture.asset(Assets.images.uploadImage),
                        Text('dragOrDropCsvHere'.tr(),
                            style: textTheme().bodyMedium?.copyWith(
                                color: AppColors.drawerButtonColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                        Text('---- OR ----',
                            style: textTheme().bodyMedium?.copyWith(
                                color: AppColors.drawerButtonColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                        CommonElevatedButton(
                            width: 150,
                            borderRadius: 5,
                            showBorder: false,
                            text: 'browseFile'.tr(),
                            backgroundColor: AppColors.buttonColor,
                            onPressed: value.pickedExcelFile == null ? () => value.pickExcelFile() : null),
                        Text('downloadSampleCsvHere'.tr(),
                            style: textTheme().bodyMedium?.copyWith(
                                color: AppColors.uploadTeamColor, fontWeight: FontWeight.w600, fontSize: 13)),
                      ])),
                ),
                if (value.pickedExcelFile != null)
                  Align(
                      alignment: Alignment.topLeft,
                      child: FittedBox(
                          child: Container(
                              margin: const EdgeInsets.only(top: 12),
                              padding: const EdgeInsets.only(left: 8, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5), color: AppColors.greyColor),
                              child: Row(children: [
                                Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5), color: AppColors.redColor),
                                    child: Text('Xlsx',
                                        style: textTheme().bodyMedium?.copyWith(
                                            color: AppColors.pureWhite,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10))),
                                const SizedBox(width: 8),
                                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text('Payoda Teams.xlsx',
                                      style: textTheme().bodyMedium?.copyWith(
                                          color: AppColors.noTeamColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                  Text(' Kb',
                                      style: textTheme().bodyMedium?.copyWith(
                                          color: AppColors.drawerButtonColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400))
                                ]),
                                IconButton(
                                    onPressed: () {
                                      value.removeExcel();
                                    },
                                    icon: const Icon(Icons.close, color: AppColors.noTeamColor))
                              ])))),
                const SizedBox(height: 20),
                CommonElevatedButton(
                    text: 'Upload Teams',
                    backgroundColor: AppColors.buttonColor,
                    borderRadius: 5,
                    showBorder: false,
                    onPressed: value.pickedExcelFile == null
                        ? null
                        : () => Navigator.pop(context, value.pickedExcelFile))
              ]),
            )),
      ),
    );
  }
}
