import 'dart:math';

import 'package:flutter/material.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/model/team_list_response.dart';
import 'package:payoda/provider/team_detail_provider.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/router/routes.dart';
import 'package:provider/provider.dart';

class TeamDetailScreen extends StatefulWidget {
  final List<Team>? team;
  final int index;

  const TeamDetailScreen({super.key, required this.team, required this.index});

  @override
  State<TeamDetailScreen> createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends State<TeamDetailScreen> {
  late TeamDetailProvider teamDetailProvider;

  String getRandomImageUrl() {
    return 'https://picsum.photos/250?image=${Random.secure().nextInt(50)}';
  }

  List<String> items = [
    'User 1',
    'User 2',
    'User 3',
    'User 4',
    'User 5',
    'User 6',
    'User 7',
    'User 8',
    'User 9',
    'User 10',
    'User 11'
  ];

  int initialDisplayCount = 4;

  @override
  void initState() {
    teamDetailProvider = TeamDetailProvider();
    teamDetailProvider.getIndividualTeamDetail(widget.team![widget.index].teamId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> images = List.generate(20, (index) => getRandomImageUrl());
    return ChangeNotifierProvider<TeamDetailProvider>(
      create: (context) => teamDetailProvider,
      child: Consumer<TeamDetailProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: AppColors.pureWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              "Team Members ${value.individualTeamDetailResponse == null || value.individualTeamDetailResponse?.team == null || value.individualTeamDetailResponse?.team?.team == null ? '' : '(${value.individualTeamDetailResponse?.team?.team?.length})'}",
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.lightPrimary, fontSize: 14, fontWeight: FontWeight.w700))),
                      InkWell(
                        onTap: () => AppRouter.navigateTo(AppRoutes.addEditTeamRoute,
                            arguments: {'team': widget.team!, 'index': widget.index}),
                        child: Text('Add/Edit Members',
                            style: textTheme().bodyMedium?.copyWith(
                                color: AppColors.lightBlueColor, fontSize: 13, fontWeight: FontWeight.w600)),
                      ),
                      // Container(
                      //     margin: const EdgeInsets.symmetric(horizontal: 10),
                      //     height: 20,
                      //     width: 2,
                      //     color: AppColors.verticalColor),
                      // Text('/Edit',
                      //     style: textTheme().bodyMedium?.copyWith(
                      //         color: AppColors.lightBlueColor, fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  if (value.individualTeamDetailResponse != null ||
                      value.individualTeamDetailResponse?.team != null ||
                      value.individualTeamDetailResponse?.team?.team != null)
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, crossAxisSpacing: 10.0, mainAxisSpacing: 5.0),
                      itemCount: ((value.individualTeamDetailResponse?.team?.team?.length ?? 0) > 7 &&
                              !value.isExpanded)
                          ? 8
                          : value.individualTeamDetailResponse?.team?.team?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = value.individualTeamDetailResponse!.team!.team![index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: (value.individualTeamDetailResponse!.team!.team!.length > 7 &&
                                      index == 7 &&
                                      !value.isExpanded)
                                  ? () {
                                      value.isExpanded = true;
                                      setState(() {});
                                    }
                                  : null,
                              child: CircleAvatar(
                                backgroundColor: AppColors.gmailButtonColor,
                                backgroundImage: (index != 7) ? null : null,
                                child: (value.individualTeamDetailResponse!.team!.team!.length > 7 &&
                                        index == 7 &&
                                        !value.isExpanded)
                                    ? const Icon(Icons.keyboard_arrow_down, color: AppColors.pureWhite)
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              (value.individualTeamDetailResponse!.team!.team!.length > 7 &&
                                      index == 7 &&
                                      !value.isExpanded)
                                  ? '+ ${value.individualTeamDetailResponse!.team!.team!.length - 7} More'
                                  : item.employeeName ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.noTeamColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        );
                      },
                    )
                  // const SizedBox(height: 20),
                  // Text('teamParticipatingUpcomingEvents'.tr(),
                  //     style: textTheme()
                  //         .bodyMedium
                  //         ?.copyWith(color: AppColors.lightPrimary, fontSize: 14, fontWeight: FontWeight.w700)),
                  // const SizedBox(height: 10),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   padding: const EdgeInsets.all(0),
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: 20,
                  //   itemBuilder: (context, index) => Container(
                  //     margin: const EdgeInsets.only(bottom: 10),
                  //     padding: const EdgeInsets.all(10),
                  //     decoration: BoxDecoration(
                  //         color: AppColors.pureWhite,
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: AppColors.fieldBorderColor)),
                  //     child: Row(
                  //       children: [
                  //         ClipRRect(
                  //             borderRadius: BorderRadius.circular(8.0),
                  //             child: Container(
                  //                 height: 120,
                  //                 width: 80,
                  //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  //                 child: Image.network(
                  //                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3g8rrnPx2B7xozi6ahFnrDT8ZDo6YHggr-g&usqp=CAU',
                  //                     fit: BoxFit.cover))),
                  //         const SizedBox(width: 10),
                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text('Ask Me Anything Session',
                  //                   style: textTheme().bodyMedium?.copyWith(
                  //                       color: AppColors.blackColor, fontSize: 13, fontWeight: FontWeight.w600)),
                  //               const SizedBox(height: 5),
                  //               Row(
                  //                 children: [
                  //                   const Icon(Icons.location_on_outlined, color: AppColors.iconColor),
                  //                   Expanded(
                  //                     child: Text('Meeting Hall, Campus, Coimba...',
                  //                         style: textTheme().bodyMedium?.copyWith(
                  //                             color: AppColors.blackColor,
                  //                             fontSize: 11,
                  //                             fontWeight: FontWeight.w400)),
                  //                   ),
                  //                 ],
                  //               ),
                  //               const SizedBox(height: 5),
                  //               Row(children: [
                  //                 const Icon(Icons.access_time_outlined, color: AppColors.iconColor, size: 20),
                  //                 const SizedBox(width: 5),
                  //                 Expanded(
                  //                     child: Text('Tue 14 Jun, 2022',
                  //                         style: textTheme().bodyMedium?.copyWith(
                  //                             color: AppColors.blackColor,
                  //                             fontSize: 11,
                  //                             fontWeight: FontWeight.w400)))
                  //               ]),
                  //               const SizedBox(height: 5),
                  //               SizedBox(
                  //                   height: 40,
                  //                   width: double.infinity,
                  //                   child: Row(
                  //                     children: [
                  //                       Flexible(
                  //                         child: Stack(children: [
                  //                           for (int i = 0; i < min(3, images.length); i++)
                  //                             Positioned(
                  //                                 left: i * 25,
                  //                                 child: CircleAvatar(
                  //                                     radius: 18,
                  //                                     backgroundColor: AppColors.pureWhite,
                  //                                     child: CircleAvatar(
                  //                                         radius: 16, backgroundImage: NetworkImage(images[i])))),
                  //                           if (images.length > 3)
                  //                             Positioned(
                  //                                 left: 75,
                  //                                 child: CircleAvatar(
                  //                                     radius: 18,
                  //                                     backgroundColor: AppColors.pureWhite,
                  //                                     child: CircleAvatar(
                  //                                         backgroundColor: AppColors.orangeColor,
                  //                                         radius: 16,
                  //                                         child: Text('+${images.length - 3}',
                  //                                             style: textTheme().bodyMedium?.copyWith(
                  //                                                 color: AppColors.pureWhite,
                  //                                                 fontSize: 10,
                  //                                                 fontWeight: FontWeight.w700)))))
                  //                         ]),
                  //                       ),
                  //                       Flexible(
                  //                         child: Padding(
                  //                           padding: const EdgeInsets.only(bottom: 10),
                  //                           child: Text('participants',
                  //                               style: textTheme().bodyMedium?.copyWith(
                  //                                   color: AppColors.iconColor,
                  //                                   fontSize: 12,
                  //                                   fontWeight: FontWeight.w400)),
                  //                         ),
                  //                       )
                  //                     ],
                  //                   )),
                  //
                  //               // Wrap(
                  //               //   spacing: 8.0,
                  //               //   runSpacing: 8.0,
                  //               //   children: images
                  //               //       .take(3)
                  //               //       .map((image) => CircleAvatar(backgroundImage: NetworkImage(image)))
                  //               //       .toList(),
                  //               // ),
                  //               // if (images.length > 3)
                  //               //   Padding(
                  //               //     padding: const EdgeInsets.only(top: 8.0),
                  //               //     child: CircleAvatar(
                  //               //       backgroundColor: Colors.grey, // Customize as needed
                  //               //       child: Text(
                  //               //         '+${images.length - 3}',
                  //               //         style: const TextStyle(color: Colors.white),
                  //               //       ),
                  //               //     ),
                  //               //   ),
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
