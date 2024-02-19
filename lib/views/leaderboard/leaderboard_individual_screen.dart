import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';

class LeaderBoardIndividualScreen extends StatefulWidget {
  const LeaderBoardIndividualScreen({super.key});

  @override
  State<LeaderBoardIndividualScreen> createState() => _LeaderBoardIndividualScreenState();
}

class _LeaderBoardIndividualScreenState extends State<LeaderBoardIndividualScreen> {
  bool isListSelected = true;

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
                  Text('321 Employees',
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
                        hintText: 'Search',
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(Assets.icons.searchIcon)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: AppColors.grey2Color)),
                        filled: true,
                        fillColor: AppColors.lightGrey))),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Employee',
                  style: textTheme().bodyMedium?.copyWith(
                      color: AppColors.drawerButtonColor, fontSize: 12, fontWeight: FontWeight.w400)),
              Text('Points',
                  style: textTheme().bodyMedium?.copyWith(
                      color: AppColors.drawerButtonColor, fontSize: 12, fontWeight: FontWeight.w400))
            ]),
            const Padding(padding: EdgeInsets.symmetric(vertical: 7), child: Divider()),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5), color: AppColors.greyColor),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Title $index',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme().bodyMedium?.copyWith(
                                          color: AppColors.noTeamColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700)),
                                  Text('Subtitle $index',
                                      style: textTheme().bodyMedium?.copyWith(
                                          color: AppColors.drawerButtonColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            if (index == 0) SvgPicture.asset(Assets.images.firstTrophy),
                            if (index == 1) SvgPicture.asset(Assets.images.secondTrophy),
                            if (index == 2) SvgPicture.asset(Assets.images.thirdTrophy),
                            const Spacer(),
                            Text((20 * index).toString(),
                                style: textTheme().bodyMedium?.copyWith(
                                    color: AppColors.noTeamColor, fontSize: 13, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
