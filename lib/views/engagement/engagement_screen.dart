import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_app_bar.dart';
import 'package:payoda/common/common_drawer.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/horizontal_calander/horizontal_week_calendar.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/router/routes.dart';

class EngagementScreen extends StatefulWidget {
  const EngagementScreen({super.key});

  @override
  State<EngagementScreen> createState() => _EngagementScreenState();
}

class _EngagementScreenState extends State<EngagementScreen> {
  var selectedDate = DateTime.now();
  DateTime now = DateTime.now();
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      drawer: const CommonDrawer(),
      appBar: CommonAppBar(
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () => AppRouter.navigateTo(AppRoutes.createTeamRoute),
              child: Row(
                children: [
                  const Icon(Icons.add_circle_outline, color: AppColors.buttonColor),
                  const SizedBox(width: 5),
                  Text('upload'.tr(),
                      style: textTheme().titleMedium?.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.buttonColor)),
                  const SizedBox(width: 8)
                ],
              ),
            )
          ],
          title: Text('Engagement',
              style: textTheme()
                  .titleMedium
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.gmailButtonColor))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Expanded(
              //         child: Container(
              //             padding: const EdgeInsets.all(15),
              //             decoration: BoxDecoration(
              //                 color: AppColors.lightPrimary, borderRadius: BorderRadius.circular(8)),
              //             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //               Text(
              //                 'Events this\nquarter',
              //                 style: textTheme().titleMedium?.copyWith(
              //                     fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.pureWhite),
              //               ),
              //               const SizedBox(height: 8),
              //               Text('12',
              //                   style: textTheme().titleMedium?.copyWith(
              //                       fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.pureWhite))
              //             ]))),
              //     const SizedBox(width: 8),
              //     Expanded(
              //         child: Container(
              //             padding: const EdgeInsets.all(15),
              //             decoration: BoxDecoration(
              //                 color: AppColors.lightPrimary, borderRadius: BorderRadius.circular(8)),
              //             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //               Text('Teams\n',
              //                   style: textTheme().titleMedium?.copyWith(
              //                       fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.pureWhite)),
              //               const SizedBox(height: 8),
              //               Text('4',
              //                   style: textTheme().titleMedium?.copyWith(
              //                       fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.pureWhite))
              //             ]))),
              //     const SizedBox(width: 8),
              //     Expanded(
              //         child: Container(
              //             padding: const EdgeInsets.all(15),
              //             decoration: BoxDecoration(
              //                 color: AppColors.lightPrimary, borderRadius: BorderRadius.circular(8)),
              //             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //               Text('Avg.\nParticipants',
              //                   style: textTheme().titleMedium?.copyWith(
              //                       fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.pureWhite)),
              //               const SizedBox(height: 8),
              //               Text('279',
              //                   style: textTheme().titleMedium?.copyWith(
              //                       fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.pureWhite))
              //             ])))
              //   ],
              // ),
              // const SizedBox(height: 20),
              // Text('Today',
              //     style: textTheme()
              //         .titleMedium
              //         ?.copyWith(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.noTeamColor)),
              // Text(DateFormat('EEEE, dd MMM yyyy').format(DateTime.now()),
              //     style: textTheme()
              //         .titleMedium
              //         ?.copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.noTeamColor)),
              // const SizedBox(height: 10),
              // SizedBox(
              //   height: 100,
              //   width: MediaQuery.of(context).size.width,
              //   child: HorizontalWeekCalendar(
              //     weekStartFrom: WeekStartFrom.Monday,
              //     activeBackgroundColor: Colors.white,
              //     activeTextColor: AppColors.noTeamColor,
              //     inactiveBackgroundColor: AppColors.grey2Color,
              //     inactiveTextColor: AppColors.noTeamColor.withOpacity(0.6),
              //     disabledTextColor: Colors.grey,
              //     disabledBackgroundColor: Colors.grey.withOpacity(.3),
              //     activeNavigatorColor: Colors.purple,
              //     inactiveNavigatorColor: Colors.grey,
              //     monthColor: Colors.purple,
              //     onDateChange: (date) {
              //       debugPrint('onDateChange ----> $date');
              //       setState(() {
              //         selectedDate = date;
              //       });
              //     },
              //     onWeekChange: (dynamic onWeekChange) {
              //       debugPrint('onWeekChange ----> $onWeekChange');
              //     },
              //   ),
              // ),
              // const SizedBox(height: 25),

              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.teal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(20, (index) {
                        int hour = (index ~/ 2 + 9) % 12;
                        int minute = (index % 2) * 30;
                        if (hour == 0) {
                          hour = 12;
                        }
                        String formattedHour = hour.toString().padLeft(2, '0');
                        String formattedMinute = minute.toString().padLeft(2, '0');
                        String time = '$formattedHour:$formattedMinute';
                        return Text(time,
                            style:
                                textTheme().bodyMedium!.copyWith(fontSize: 12, fontWeight: FontWeight.w400));
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        height: (12 * 9),
                        margin: const EdgeInsets.only(top: 12*9),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(color: AppColors.grey2Color),
                            color: AppColors.pureWhite),
                        child: Row(children: [
                          Container(height: double.infinity, width: 2, color: AppColors.lightPrimary),
                          Expanded(
                            child: Column(
                              children: [
                                Row(children: [
                                  Text('Wellness Program',
                                      style: textTheme().bodyMedium!.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.titleColor)),
                                  const Spacer(),
                                  Container(
                                      height: 25,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffEB5757),
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Center(
                                          child: Text('Closed',
                                              style: textTheme().bodyMedium!.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.pureWhite)))),
                                  const SizedBox(width: 25)
                                ]),
                                Row(children: [
                                  const Icon(Icons.access_time_outlined, color: AppColors.iconColor),
                                  Text('Tue 14 Jun, 2022',
                                      style: textTheme()
                                          .bodyMedium!
                                          .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                                  Container(height: 14, width: 1, color: AppColors.iconColor)
                                ]),
                                Text('10:00',
                                    style: textTheme()
                                        .bodyMedium!
                                        .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ])),
                  )
                ],
              )

              // Row(
              //   children: [
              //     Column(
              //       children: List.generate(20, (index) {
              //         int hour = (index ~/ 2 + 9) % 12;
              //         int minute = (index % 2) * 30;
              //         if (hour == 0) {
              //           hour = 12;
              //         }
              //         String formattedHour = hour.toString().padLeft(2, '0');
              //         String formattedMinute = minute.toString().padLeft(2, '0');
              //         String time = '$formattedHour:$formattedMinute';
              //         return Padding(
              //           padding: const EdgeInsets.only(bottom: 16),
              //           child: Text(
              //             time,
              //             style: textTheme().bodyMedium!.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              //           ),
              //         );
              //       }),
              //     ),
              //     EventDetailsWidget()
              //   ],
              // )

              // SizedBox(
              //   height: 400,
              //   child: ListView.separated(
              //       itemCount: 2,
              //       itemBuilder: (context, index) => IntrinsicHeight(
              //             child: Row(
              //               children: [
              //                 Column(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text('9:00',
              //                         style: textTheme()
              //                             .bodyMedium!
              //                             .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
              //                     Text('9:30',
              //                         style: textTheme()
              //                             .bodyMedium!
              //                             .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
              //                     Text('10:00',
              //                         style: textTheme()
              //                             .bodyMedium!
              //                             .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
              //                   ],
              //                 ),
              //                 const SizedBox(width: 10),
              //                 Expanded(
              //                   child: Container(
              //                     margin: EdgeInsets.all(100),
              //                     padding: const EdgeInsets.symmetric(vertical: 30),
              //                     decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(10),
              //                         border: Border.all(color: AppColors.grey2Color),
              //                         color: AppColors.pureWhite),
              //                     child: Row(
              //                       children: [
              //                         Container(
              //                             height: double.infinity, width: 2, color: AppColors.lightPrimary),
              //                         Expanded(
              //                           child: Column(
              //                             children: [
              //                               Row(children: [
              //                                 Text('Wellness Program',
              //                                     style: textTheme().bodyMedium!.copyWith(
              //                                         fontSize: 15,
              //                                         fontWeight: FontWeight.w700,
              //                                         color: AppColors.titleColor)),
              //                                 const Spacer(),
              //                                 Container(
              //                                     height: 25,
              //                                     width: 60,
              //                                     decoration: BoxDecoration(
              //                                         color: const Color(0xffEB5757),
              //                                         borderRadius: BorderRadius.circular(5)),
              //                                     child: Center(
              //                                         child: Text('Closed',
              //                                             style: textTheme().bodyMedium!.copyWith(
              //                                                 fontSize: 12,
              //                                                 fontWeight: FontWeight.w400,
              //                                                 color: AppColors.pureWhite)))),
              //                                 const SizedBox(width: 25)
              //                               ]),
              //                               Row(children: [
              //                                 const Icon(Icons.access_time_outlined,
              //                                     color: AppColors.iconColor),
              //                                 Text('Tue 14 Jun, 2022',
              //                                     style: textTheme()
              //                                         .bodyMedium!
              //                                         .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
              //                                 Container(height: 14, width: 1, color: AppColors.iconColor)
              //                               ]),
              //                               Text('10:00',
              //                                   style: textTheme()
              //                                       .bodyMedium!
              //                                       .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ), separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 10); },),
              // )
            ],
          ),
        ),
      ),
    );
  }

  double calculateContainerTopOffset(DateTime startTime) {
    // Calculate the offset from the top based on the start time
    double offsetInMinutes = startTime.difference(DateTime(2024, 1, 4, 9, 0)).inMinutes.toDouble();
    double offset = (offsetInMinutes / 30) * 16; // Adjust the scale as needed
    return offset;
  }

  double calculateContainerHeight(DateTime startTime, DateTime endTime) {
    // Calculate the difference in minutes between start and end times
    int differenceInMinutes = endTime.difference(startTime).inMinutes;

    // Calculate the height based on the scale you desire
    double containerHeight = (differenceInMinutes / 30) * 16; // Adjust the scale as needed

    return containerHeight;
  }
}

