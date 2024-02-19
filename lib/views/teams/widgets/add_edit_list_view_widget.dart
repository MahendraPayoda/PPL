import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/add_edit_member_provider.dart';

class AddEditListViewWidget extends StatefulWidget {
  final bool isListSelected;
  final bool selectAll;
  final TextEditingController searchController;
  final void Function()? switchOnTap;
  final void Function(dynamic value)? selectAllOnTap;
  final void Function(dynamic index)? onItemSelect;
  final void Function(dynamic index)? teamSelectOnTap;
  List<TeamList> list;
  final bool fromIndividualTeam;
  final List<TeamModel> teams;
  final CustomPopupMenuController popUpController;
  TeamModel? selectedOption;
  final void Function(String)? onChanged;

  AddEditListViewWidget(
      {super.key,
      required this.isListSelected,
      required this.selectAll,
      required this.searchController,
      this.switchOnTap,
      this.selectAllOnTap,
      this.onItemSelect,
      required this.list,
      required this.fromIndividualTeam,
      required this.teams,
      required this.popUpController,
      this.selectedOption,
      this.teamSelectOnTap,
      this.onChanged});

  @override
  State<AddEditListViewWidget> createState() => _AddEditListViewWidgetState();
}

class _AddEditListViewWidgetState extends State<AddEditListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.pureWhite,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        height: 45,
                        padding: const EdgeInsets.only(right: 10),
                        child: TextFormField(
                            controller: widget.searchController,
                            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            onChanged: widget.onChanged,
                            decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(Assets.icons.searchIcon,
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.drawerButtonColor, BlendMode.srcIn))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(color: AppColors.grey2Color)),
                                filled: true,
                                fillColor: AppColors.cardColor)))),
                SizedBox(
                  height: 40,
                  width: 80,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: widget.switchOnTap,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                              color: !widget.isListSelected ? AppColors.greyColor : AppColors.lightPrimary,
                              border: Border.all(
                                  color:
                                      !widget.isListSelected ? AppColors.grey2Color : AppColors.lightPrimary),
                            ),
                            child: Center(
                                child: Icon(Icons.list,
                                    color: !widget.isListSelected
                                        ? AppColors.drawerButtonColor
                                        : AppColors.pureWhite)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: widget.switchOnTap,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                              color: widget.isListSelected ? AppColors.greyColor : AppColors.lightPrimary,
                              border: Border.all(
                                  color:
                                      widget.isListSelected ? AppColors.grey2Color : AppColors.lightPrimary),
                            ),
                            child: Center(
                                child: Icon(Icons.grid_view,
                                    color: widget.isListSelected
                                        ? AppColors.drawerButtonColor
                                        : AppColors.pureWhite)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(children: [
            InkWell(
              onTap: () {
                widget.selectAllOnTap!(widget.selectAll);
              },
              child: Row(
                children: [
                  Checkbox(
                      activeColor: AppColors.lightPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                      value: widget.selectAll,
                      onChanged: (value) {
                        debugPrint('value $value');
                        widget.selectAllOnTap!(value);
                      }),
                  Text('selectAll'.tr(),
                      style: textTheme().bodyMedium?.copyWith(
                          color: AppColors.drawerButtonColor, fontSize: 12, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const Spacer(),
            if (widget.list.any((element) => element.itemSelected))
              CustomPopupMenu(
                  showArrow: false,
                  menuBuilder: () => StatefulBuilder(builder: (context, setState) {
                        return Container(
                          width: MediaQuery.sizeOf(context).width * 0.68,
                          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
                          decoration: BoxDecoration(
                              color: AppColors.pureWhite,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.3))
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                      onChanged: (value) {
                                        // widget.list = options
                                        //     .where((option) =>
                                        //         option.name.toLowerCase().contains(value.toLowerCase()))
                                        //     .toList();
                                        // setState(() {});
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Search teams',
                                          hintStyle: textTheme().bodyMedium?.copyWith(
                                              color: AppColors.unSelectedColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                          suffixIcon: const Icon(Icons.search),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide:
                                                  const BorderSide(color: AppColors.fieldBorderColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide:
                                                  const BorderSide(color: AppColors.fieldBorderColor)),
                                          disabledBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              borderSide: BorderSide(color: AppColors.fieldBorderColor)),
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              borderSide: BorderSide(color: AppColors.fieldBorderColor))))),
                              ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  itemCount: widget.teams.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          widget.teamSelectOnTap!(index);
                                          widget.selectedOption = widget.teams[index];
                                          setState(() {});
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Row(children: [
                                            widget.selectedOption == widget.teams[index]
                                                ? SvgPicture.asset(Assets.icons.checkRadioIcon,
                                                    width: 24, height: 24)
                                                : SvgPicture.asset(Assets.icons.uncheckRadioIcon,
                                                    width: 24, height: 24),
                                            const SizedBox(width: 15),
                                            Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: AppColors.greyColor)),
                                            const SizedBox(width: 10),
                                            Flexible(
                                                child: Text(widget.teams[index].teamName ?? '',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: textTheme().bodyMedium?.copyWith(
                                                        color: AppColors.gmailButtonColor,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500)))
                                          ]),
                                        ),
                                      )),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                child: CommonElevatedButton(
                                    borderRadius: 5,
                                    backgroundColor: AppColors.buttonColor,
                                    showBorder: false,
                                    text: 'Assign',
                                    onPressed: () {
                                      widget.popUpController.hideMenu();
                                      showCustomDialog(context, 'hi');
                                    }),
                              )
                            ],
                          ),
                        );
                      }),
                  pressType: PressType.singleClick,
                  verticalMargin: 5,
                  controller: widget.popUpController,
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: widget.list.any((element) => element.itemSelected)
                              ? AppColors.buttonColor
                              : AppColors.drawerButtonColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text('assignToTeam'.tr(),
                            style: textTheme().bodyMedium?.copyWith(
                                color: AppColors.pureWhite, fontSize: 12, fontWeight: FontWeight.w400)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_drop_down, color: AppColors.pureWhite)
                      ])))
            else
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: widget.list.any((element) => element.itemSelected)
                          ? AppColors.buttonColor
                          : AppColors.drawerButtonColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text('assignToTeam'.tr(),
                        style: textTheme().bodyMedium?.copyWith(
                            color: AppColors.pureWhite, fontSize: 12, fontWeight: FontWeight.w400)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_drop_down, color: AppColors.pureWhite)
                  ]))
          ]),
          Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) {
                    final data = widget.list[index];
                    return ListTile(
                        onTap: () => widget.onItemSelect!(index),
                        contentPadding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        leading: Checkbox(
                            activeColor: AppColors.lightPrimary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                            value: data.itemSelected,
                            onChanged: (value) => widget.onItemSelect!(index)),
                        dense: true,
                        title: Row(children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5), color: AppColors.greyColor)),
                          const SizedBox(width: 10),
                          Flexible(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(data.employeeName ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.noTeamColor, fontSize: 13, fontWeight: FontWeight.w700)),
                            Text('-',
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.drawerButtonColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))
                          ]))
                        ]),
                        trailing: widget.fromIndividualTeam
                            ? Text('Remove',
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.red2Color, fontSize: 10, fontWeight: FontWeight.w700))
                            : Text(data.teamName ?? '',
                                style: textTheme().bodyMedium?.copyWith(
                                    color: data.teamName == 'Unassigned'
                                        ? AppColors.red2Color
                                        : AppColors.uploadTeamColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700)));
                  }))
        ]));
  }

  void showCustomDialog(BuildContext context, String message) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext cxt) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
            child: Material(
              color: AppColors.pureWhite,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(cxt).pop();
                            },
                            child: SizedBox(
                              height: 40,
                              child: SvgPicture.asset(Assets.icons.backIcon,
                                  width: 25,
                                  colorFilter:
                                      const ColorFilter.mode(AppColors.gmailButtonColor, BlendMode.srcIn)),
                            )),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text('Confirmation',
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.gmailButtonColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Are you sure to add employees ',
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.noTeamColor, fontSize: 13, fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: 'Aen Powell,Ager Munoz ',
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.noTeamColor, fontSize: 13, fontWeight: FontWeight.w600)),
                          TextSpan(
                              text: 'and ',
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.noTeamColor, fontSize: 13, fontWeight: FontWeight.w400)),
                          TextSpan(
                            text: 'Iva Jimenez ',
                            style: textTheme().bodyMedium?.copyWith(
                                color: AppColors.noTeamColor, fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                              text: 'to ',
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.noTeamColor, fontSize: 13, fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: 'Matatopians ',
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.noTeamColor, fontSize: 13, fontWeight: FontWeight.w600)),
                          TextSpan(
                              text: 'team?',
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.noTeamColor, fontSize: 13, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: CommonElevatedButton(
                          width: 150,
                          borderRadius: 5,
                          backgroundColor: AppColors.buttonColor,
                          showBorder: false,
                          text: 'Yes, Confirm',
                          onPressed: () {
                            Navigator.of(cxt).pop();
                          }),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
