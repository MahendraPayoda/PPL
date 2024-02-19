import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_elevated_button.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';

class RecentOnBoardingScreen extends StatefulWidget {
  const RecentOnBoardingScreen({super.key});

  @override
  State<RecentOnBoardingScreen> createState() => _RecentOnBoardingScreenState();
}

class _RecentOnBoardingScreenState extends State<RecentOnBoardingScreen> {
  bool isListSelected = true;
  bool selectAll = false;
  List<bool> itemSelected = List.generate(10, (index) => false);
  final CustomPopupMenuController _controller = CustomPopupMenuController();

  TeamModel? selectedOption;
  final teamSearchController = TextEditingController();
  List<TeamModel> filteredOptions = [];

  void filterOptions(String query) {
    setState(() {
      filteredOptions =
          options.where((option) => option.name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  final List<TeamModel> options = [
    TeamModel(name: 'Matatopians'),
    TeamModel(name: 'Payoda Supremes'),
    TeamModel(name: 'Payoda Warriors'),
    TeamModel(name: 'Super Payodians')
  ];

  @override
  void initState() {
    filteredOptions = options;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('12 Employees',
                      style: textTheme().bodyMedium?.copyWith(
                          color: AppColors.lightPrimary, fontSize: 14, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 35,
                    width: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isListSelected = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                color: !isListSelected ? AppColors.greyColor : AppColors.lightPrimary,
                                border: Border.all(
                                    color: !isListSelected ? AppColors.grey2Color : AppColors.lightPrimary),
                              ),
                              child: Center(
                                  child: Icon(Icons.list,
                                      color: !isListSelected
                                          ? AppColors.drawerButtonColor
                                          : AppColors.pureWhite)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isListSelected = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                                color: isListSelected ? AppColors.greyColor : AppColors.lightPrimary,
                                border: Border.all(
                                    color: isListSelected ? AppColors.grey2Color : AppColors.lightPrimary),
                              ),
                              child: Center(
                                  child: Icon(Icons.grid_view,
                                      color: isListSelected
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
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Search employee by name, role, unit, etc.',
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(12), child: SvgPicture.asset(Assets.icons.searchIcon)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: AppColors.grey2Color)),
                    filled: true,
                    fillColor: AppColors.lightGrey),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectAll = !selectAll;
                      itemSelected = List.generate(10, (index) => selectAll);
                    });
                  },
                  child: Row(
                    children: [
                      Checkbox(
                          activeColor: AppColors.lightPrimary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                          value: selectAll,
                          onChanged: (value) {
                            setState(() {
                              selectAll = value!;
                              itemSelected = List.generate(10, (index) => value);
                            });
                          }),
                      Text('selectAll'.tr(),
                          style: textTheme().bodyMedium?.copyWith(
                              color: AppColors.drawerButtonColor, fontSize: 12, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                const Spacer(),
                if (itemSelected.any((element) => element))
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
                                    controller: teamSearchController,
                                    onChanged: (value) {
                                      filteredOptions = options
                                          .where((option) =>
                                              option.name.toLowerCase().contains(value.toLowerCase()))
                                          .toList();
                                      setState(() {});
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
                            ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                itemCount: filteredOptions.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedOption = filteredOptions[index];
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Row(children: [
                                          selectedOption == filteredOptions[index]
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
                                                color: AppColors.greyColor),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(filteredOptions[index].name,
                                                overflow: TextOverflow.ellipsis,
                                                style: textTheme().bodyMedium?.copyWith(
                                                    color: AppColors.gmailButtonColor,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500)),
                                          )
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
                                    _controller.hideMenu();
                                    showCustomDialog(context, 'hi');
                                  }),
                            )
                          ],
                        ),
                      );
                    }),
                    pressType: PressType.singleClick,
                    verticalMargin: 5,
                    controller: _controller,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: itemSelected.any((element) => element)
                              ? AppColors.buttonColor
                              : AppColors.drawerButtonColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('assignToTeam'.tr(),
                              style: textTheme().bodyMedium?.copyWith(
                                  color: AppColors.pureWhite, fontSize: 12, fontWeight: FontWeight.w400)),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_drop_down, color: AppColors.pureWhite),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: itemSelected.any((element) => element)
                            ? AppColors.buttonColor
                            : AppColors.drawerButtonColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('assignToTeam'.tr(),
                            style: textTheme().bodyMedium?.copyWith(
                                color: AppColors.pureWhite, fontSize: 12, fontWeight: FontWeight.w400)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_drop_down, color: AppColors.pureWhite),
                      ],
                    ),
                  ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        itemSelected[index] = !itemSelected[index];
                        selectAll = itemSelected.every((element) => element);
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Checkbox(
                      activeColor: AppColors.lightPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                      value: itemSelected[index],
                      onChanged: (value) {
                        setState(() {
                          itemSelected[index] = value!;
                          if (!value) {
                            selectAll = false;
                          } else {
                            selectAll = itemSelected.every((element) => element);
                          }
                        });
                      },
                    ),
                    dense: true,
                    title: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), color: AppColors.greyColor),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Title $index',
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.noTeamColor, fontSize: 13, fontWeight: FontWeight.w700)),
                            Text('Subtitle $index',
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.drawerButtonColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
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

class TeamModel {
  String name;
  bool value;

  TeamModel({required this.name, this.value = false});
}
