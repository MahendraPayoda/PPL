import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_app_bar.dart';
import 'package:payoda/common/common_drawer.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/teams_provider.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/router/routes.dart';
import 'package:payoda/views/teams/recent_onboarding_screen.dart';
import 'package:provider/provider.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  late TeamsProvider teamsProvider;
  int recentItem = 12;

  @override
  void initState() {
    teamsProvider = TeamsProvider();
    teamsProvider.apiCalls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeamsProvider>(
      create: (context) => teamsProvider,
      child: Consumer<TeamsProvider>(
        builder: (context, value, child) => Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.pureWhite,
              drawer: const CommonDrawer(),
              appBar: CommonAppBar(
                  centerTitle: true,
                  actions: [
                    InkWell(
                      onTap: () {
                        AppRouter.navigateTo(AppRoutes.createTeamRoute);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.add_circle_outline, color: AppColors.buttonColor),
                          const SizedBox(width: 5),
                          Text('addTeam'.tr(),
                              style: textTheme().titleMedium?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.buttonColor)),
                          const SizedBox(width: 8)
                        ],
                      ),
                    )
                  ],
                  title: Text('teams'.tr(),
                      style: textTheme().titleMedium?.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.gmailButtonColor))),
              body: (value.loading)
                  ? const Center(child: CircularProgressIndicator(color: Colors.blue))
                  : DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                              unselectedLabelColor: AppColors.drawerButtonColor,
                              labelColor: AppColors.noTeamColor,
                              isScrollable: true,
                              indicator: const UnderlineTabIndicator(
                                  insets: EdgeInsets.symmetric(horizontal: 15),
                                  borderSide: BorderSide(color: AppColors.indicatorColor, width: 3.0)),
                              unselectedLabelStyle: textTheme().titleSmall?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.drawerButtonColor),
                              labelStyle: textTheme().titleMedium?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.noTeamColor),
                              tabs: [Tab(text: 'teams'.tr()), Tab(text: 'Recent Onboarding ($recentItem)')]),
                          Expanded(
                            child: TabBarView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        customContainer(
                                          firstTitle: 'Total Employees',
                                          firstValue: (value.getAllEmployeeCountResponse == null ||
                                                  value.getAllEmployeeCountResponse!.totalEmployees == null)
                                              ? '-'
                                              : value.getAllEmployeeCountResponse!.totalEmployees.toString(),
                                          secondTitle: 'Total Teams',
                                          secondValue: (value.getTotalTeamsCountResponse == null ||
                                                  value.getTotalTeamsCountResponse!.totalTeam == null)
                                              ? '-'
                                              : value.getTotalTeamsCountResponse!.totalTeam.toString(),
                                        ),
                                        const SizedBox(height: 10),
                                        customContainer(
                                            firstTitle: 'Active Participants',
                                            firstValue: '-',
                                            secondTitle: 'No of Events',
                                            secondValue: '-'),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Teams (${value.teamListResponse?.team?.length})',
                                                style: textTheme().titleMedium?.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.lightPrimary)),
                                            InkWell(
                                              onTap: () {
                                                AppRouter.navigateTo(AppRoutes.createTeamRoute);
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.add, color: AppColors.lightBlueColor),
                                                  const SizedBox(width: 5),
                                                  Text('addTeam'.tr(),
                                                      style: textTheme().titleMedium?.copyWith(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.lightBlueColor)),
                                                  const SizedBox(width: 8)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        value.teamListResponse == null
                                            ? const SizedBox.shrink()
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: value.teamListResponse?.team?.length,
                                                itemBuilder: (context, index) {
                                                  final data = value.teamListResponse?.team![index];
                                                  return InkWell(
                                                    onTap: () => AppRouter.navigateTo(
                                                        AppRoutes.teamDetailRoute,
                                                        arguments: {
                                                          'team': value.teamListResponse?.team!,
                                                          'index': index
                                                        }),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            padding: const EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                                border:
                                                                    Border.all(color: AppColors.grey2Color),
                                                                borderRadius: BorderRadius.circular(5)),
                                                            child: Column(children: [
                                                              Row(
                                                                children: [
                                                                  FloatingActionButton(
                                                                    heroTag: index,
                                                                    elevation: 1,
                                                                    backgroundColor: Colors.white,
                                                                    onPressed: null,
                                                                    child: (data!.logoPath!.contains('.png'))
                                                                        ? const Icon(
                                                                            Icons
                                                                                .supervised_user_circle_outlined,
                                                                            color: Colors.black12,
                                                                            size: 40)
                                                                        : Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child: Image.memory(
                                                                                const Base64Codec().decode(
                                                                                    data.logoPath ?? ''))),
                                                                  ),
                                                                  const SizedBox(width: 10),
                                                                  Expanded(
                                                                      child: Text(data.teamName ?? '',
                                                                          style: textTheme()
                                                                              .titleMedium
                                                                              ?.copyWith(
                                                                                  fontSize: 15,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  color: AppColors
                                                                                      .gmailButtonColor))),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text('-',
                                                                          style: textTheme()
                                                                              .titleMedium
                                                                              ?.copyWith(
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w700,
                                                                                  color:
                                                                                      AppColors.noTeamColor)),
                                                                      Text('points'.tr(),
                                                                          style: textTheme()
                                                                              .titleMedium
                                                                              ?.copyWith(
                                                                                  fontSize: 11,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  color: AppColors
                                                                                      .drawerButtonColor))
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              const Divider(
                                                                  color: AppColors.grey2Color,
                                                                  thickness: 1.5),
                                                              Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 7,
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                keyValueWidget(
                                                                                    key: 'Captain',
                                                                                    value:
                                                                                        data.captainId ?? ''),
                                                                                keyValueWidget(
                                                                                    key: 'Vice Captain',
                                                                                    value:
                                                                                        data.viceCaptainId ??
                                                                                            '')
                                                                              ]),
                                                                          const SizedBox(height: 15),
                                                                          Row(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                keyValueWidget(
                                                                                    key: 'Sponsor',
                                                                                    value:
                                                                                        data.sponsorId ?? ''),
                                                                                keyValueWidget(
                                                                                    key: 'Members',
                                                                                    value:
                                                                                        (data.members ?? '')
                                                                                            .toString(),
                                                                                    valueColor: AppColors
                                                                                        .lightBlueColor)
                                                                              ])
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Column(children: [
                                                                      Assets.images.winnerTrophyPng.image(),
                                                                      Text('winner'.tr(),
                                                                          style: textTheme()
                                                                              .titleMedium
                                                                              ?.copyWith(
                                                                                  fontSize: 10,
                                                                                  fontWeight: FontWeight.w700,
                                                                                  color: AppColors
                                                                                      .gmailButtonColor))
                                                                    ])
                                                                  ])
                                                            ])),
                                                        const SizedBox(height: 5),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(bottom: 20, left: 10),
                                                          child: Row(
                                                            children: [
                                                              Text('teamAvgWinningRate'.tr(),
                                                                  style: textTheme().titleMedium?.copyWith(
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: AppColors.gmailButtonColor)),
                                                              Text('73%',
                                                                  style: textTheme().titleMedium?.copyWith(
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: AppColors.gmailButtonColor))
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                })
                                      ],
                                    ),
                                  ),
                                ),
                                const RecentOnBoardingScreen()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

              // NoTeamCreated(
              //     onPressedCreateTeam: () => AppRouter.navigateTo(AppRoutes.createTeamRoute),
              //     onPressedUploadTeam: () {}),
            )
          ],
        ),
      ),
    );
  }

  Widget getImageBase64(String image) {
    var imageBase64 = image;
    const Base64Codec base64 = Base64Codec();
    if (image.contains('.png')) return const SizedBox.shrink();
    var bytes = base64.decode(imageBase64);
    return Image.memory(bytes);
  }

  Widget keyValueWidget({required String key, required String value, Color? valueColor}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(key,
              style: textTheme()
                  .titleMedium
                  ?.copyWith(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.drawerButtonColor)),
          Text(value,
              style: textTheme().titleMedium?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? AppColors.drawerButtonColor))
        ],
      ),
    );
  }

  Widget customContainer(
      {required String firstTitle,
      required String firstValue,
      required String secondTitle,
      required String secondValue}) {
    return Row(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.lightPrimary),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstTitle,
                style: textTheme()
                    .titleMedium
                    ?.copyWith(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.pureWhite),
              ),
              const SizedBox(height: 15),
              Text(
                firstValue,
                style: textTheme()
                    .titleMedium
                    ?.copyWith(fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.pureWhite),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.lightPrimary),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(secondTitle,
                  style: textTheme()
                      .titleMedium
                      ?.copyWith(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.pureWhite)),
              const SizedBox(height: 15),
              Text(secondValue,
                  style: textTheme()
                      .titleMedium
                      ?.copyWith(fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.pureWhite)),
            ],
          ),
        ),
      )
    ]);
  }
}
