library horizontal_week_calendar;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/themes.dart';

enum WeekStartFrom { Sunday, Monday }

class HorizontalWeekCalendar extends StatefulWidget {
  /// week start from [WeekStartFrom.Monday]
  final WeekStartFrom? weekStartFrom;

  ///get DateTime on date select
  final Function(DateTime)? onDateChange;

  ///get the list of DateTime on week change
  final Function(List<DateTime>)? onWeekChange;

  /// Active background color
  ///
  /// Default value [Theme.of(context).primaryColor]
  final Color? activeBackgroundColor;

  /// In-Active background color
  ///
  /// Default value [Theme.of(context).primaryColor.withOpacity(.2)]
  final Color? inactiveBackgroundColor;

  /// Disable background color
  ///
  /// Default value [Colors.grey]
  final Color? disabledBackgroundColor;

  /// Active text color
  ///
  /// Default value [Theme.of(context).primaryColor]
  final Color? activeTextColor;

  /// In-Active text color
  ///
  /// Default value [Theme.of(context).primaryColor.withOpacity(.2)]
  final Color? inactiveTextColor;

  /// Disable text color
  ///
  /// Default value [Colors.grey]
  final Color? disabledTextColor;

  /// Active Navigator color
  ///
  /// Default value [Theme.of(context).primaryColor]
  final Color? activeNavigatorColor;

  /// In-Active Navigator color
  ///
  /// Default value [Colors.grey]
  final Color? inactiveNavigatorColor;

  /// Month Color
  ///
  /// Default value [Theme.of(context).primaryColor.withOpacity(.2)]
  final Color? monthColor;

  const HorizontalWeekCalendar({
    super.key,
    this.onDateChange,
    this.onWeekChange,
    this.activeBackgroundColor,
    this.inactiveBackgroundColor,
    this.disabledBackgroundColor,
    this.activeTextColor = Colors.white,
    this.inactiveTextColor,
    this.disabledTextColor,
    this.activeNavigatorColor,
    this.inactiveNavigatorColor,
    this.monthColor,
    this.weekStartFrom = WeekStartFrom.Monday,
  });

  @override
  State<HorizontalWeekCalendar> createState() => _HorizontalWeekCalendarState();
}

class _HorizontalWeekCalendarState extends State<HorizontalWeekCalendar> {
  CarouselController carouselController = CarouselController();

  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  List<DateTime> currentWeek = [];
  int currentWeekIndex = 0;

  List<List<DateTime>> listOfWeeks = [];

