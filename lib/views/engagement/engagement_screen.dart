import 'dart:math';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_app_bar.dart';
import 'package:payoda/common/common_drawer.dart';
import 'package:payoda/common/custom_container.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/model/engagement_quater_response.dart';
import 'package:payoda/provider/engagement_provider.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/router/routes.dart';
import 'package:provider/provider.dart';

class EngagementScreen extends StatefulWidget {
  const EngagementScreen({super.key});

  @override
  State<EngagementScreen> createState() => _EngagementScreenState();
}

class _EngagementScreenState extends State<EngagementScreen> with SingleTickerProviderStateMixin {
  late EngagementVm engagementVm;
  late TabController _tabController;

  var selectedDate = DateTime.now();
  DateTime now = DateTime.now();
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  int activeTabIndex = 0;

  @override
  void initState() {
    engagementVm = EngagementVm();
    _tabController = TabController(length: 4, vsync: this);
    engagementVm.getEngagementData();
    engagementVm.getEngagementQuaterData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EngagementVm>(
        create: (_) => engagementVm,
        builder: (context, child) => Consumer<EngagementVm>(
            builder: (context, value, child) => Scaffold(
                backgroundColor: AppColors.pureWhite,
                drawer: const CommonDrawer(),
                appBar: CommonAppBar(
                    centerTitle: true,
                    actions: [
                      InkWell(
                          onTap: () => AppRouter.navigateTo(AppRoutes.createEngagementRoute),
                          child: Row(children: [
                            const Icon(Icons.add_circle_outline, color: AppColors.buttonColor),
                            const SizedBox(width: 5),
                            Text('upload'.tr(),
                                style: textTheme().titleMedium?.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.buttonColor)),
                            const SizedBox(width: 8)
                          ]))
                    ],
                    title: Text('Engagement',
                        style: textTheme().titleMedium?.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.gmailButtonColor))),
                body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      customContainer(
                          firstTitle: 'Events this quarter',
                          firstValue: '45',
                          secondTitle: 'Teams\n',
                          secondValue: '4',
                          thirdTitle: 'Avg.\nParticipants',
                          thirdValue: '276'),
                      Expanded(
                          child: DefaultTabController(
                              length: 4,
                              child: Column(children: <Widget>[
                                const SizedBox(height: 10),
                                ButtonsTabBar(
                                    controller: _tabController,
                                    borderWidth: 1,
                                    height: 40,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                                    unselectedBorderColor:
                                        setColor(light: AppColors.lightPrimary, dark: AppColors.darkPrimary),
                                    backgroundColor:
                                        setColor(light: AppColors.lightPrimary, dark: AppColors.darkPrimary),
                                    unselectedBackgroundColor: Colors.transparent,
                                    unselectedLabelStyle: const TextStyle(color: Colors.black),
                                    labelStyle:
                                        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    tabs: const [
                                      Tab(text: 'Q4'),
                                      Tab(text: "Q3"),
                                      Tab(text: 'Q2'),
                                      Tab(text: 'Q1')
                                    ]),
                                Expanded(
                                    child: (value.engagementQuaterResponse == null)
                                        ? const Center(child: CircularProgressIndicator(color: Colors.blue))
                                        : TabBarView(
                                            physics: const NeverScrollableScrollPhysics(),
                                            controller: _tabController,
                                            children: <Widget>[
                                                quaterItem(value.engagementQuaterResponse
                                                        ?.engagementsInQuarters?.fourthQuarter ??
                                                    []),
                                                quaterItem(value.engagementQuaterResponse
                                                        ?.engagementsInQuarters?.thirdQuarter ??
                                                    []),
                                                quaterItem(value.engagementQuaterResponse
                                                        ?.engagementsInQuarters?.secondQuarter ??
                                                    []),
                                                quaterItem(value.engagementQuaterResponse
                                                        ?.engagementsInQuarters?.firstQuarter ??
                                                    [])
                                              ]))
                              ])))
                    ])))));
  }

  Widget quaterItem(List<CommonQuater> quaterValues) {
    List<String> images = List.generate(20, (index) => getRandomImageUrl());
    if (quaterValues.isEmpty) {
      return const Center(child: Text('No quater data found'));
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: quaterValues.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = quaterValues[index];
              return Container(
                  height: (12 * 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.grey2Color),
                      color: AppColors.pureWhite),
                  child: Row(children: [
                    Container(
                        height: double.infinity,
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            color: AppColors.lightPrimary)),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(children: [
                                    Text(data.eventName ?? '',
                                        style: textTheme().bodyMedium!.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.titleColor)),
                                    const Spacer(),
                                    Container(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffEB5757),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text('Closed',
                                                style: textTheme().bodyMedium!.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.pureWhite))))
                                  ]),
                                  Row(children: [
                                    const Icon(Icons.calendar_today, color: AppColors.iconColor, size: 16),
                                    Text(' Tue 14 Jun, 2022 | ',
                                        style: textTheme().bodyMedium!.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.iconColor)),
                                    const Icon(Icons.access_time_outlined,
                                        color: AppColors.iconColor, size: 16),
                                    Text(' 10:00 | ',
                                        style: textTheme().bodyMedium!.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.iconColor)),
                                    const Icon(Icons.location_on_outlined,
                                        color: AppColors.iconColor, size: 16),
                                    Text(" ${data.venue ?? ''}",
                                        style: textTheme().bodyMedium!.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.iconColor))
                                  ]),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                      height: 40,
                                      child: Row(children: [
                                        Flexible(
                                            child: Stack(children: [
                                          for (int i = 0; i < min(3, images.length); i++)
                                            Positioned(
                                                left: i * 25,
                                                child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor: AppColors.pureWhite,
                                                    child: CircleAvatar(
                                                        radius: 16,
                                                        backgroundImage: NetworkImage(images[i])))),
                                          if (images.length > 3)
                                            Positioned(
                                                left: 75,
                                                child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor: AppColors.pureWhite,
                                                    child: CircleAvatar(
                                                        backgroundColor: AppColors.orangeColor,
                                                        radius: 16,
                                                        child: Text('+${images.length - 3}',
                                                            style: textTheme().bodyMedium?.copyWith(
                                                                color: AppColors.pureWhite,
                                                                fontSize: 10,
                                                                fontWeight: FontWeight.w700)))))
                                        ])),
                                        Flexible(
                                            child: Text(" Participants",
                                                style: textTheme().bodyMedium!.copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.iconColor)))
                                      ]))
                                ])))
                  ]));
            }),
      );
    }
  }

  String getRandomImageUrl() {
    return 'https://picsum.photos/250?image=${Random.secure().nextInt(50)}';
  }
}
