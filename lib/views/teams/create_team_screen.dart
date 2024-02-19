import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_dialog.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/common_text_form_field.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/create_team_provider.dart';
import 'package:payoda/utills/snackbar_manager.dart';
import 'package:payoda/views/teams/upload_team_screen.dart';
import 'package:payoda/views/teams/widgets/dialog_for_sponsor.dart';
import 'package:payoda/views/teams/widgets/dialog_for_vicecaptain.dart';
import 'package:payoda/widgets/dotted_border.dart';
import 'package:provider/provider.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  late CreateTeamProvider createTeamProvider;

  @override
  void initState() {
    createTeamProvider = CreateTeamProvider();
    onLoading();
    createTeamProvider.onLoadingForViceCaptain();
    createTeamProvider.onLoadingForSponsor();
    super.initState();
  }

  onLoading() async {
    var newData = await createTeamProvider.getEmployeeData();
    if (newData.isNotEmpty) {
      createTeamProvider.employeeNameListForCaptain.addAll(newData);
      createTeamProvider.tempEmployeeNameListForCaptain.addAll(newData);
      createTeamProvider.page++;
      setState(() {});
    }
    createTeamProvider.refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateTeamProvider>(
        create: (context) => createTeamProvider,
        child: Consumer<CreateTeamProvider>(
            builder: (context, value, child) => Stack(
                  children: [
                    Scaffold(
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
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.gmailButtonColor, BlendMode.srcIn)))),
                            const SizedBox(width: 10),
                            Text('createTeam'.tr(),
                                style: textTheme()
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.gmailButtonColor, fontSize: 15))
                          ]),
                        ),
                        body: Padding(
                            padding: const EdgeInsets.all(20),
                            child: SingleChildScrollView(
                                child: Column(children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: value.pickedImage == null ? () => value.pickImage(context) : null,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                        decoration:
                                            const DottedBorderDecoration(borderColor: AppColors.grey2Color),
                                        child: Text('uploadLogo'.tr(),
                                            textAlign: TextAlign.center,
                                            style: textTheme().bodyMedium?.copyWith(
                                                color: AppColors.grey3Color,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12))),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('uploadTeamLogo'.tr(),
                                            style: textTheme().bodyMedium?.copyWith(
                                                color: AppColors.gmailButtonColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14)),
                                        const SizedBox(height: 5),
                                        Text.rich(
                                          maxLines: 5,
                                          softWrap: true,
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'logoSizeShould'.tr(),
                                                  style: textTheme().bodyMedium?.copyWith(
                                                      color: AppColors.grey3Color,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400)),
                                              TextSpan(
                                                  text: '1MB',
                                                  style: textTheme().bodyMedium?.copyWith(
                                                      color: AppColors.grey3Color,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700)),
                                              TextSpan(
                                                  text: 'pngAndJpgAreAllowed'.tr(),
                                                  style: textTheme().bodyMedium?.copyWith(
                                                      color: AppColors.grey3Color,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (value.pickedImage != null)
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: FittedBox(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5), color: AppColors.greyColor),
                                      child: Row(
                                        children: [
                                          Image.file(value.pickedImage!,
                                              height: 40, width: 40, fit: BoxFit.cover),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Team logo${value.getExtension()}',
                                                  style: textTheme().bodyMedium?.copyWith(
                                                      color: AppColors.noTeamColor,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400)),
                                              Text(
                                                  '${(value.pickedImage!.lengthSync() / (1024 * 1024)).toStringAsFixed(2)} Kb',
                                                  style: textTheme().bodyMedium?.copyWith(
                                                      color: AppColors.drawerButtonColor,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400)),
                                            ],
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                value.removeImage();
                                              },
                                              icon: const Icon(Icons.close, color: AppColors.noTeamColor))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 10),
                              CommonTextFormField(
                                  controller: value.teamNameController,
                                  hintText: 'teamName'.tr(),
                                  hintColor: AppColors.gmailButtonColor,
                                  style: textTheme().bodyMedium?.copyWith(
                                      color: AppColors.gmailButtonColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  styleColor: AppColors.gmailButtonColor),
                              const SizedBox(height: 8),
                              CommonTextFormField(
                                  controller: value.captainController,
                                  hintText: 'captain'.tr(),
                                  hintColor: AppColors.gmailButtonColor,
                                  styleColor: AppColors.gmailButtonColor,
                                  showSuffix: true,
                                  readOnly: true,
                                  style: textTheme().bodyMedium?.copyWith(
                                      color: AppColors.gmailButtonColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CustomRadioDialog(value, onPressed: () => value.updateCaptain()))),
                              const SizedBox(height: 8),
                              CommonTextFormField(
                                  controller: value.viceCaptainController,
                                  hintText: 'viceCaptain'.tr(),
                                  hintColor: AppColors.gmailButtonColor,
                                  styleColor: AppColors.gmailButtonColor,
                                  style: textTheme().bodyMedium?.copyWith(
                                      color: AppColors.gmailButtonColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  showSuffix: true,
                                  readOnly: true,
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => DialogForViceCaptain(value,
                                          onPressed: () => value.updateViceCaptain()))),
                              const SizedBox(height: 8),
                              CommonTextFormField(
                                  controller: value.sponsorController,
                                  hintText: 'sponsor'.tr(),
                                  hintColor: AppColors.gmailButtonColor,
                                  styleColor: AppColors.gmailButtonColor,
                                  style: textTheme().bodyMedium?.copyWith(
                                      color: AppColors.gmailButtonColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  showSuffix: true,
                                  readOnly: true,
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          DialogForSponsor(value, onPressed: () => value.updateSponsor()))),
                              const SizedBox(height: 20),
                              Row(children: [
                                InkWell(
                                    onTap: value.pickedExcelFile != null
                                        ? null
                                        : () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => const UploadTeamScreen()))
                                                .then((result) {
                                              if (result != null) {
                                                value.notify(result);
                                              }
                                            }),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                        decoration: const DottedBorderDecoration(
                                            borderColor: AppColors.grey2Color,
                                            backgroundColor: AppColors.greyColor),
                                        child: Text('upload'.tr(),
                                            style: textTheme().bodyMedium?.copyWith(
                                                color: AppColors.grey3Color,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12)))),
                                const SizedBox(width: 10),
                                Text('uploadTeamMembers'.tr(),
                                    style: textTheme().bodyMedium?.copyWith(
                                        color: AppColors.gmailButtonColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14))
                              ]),
                              const SizedBox(height: 5),
                              const Divider(thickness: 1.5, color: AppColors.grey2Color),
                              if (value.pickedExcelFile != null)
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: FittedBox(
                                        child: Container(
                                            margin: const EdgeInsets.only(top: 12),
                                            padding: const EdgeInsets.only(left: 8, top: 2, bottom: 2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: AppColors.greyColor),
                                            child: Row(children: [
                                              Container(
                                                  padding: const EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: AppColors.redColor),
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
                                                  onPressed: () => value.removeExcel(),
                                                  icon: const Icon(Icons.close, color: AppColors.noTeamColor))
                                            ])))),
                              const SizedBox(height: 25),
                              CommonElevatedButton(
                                  text: 'createTeam'.tr(),
                                  borderRadius: 5,
                                  onPressed: () {
                                    if (value.teamNameController.text.isEmpty ||
                                        value.captainController.text.isEmpty ||
                                        value.viceCaptainController.text.isEmpty ||
                                        value.sponsorController.text.isEmpty) {
                                      SnackbarManager.showErrorSnackbar(
                                          message: 'Please fill all fields', context: context);
                                      return;
                                    }
                                    if (value.pickedExcelFile == null) {
                                      SnackbarManager.showErrorSnackbar(
                                          message: 'Please upload team members', context: context);
                                      return;
                                    }
                                    if (value.pickedExcelFile == null) {
                                      SnackbarManager.showErrorSnackbar(
                                          message: 'Please upload team members', context: context);
                                      return;
                                    }
                                    value.createTeam();
                                  },
                                  showBorder: false,
                                  backgroundColor: AppColors.buttonColor)
                            ])))),
                    if (value.isLoading)
                      Container(
                          color: Colors.black12,
                          child: const Center(child: CircularProgressIndicator(color: Colors.blue)))
                  ],
                )));
  }
}