  @override
  void initState() {
    initCalender();
    super.initState();
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  initCalender() {
    // List<DateTime> minus3Days = [];
    // List<DateTime> add3Days = [];
    // for (int index = 0; index < 3; index++) {
    //   DateTime minusDate = today.add(Duration(days: -(index + 1)));
    //   minus3Days.add(minusDate);
    //   DateTime addDate = today.add(Duration(days: (index + 1)));
    //   add3Days.add(addDate);
    // }
    // currentWeek.addAll(minus3Days.reversed.toList());
    // currentWeek.add(today);
    // currentWeek.addAll(add3Days);
    // listOfWeeks.add(currentWeek);

    final date = DateTime.now();

    DateTime startOfCurrentWeek = widget.weekStartFrom == WeekStartFrom.Monday
        ? getDate(date.subtract(Duration(days: date.weekday - 1)))
        : getDate(date.subtract(Duration(days: date.weekday % 7)));

    currentWeek.add(startOfCurrentWeek);
    for (int index = 0; index < 6; index++) {
      DateTime addDate = startOfCurrentWeek.add(Duration(days: (index + 1)));
      currentWeek.add(addDate);
    }

    listOfWeeks.add(currentWeek);

    getMorePreviousWeeks();
  }

  getMorePreviousWeeks() {
    List<DateTime> minus7Days = [];
    DateTime startFrom = listOfWeeks.isEmpty
        ? DateTime.now()
        : listOfWeeks[currentWeekIndex].isEmpty
            ? DateTime.now()
            : listOfWeeks[currentWeekIndex][0];

    for (int index = 0; index < 7; index++) {
      DateTime minusDate = startFrom.add(Duration(days: -(index + 1)));
      minus7Days.add(minusDate);
    }
    listOfWeeks.add(minus7Days.reversed.toList());
    setState(() {});
  }

  onDateSelect(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    widget.onDateChange?.call(selectedDate);
  }

  onBackClick() {
    carouselController.nextPage();
  }

  onNextClick() {
    carouselController.previousPage();
  }

  onWeekChange(index) {
    currentWeekIndex = index;
    currentWeek = listOfWeeks[currentWeekIndex];

    if (currentWeekIndex + 1 == listOfWeeks.length) {
      getMorePreviousWeeks();
    }

    widget.onWeekChange?.call(currentWeek);
    setState(() {});
  }

  // =================

  isNextDisabled() {
    return listOfWeeks[currentWeekIndex].last.isBefore(DateTime.now());
  }

  isCurrentYear() {
    return DateFormat('yyyy').format(currentWeek[0]) == DateFormat('yyyy').format(today);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var withOfScreen = MediaQuery.of(context).size.width;

    double boxHeight = withOfScreen / 7;

    return currentWeek.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         onBackClick();
              //       },
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Icon(
              //             Icons.arrow_back_ios_new,
              //             size: 17,
              //             color: widget.activeNavigatorColor ?? theme.primaryColor,
              //           ),
              //           const SizedBox(
              //             width: 4,
              //           ),
              //           Text(
              //             "Back",
              //             style: theme.textTheme.bodyLarge!.copyWith(
              //               color: widget.activeNavigatorColor ?? theme.primaryColor,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Text(
              //       isCurrentYear()
              //           ? DateFormat('MMMM').format(
              //               currentWeek[0],
              //             )
              //           : DateFormat('MMMM yyyy').format(
              //               currentWeek[0],
              //             ),
              //       style: theme.textTheme.titleMedium!.copyWith(
              //         fontWeight: FontWeight.bold,
              //         color: widget.monthColor ?? theme.primaryColor,
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: isNextDisabled()
              //           ? () {
              //               onNextClick();
              //             }
              //           : null,
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Text(
              //             "Next",
              //             style: theme.textTheme.bodyLarge!.copyWith(
              //               color: isNextDisabled()
              //                   ? theme.primaryColor
              //                   : widget.inactiveNavigatorColor ?? Colors.grey,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 4,
              //           ),
              //           Icon(
              //             Icons.arrow_forward_ios,
              //             size: 17,
              //             color: isNextDisabled()
              //                 ? theme.primaryColor
              //                 : widget.inactiveNavigatorColor ?? Colors.grey,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 12),
              CarouselSlider(
                carouselController: carouselController,
                items: [
                  if (listOfWeeks.isNotEmpty)
                    for (int ind = 0; ind < listOfWeeks.length; ind++)
                      Container(
                       height: boxHeight,
                       width: withOfScreen,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            for (int weekIndex = 0; weekIndex < listOfWeeks[ind].length; weekIndex++)
                              Expanded(
                                child: GestureDetector(
                                  onTap:
                               //   listOfWeeks[ind][weekIndex].isBefore(DateTime.now()) ?
                                      () {
                                          onDateSelect(listOfWeeks[ind][weekIndex]);
                                        },
                                   //   : null,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      color: DateFormat('dd-MM-yyyy').format(listOfWeeks[ind][weekIndex]) ==
                                              DateFormat('dd-MM-yyyy').format(selectedDate)
                                          ? widget.activeBackgroundColor ?? theme.primaryColor
                                          : listOfWeeks[ind][weekIndex].isBefore(DateTime.now())
                                              ? widget.inactiveBackgroundColor ??
                                                  AppColors.pureWhite
                                              : widget.disabledBackgroundColor ?? Colors.grey,
                                      border: Border.all(color: AppColors.grey2Color),
                                      borderRadius: BorderRadius.circular(10),


                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat(
                                            'EEE',
                                          ).format(
                                            listOfWeeks[ind][weekIndex],
                                          ),
                                          textAlign: TextAlign.center,
                                          style: textTheme().bodyLarge!.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: DateFormat('dd-MM-yyyy')
                                                        .format(listOfWeeks[ind][weekIndex]) ==
                                                    DateFormat('dd-MM-yyyy').format(selectedDate)
                                                ? widget.activeTextColor ?? AppColors.noTeamColor
                                                : listOfWeeks[ind][weekIndex].isBefore(DateTime.now())
                                                    ? widget.inactiveTextColor ??  AppColors.noTeamColor
                                                    : widget.disabledTextColor ??  AppColors.noTeamColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        FittedBox(
                                          child: Text(
                                            // "$weekIndex: ${listOfWeeks[ind][weekIndex] == DateTime.now()}",
                                            "${listOfWeeks[ind][weekIndex].day}",
                                            textAlign: TextAlign.center,
                                            style: textTheme().titleLarge!.copyWith(
                                              fontSize: 16,
                                              color: DateFormat('dd-MM-yyyy')
                                                          .format(listOfWeeks[ind][weekIndex]) ==
                                                      DateFormat('dd-MM-yyyy').format(selectedDate)
                                                  ? widget.activeTextColor ?? AppColors.noTeamColor
                                                  : listOfWeeks[ind][weekIndex].isBefore(DateTime.now())
                                                      ? widget.inactiveTextColor ??
                                                  AppColors.noTeamColor
                                                      : widget.disabledTextColor ??  AppColors.noTeamColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                ],
                options: CarouselOptions(
                  scrollPhysics: const ClampingScrollPhysics(),
                  height: 100,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  reverse: true,
                  onPageChanged: (index, reason) {
                    onWeekChange(index);
                  },
                ),
              ),
            ],
          );
  }
}
