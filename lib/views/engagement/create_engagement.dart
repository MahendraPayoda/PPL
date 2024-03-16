import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/common_text_form_field.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/create_engagement_provider.dart';
import 'package:provider/provider.dart';

class CreateEngagementScreen extends StatefulWidget {
  const CreateEngagementScreen({super.key});

  @override
  State<CreateEngagementScreen> createState() => _CreateEngagementScreenState();
}

class _CreateEngagementScreenState extends State<CreateEngagementScreen> {
  late CreateEngagementProvider createEngagementProvider;
  final formKey = GlobalKey<FormState>();
  final pointsFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    createEngagementProvider = CreateEngagementProvider();
    createEngagementProvider.getEngagementType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => createEngagementProvider,
        builder: (context, child) => Consumer<CreateEngagementProvider>(
            builder: (context, value, child) => Scaffold(
                bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(children: [
                            Checkbox(
                                activeColor: AppColors.lightPrimary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                                value: value.sendNotificationCheckValue,
                                onChanged: (val) => value.updateNotificationCheckValue(val)),
                            Expanded(
                                child: Text('Send notification to teams.',
                                    style: textTheme()
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.gmailButtonColor, fontSize: 15)))
                          ]),
                          CommonElevatedButton(
                              text: 'create_event'.tr(),
                              borderRadius: 5,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  value.createEngagement(context);
                                }
                              },
                              showBorder: false,
                              backgroundColor: AppColors.buttonColor)
                        ])),
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
                                  colorFilter:
                                      const ColorFilter.mode(AppColors.gmailButtonColor, BlendMode.srcIn)))),
                      const SizedBox(width: 10),
                      Text('createEngagement'.tr(),
                          style: textTheme()
                              .bodyMedium
                              ?.copyWith(color: AppColors.gmailButtonColor, fontSize: 15))
                    ])),
                body: Stack(children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView(children: [
                        InkWell(
                          onTap: () => value.pickExcelFile(context),
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              color: AppColors.dottedColor,
                              child: SizedBox(
                                  height: MediaQuery.sizeOf(context).width * 0.13,
                                  width: MediaQuery.sizeOf(context).width,
                                  child: (value.pickedExcelFile != null)
                                      ? Align(
                                          alignment: Alignment.topLeft,
                                          child: FittedBox(
                                              child: Container(
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
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(value.pickedExcelFile!.name,
                                                              style: textTheme().bodyMedium?.copyWith(
                                                                  color: AppColors.noTeamColor,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w400)),
                                                          Text(
                                                              '${value.getSizeInKb(File(value.pickedExcelFile!.path!))} Kb',
                                                              style: textTheme().bodyMedium?.copyWith(
                                                                  color: AppColors.drawerButtonColor,
                                                                  fontSize: 10,
                                                                  fontWeight: FontWeight.w400))
                                                        ]),
                                                    IconButton(
                                                        onPressed: () => value.removeExcel(),
                                                        icon: const Icon(Icons.close,
                                                            color: AppColors.noTeamColor))
                                                  ]))))
                                      : Center(
                                          child: Text('upload_engagement_details'.tr(),
                                              style: textTheme().bodyMedium?.copyWith(
                                                  color: AppColors.drawerButtonColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14))))),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Text('or',
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.drawerButtonColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                        ),
                        IgnorePointer(
                            ignoring: value.pickedExcelFile != null,
                            child: CommonTextFormField(
                                controller: value.engagementTypeController,
                                textInputAction: TextInputAction.next,
                                hintColor: AppColors.gmailButtonColor,
                                showSuffix: true,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            insetPadding: EdgeInsets.zero,
                                            iconPadding: EdgeInsets.zero,
                                            titlePadding: const EdgeInsets.only(top: 5, left: 10),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10))),
                                            surfaceTintColor: Colors.white,
                                            backgroundColor: AppColors.pureWhite,
                                            contentPadding: EdgeInsets.zero,
                                            title: Row(children: [
                                              IconButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  icon: SvgPicture.asset(Assets.icons.backIcon,
                                                      width: 25,
                                                      colorFilter: const ColorFilter.mode(
                                                          AppColors.gmailButtonColor, BlendMode.srcIn))),
                                              const SizedBox(width: 10),
                                              Text('Engagement Type',
                                                  style: textTheme().bodyMedium?.copyWith(
                                                      color: AppColors.gmailButtonColor,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700))
                                            ]),
                                            content: SingleChildScrollView(
                                                child: ListBody(
                                                    children:
                                                        value.engagementTypeResponse.map((engagementType) {
                                              return RadioListTile(
                                                  overlayColor:
                                                      MaterialStateProperty.all(AppColors.lightPrimary),
                                                  activeColor: AppColors.lightPrimary,
                                                  title: Text(engagementType.name ?? ''),
                                                  value: engagementType,
                                                  groupValue: value.selectedEngagementType,
                                                  onChanged: (val) {
                                                    setState(() => value.selectedEngagementType = val);
                                                    value.engagementTypeController.text = val!.name ?? '';
                                                    Future.delayed(const Duration(microseconds: 500),
                                                        () => Navigator.of(context).pop());
                                                  });
                                            }).toList())));
                                      });
                                },
                                readOnly: true,
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.gmailButtonColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                styleColor: AppColors.gmailButtonColor,
                                labelText: 'engagement_type'.tr(),
                                validator: (validatorValue) {
                                  if (validatorValue == null || validatorValue.isEmpty) {
                                    return 'Please enter engagement type';
                                  }
                                  return null;
                                })),
                        IgnorePointer(
                            ignoring: value.pickedExcelFile != null,
                            child: CommonTextFormField(
                                controller: value.engagementNameController,
                                textInputAction: TextInputAction.next,
                                hintColor: AppColors.gmailButtonColor,
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.gmailButtonColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                styleColor: AppColors.gmailButtonColor,
                                labelText: 'event_name'.tr(),
                                validator: (validatorValue) {
                                  if (validatorValue == null || validatorValue.isEmpty) {
                                    return 'Please enter engagement name';
                                  }
                                  return null;
                                })),
                        IgnorePointer(
                            ignoring: value.pickedExcelFile != null,
                            child: CommonTextFormField(
                                controller: value.engagementEventPointController,
                                textInputAction: TextInputAction.next,
                                hintColor: AppColors.gmailButtonColor,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Form(
                                          key: pointsFormKey,
                                          child: AlertDialog(
                                              insetPadding: EdgeInsets.zero,
                                              actionsPadding:
                                                  const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                                              iconPadding: EdgeInsets.zero,
                                              titlePadding: const EdgeInsets.only(top: 5, left: 10),
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                                              surfaceTintColor: Colors.white,
                                              backgroundColor: AppColors.pureWhite,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                              title: Row(children: [
                                                IconButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    icon: SvgPicture.asset(Assets.icons.backIcon,
                                                        width: 25,
                                                        colorFilter: const ColorFilter.mode(
                                                            AppColors.gmailButtonColor, BlendMode.srcIn))),
                                                const SizedBox(width: 10),
                                                Text('PPL Points',
                                                    style: textTheme().bodyMedium?.copyWith(
                                                        color: AppColors.gmailButtonColor,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700))
                                              ]),
                                              actions: [
                                                CommonElevatedButton(
                                                    borderRadius: 5,
                                                    showBorder: false,
                                                    backgroundColor: AppColors.buttonColor,
                                                    text: 'Done',
                                                    onPressed: () {
                                                      if (pointsFormKey.currentState!.validate()) {
                                                        Navigator.of(context).pop();
                                                      }
                                                    })
                                              ],
                                              content: SingleChildScrollView(
                                                  child: ListBody(children: [
                                                CommonTextFormField(
                                                    controller: value.engagementEventPointController,
                                                    textInputAction: TextInputAction.next,
                                                    keyboardType: const TextInputType.numberWithOptions(),
                                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                    style: textTheme().bodyMedium?.copyWith(
                                                        color: AppColors.gmailButtonColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14),
                                                    styleColor: AppColors.gmailButtonColor,
                                                    labelText: 'Event points*',
                                                    validator: (validatorValue) {
                                                      if (validatorValue == null || validatorValue.isEmpty) {
                                                        return 'Please enter event points';
                                                      }
                                                      return null;
                                                    }),
                                                CommonTextFormField(
                                                    controller: value.engagementWinnerController,
                                                    textInputAction: TextInputAction.next,
                                                    keyboardType: const TextInputType.numberWithOptions(),
                                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                    style: textTheme().bodyMedium?.copyWith(
                                                        color: AppColors.gmailButtonColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14),
                                                    styleColor: AppColors.gmailButtonColor,
                                                    labelText: 'Winner Points*',
                                                    validator: (validatorValue) {
                                                      if (validatorValue == null || validatorValue.isEmpty) {
                                                        return 'Please enter winner points';
                                                      }
                                                      return null;
                                                    }),
                                                CommonTextFormField(
                                                    controller: value.engagementRunnerController,
                                                    textInputAction: TextInputAction.next,
                                                    keyboardType: const TextInputType.numberWithOptions(),
                                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                    style: textTheme().bodyMedium?.copyWith(
                                                        color: AppColors.gmailButtonColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14),
                                                    styleColor: AppColors.gmailButtonColor,
                                                    labelText: 'Runner Points*',
                                                    validator: (validatorValue) {
                                                      if (validatorValue == null || validatorValue.isEmpty) {
                                                        return 'Please enter runner points';
                                                      }
                                                      return null;
                                                    }),
                                                CommonTextFormField(
                                                    controller: value.engagementParticipantsController,
                                                    textInputAction: TextInputAction.next,
                                                    keyboardType: const TextInputType.numberWithOptions(),
                                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                    style: textTheme().bodyMedium?.copyWith(
                                                        color: AppColors.gmailButtonColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14),
                                                    styleColor: AppColors.gmailButtonColor,
                                                    labelText: 'Participants Points*',
                                                    validator: (validatorValue) {
                                                      if (validatorValue == null || validatorValue.isEmpty) {
                                                        return 'Please enter participants points';
                                                      }
                                                      return null;
                                                    })
                                              ]))),
                                        );
                                      });
                                },
                                readOnly: true,
                                showSuffix: true,
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.gmailButtonColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                styleColor: AppColors.gmailButtonColor,
                                labelText: 'ppl_points'.tr(),
                                validator: (validatorValue) {
                                  if (validatorValue == null || validatorValue.isEmpty) {
                                    return 'Please enter ppl points';
                                  }
                                  return null;
                                })),
                        IgnorePointer(
                            ignoring: value.pickedExcelFile != null,
                            child: Row(children: [
                              Expanded(
                                  child: CommonTextFormField(
                                      controller: value.engagementWinnerController,
                                      textInputAction: TextInputAction.next,
                                      hintColor: AppColors.gmailButtonColor,
                                      readOnly: true,
                                      style: textTheme().bodyMedium?.copyWith(
                                          color: AppColors.gmailButtonColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                      styleColor: AppColors.gmailButtonColor,
                                      labelText: 'Winner*',
                                      validator: (validatorValue) {
                                        if (validatorValue == null || validatorValue.isEmpty) {
                                          return 'Please enter winner points';
                                        }
                                        return null;
                                      })),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: CommonTextFormField(
                                      controller: value.engagementRunnerController,
                                      textInputAction: TextInputAction.next,
                                      hintColor: AppColors.gmailButtonColor,
                                      readOnly: true,
                                      style: textTheme().bodyMedium?.copyWith(
                                          color: AppColors.gmailButtonColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                      styleColor: AppColors.gmailButtonColor,
                                      labelText: 'Runner*',
                                      validator: (validatorValue) {
                                        if (validatorValue == null || validatorValue.isEmpty) {
                                          return 'Please enter runner points';
                                        }
                                        return null;
                                      })),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: CommonTextFormField(
                                      controller: value.engagementParticipantsController,
                                      textInputAction: TextInputAction.next,
                                      hintColor: AppColors.gmailButtonColor,
                                      readOnly: true,
                                      style: textTheme().bodyMedium?.copyWith(
                                          color: AppColors.gmailButtonColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                      styleColor: AppColors.gmailButtonColor,
                                      labelText: 'Participants*',
                                      validator: (validatorValue) {
                                        if (validatorValue == null || validatorValue.isEmpty) {
                                          return 'Please enter participants';
                                        }
                                        return null;
                                      }))
                            ])),
                        IgnorePointer(
                            ignoring: value.pickedExcelFile != null,
                            child: CommonTextFormField(
                                controller: value.engagementDateTimeController,
                                textInputAction: TextInputAction.next,
                                hintColor: AppColors.gmailButtonColor,
                                readOnly: true,
                                showSuffix: true,
                                onTap: () {
                                  value.showDateTimePicker(context: context).then((val) {
                                    if (val != null) {
                                      String formattedDateTime = val.toIso8601String();
                                      value.engagementDateTimeController.text = formattedDateTime;
                                    }
                                  });
                                },
                                suffix:
                                    const Icon(Icons.calendar_today_outlined, color: AppColors.noTeamColor),
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.gmailButtonColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                styleColor: AppColors.gmailButtonColor,
                                labelText: 'Date & Time*',
                                validator: (validatorValue) {
                                  if (validatorValue == null || validatorValue.isEmpty) {
                                    return 'Please select date and time';
                                  }
                                  return null;
                                })),
                        IgnorePointer(
                            ignoring: value.pickedExcelFile != null,
                            child: CommonTextFormField(
                                controller: value.engagementVenueController,
                                textInputAction: TextInputAction.next,
                                hintColor: AppColors.gmailButtonColor,
                                showSuffix: true,
                                suffix: const Icon(Icons.location_on_outlined, color: AppColors.noTeamColor),
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.gmailButtonColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                styleColor: AppColors.gmailButtonColor,
                                labelText: 'Venue*',
                                validator: (validatorValue) {
                                  if (validatorValue == null || validatorValue.isEmpty) {
                                    return 'Please select date and time';
                                  }
                                  return null;
                                })),
                        IgnorePointer(
                            ignoring: value.pickedExcelFile != null,
                            child: CommonTextFormField(
                                controller: value.engagementRegistrationCloseOnController,
                                textInputAction: TextInputAction.next,
                                hintColor: AppColors.gmailButtonColor,
                                readOnly: true,
                                showSuffix: true,
                                onTap: () {
                                  value.showDateTimePicker(context: context).then((val) {
                                    if (val != null) {
                                      String formattedDateTime = val.toIso8601String();
                                      value.engagementRegistrationCloseOnController.text = formattedDateTime;
                                    }
                                  });
                                },
                                suffix:
                                    const Icon(Icons.calendar_today_outlined, color: AppColors.noTeamColor),
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.gmailButtonColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                styleColor: AppColors.gmailButtonColor,
                                labelText: 'Registration closes on*',
                                validator: (validatorValue) {
                                  if (validatorValue == null || validatorValue.isEmpty) {
                                    return 'Please select registration closes date';
                                  }
                                  return null;
                                })),
                        IgnorePointer(
                          ignoring: value.pickedExcelFile != null,
                          child: CommonTextFormField(
                              controller: value.engagementPresenterController,
                              textInputAction: TextInputAction.next,
                              hintColor: AppColors.gmailButtonColor,
                              readOnly: true,
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.gmailButtonColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                              styleColor: AppColors.gmailButtonColor,
                              labelText: 'Presenter/Speaker (Optional)'),
                        ),
                      ]),
                    ),
                  ),
                  if (value.isLoading)
                    Container(
                        color: Colors.black12,
                        child: const Center(child: CircularProgressIndicator(color: AppColors.lightPrimary)))
                ]))));
  }
}
