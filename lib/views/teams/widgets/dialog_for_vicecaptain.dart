import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/create_team_provider.dart';
import 'package:payoda/utills/constant.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class DialogForViceCaptain extends StatefulWidget {
  final CreateTeamProvider value;
  final void Function()? onPressed;

  const DialogForViceCaptain(this.value, {super.key, this.onPressed});

  @override
  State<DialogForViceCaptain> createState() => _DialogForViceCaptainState();
}

class _DialogForViceCaptainState extends State<DialogForViceCaptain> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    updateValue();
    searchController = TextEditingController();
  }

  // void filterOptions(String query) {
  //   setState(() {
  //     filteredOptions =
  //         options.where((option) => option.name.toLowerCase().contains(query.toLowerCase())).toList();
  //   });
  // }

  onLoading() async {
    var newData = await widget.value.getEmployeeDataForViceCaptain();
    if (newData.isNotEmpty) {
      widget.value.employeeNameListForViceCaptain.addAll(newData);
      widget.value.tempEmployeeNameListForViceCaptain.addAll(newData);
      widget.value.pageForViceCaptain++;
      setState(() {});
    }
    widget.value.refreshController.loadComplete();
  }

  updateValue() {
    setState(() {
      widget.value.employeeNameListForViceCaptain.clear();
      widget.value.employeeNameListForViceCaptain.addAll(widget.value.tempEmployeeNameListForViceCaptain);
      if (widget.value.employeeNameListForViceCaptain.isNotEmpty) {
        if (widget.value.selectedCaptainId != 0) {
          widget.value.employeeNameListForViceCaptain
              .removeWhere((employee) => employee.employeeID == widget.value.selectedCaptainId);
        }
        if (widget.value.selectedSponsorId != 0) {
          widget.value.employeeNameListForViceCaptain
              .removeWhere((employee) => employee.employeeID == widget.value.selectedSponsorId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          width: Constants.width,
          height: Constants.height * 0.5,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                const SizedBox(width: 2),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SizedBox(
                        height: 40,
                        child: SvgPicture.asset(Assets.icons.backIcon,
                            width: 25,
                            colorFilter:
                                const ColorFilter.mode(AppColors.gmailButtonColor, BlendMode.srcIn)))),
                const SizedBox(width: 10),
                Text('chooseTeamViceCaptain'.tr(),
                    style: textTheme().bodyMedium?.copyWith(
                        color: AppColors.gmailButtonColor, fontSize: 16, fontWeight: FontWeight.w700))
              ]),
              SizedBox(
                  height: 40,
                  child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          hintText: 'searchByEmployeeName'.tr(),
                          hintStyle: textTheme().bodyMedium?.copyWith(
                              color: AppColors.unSelectedColor, fontSize: 13, fontWeight: FontWeight.w400),
                          suffixIcon: const Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: AppColors.fieldBorderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: AppColors.fieldBorderColor)),
                          disabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: AppColors.fieldBorderColor)),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: AppColors.fieldBorderColor))))),
              const SizedBox(height: 10),
              Expanded(
                child: RawScrollbar(
                  thumbColor: AppColors.lightPrimary,
                  radius: const Radius.circular(10),
                  trackVisibility: true,
                  trackColor: AppColors.trackColor,
                  thickness: 4,
                  thumbVisibility: true,
                  child: SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    header: const WaterDropHeader(),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus? mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = const Text("pull up load");
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = const Text("Load Failed!Click retry!");
                        } else if (mode == LoadStatus.canLoading) {
                          body = const Text("release to load more");
                        } else {
                          body = const Text("No more Data");
                        }
                        return SizedBox(height: 55.0, child: Center(child: body));
                      },
                    ),
                    controller: widget.value.refreshControllerForViceCaptain,
                    onRefresh: widget.value.onRefresh,
                    onLoading: onLoading,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        if (widget.value.captainName != null)
                          Opacity(
                            opacity: 0.2,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(children: [
                                  SvgPicture.asset(Assets.icons.uncheckRadioIcon, width: 24, height: 24),
                                  const SizedBox(width: 15),
                                  const CircleAvatar(radius: 18, backgroundColor: Colors.blue),
                                  const SizedBox(width: 10),
                                  Flexible(
                                      child: Text(widget.value.captainName?.employeeName ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme().bodyMedium?.copyWith(
                                              color: AppColors.titleColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500))),
                                  const Spacer(),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 0, right: 5),
                                      child: Text('Captain',
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme().bodyMedium?.copyWith(
                                              color: AppColors.titleColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)))
                                ])),
                          ),
                        if (widget.value.sponsorName != null)
                          Opacity(
                            opacity: 0.2,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(children: [
                                  SvgPicture.asset(Assets.icons.uncheckRadioIcon, width: 24, height: 24),
                                  const SizedBox(width: 15),
                                  const CircleAvatar(radius: 18, backgroundColor: Colors.blue),
                                  const SizedBox(width: 10),
                                  Flexible(
                                      child: Text(widget.value.sponsorName?.employeeName ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme().bodyMedium?.copyWith(
                                              color: AppColors.titleColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500))),
                                  const Spacer(),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 0, right: 5),
                                      child: Text('Sponsor',
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme().bodyMedium?.copyWith(
                                              color: AppColors.titleColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)))
                                ])),
                          ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: widget.value.employeeNameListForViceCaptain.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                widget.value.selectedViceCaptainId =
                                    widget.value.employeeNameListForViceCaptain[index].employeeID!;
                                widget.value.viceCaptainName =
                                    widget.value.employeeNameListForViceCaptain[index];
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(children: [
                                  SvgPicture.asset(
                                      widget.value.selectedViceCaptainId ==
                                              widget.value.employeeNameListForViceCaptain[index].employeeID!
                                          ? Assets.icons.checkRadioIcon
                                          : Assets.icons.uncheckRadioIcon,
                                      width: 24,
                                      height: 24),
                                  const SizedBox(width: 15),
                                  const CircleAvatar(radius: 18, backgroundColor: Colors.blue),
                                  const SizedBox(width: 10),
                                  Flexible(
                                      child: Text(
                                          widget.value.employeeNameListForViceCaptain[index].employeeName ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme().bodyMedium?.copyWith(
                                              color: AppColors.titleColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)))
                                ]),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CommonElevatedButton(
                  width: Constants.width / 2.9,
                  text: 'done'.tr(),
                  borderRadius: 5,
                  onPressed: widget.onPressed,
                  showBorder: false,
                  backgroundColor: AppColors.buttonColor)
            ],
          ),
        );
      }),
    );
  }
}