class EventDetailsWidget extends StatelessWidget {
  final DateTime startTime = DateTime(2024, 1, 4, 9, 30); // Replace this with your actual start time
  final DateTime endTime = DateTime(2024, 1, 4, 11, 0); // Replace this with your actual end time

  @override
  Widget build(BuildContext context) {
    // Calculate the offset from the top based on the start time
    double containerTopOffset = calculateContainerTopOffset(startTime);

    // Calculate the height based on the difference between start and end times
    double containerHeight = calculateContainerHeight(startTime, endTime);

    return Positioned(
      top: containerTopOffset,
      height: containerHeight,
      width: double.infinity,
      child: Container(
        color: Colors.blue, // Adjust the styling as needed
        child: const Center(
          child: Text(
            'Event Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  double calculateContainerTopOffset(DateTime startTime) {
    // Calculate the offset from the top based on the start time
    double offsetInMinutes = startTime.difference(DateTime(2024, 1, 4, 9, 0)).inMinutes.toDouble();
    double offset = (offsetInMinutes / 30) * 16; // Adjust the scale as needed
    return offset;
  }

  double calculateContainerHeight(DateTime startTime, DateTime endTime) {
    // Calculate the difference in minutes between start and end times
    int differenceInMinutes = endTime.difference(startTime).inMinutes;

    // Calculate the height based on the scale you desire
    double containerHeight = (differenceInMinutes / 30) * 16; // Adjust the scale as needed

    return containerHeight;
  }
}
