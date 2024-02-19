import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/themes.dart';

class LeaderBoardTeamScreen extends StatefulWidget {
  final List<LeaderBoardTeamsModel> teamPosition;

  const LeaderBoardTeamScreen({super.key, required this.teamPosition});

  @override
  State<LeaderBoardTeamScreen> createState() => _LeaderBoardTeamScreenState();
}

class _LeaderBoardTeamScreenState extends State<LeaderBoardTeamScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      physics: const BouncingScrollPhysics(),
      itemCount: widget.teamPosition.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(10), color: widget.teamPosition[index].color),
          child: MyExpansionTile(
            item: widget.teamPosition[index],
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Captain',
                            style: textTheme().titleMedium?.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.drawerButtonColor)),
                        Text(widget.teamPosition[index].teamCaptain,
                            style: textTheme().titleMedium?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.gmailButtonColor)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Vice captain',
                            style: textTheme().titleMedium?.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.drawerButtonColor)),
                        Text(widget.teamPosition[index].teamViceCaptain,
                            style: textTheme().titleMedium?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.gmailButtonColor)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sponsor',
                            style: textTheme().titleMedium?.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.drawerButtonColor)),
                        Text(widget.teamPosition[index].teamSponsor,
                            style: textTheme().titleMedium?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.gmailButtonColor)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Points Details',
                    style: textTheme().titleMedium?.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gmailButtonColor)),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  decoration:
                      BoxDecoration(color: AppColors.pureWhite, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Team points',
                                style: textTheme().titleMedium?.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.drawerButtonColor)),
                            Text(widget.teamPosition[index].teamPoints,
                                style: textTheme().titleMedium?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.gmailButtonColor)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Individual points',
                                style: textTheme().titleMedium?.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.drawerButtonColor)),
                            Text(widget.teamPosition[index].individualPoints,
                                style: textTheme().titleMedium?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.gmailButtonColor)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Participated events',
                                style: textTheme().titleMedium?.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.drawerButtonColor)),
                            Text(widget.teamPosition[index].participantsEvents,
                                style: textTheme().titleMedium?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.gmailButtonColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyExpansionTile extends StatefulWidget {
  final Widget content;
  final LeaderBoardTeamsModel item;

  const MyExpansionTile({Key? key, required this.content, required this.item}) : super(key: key);

  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              widget.item.isExpand = !widget.item.isExpand;
            });
          },
          child: Row(
            children: [
              SvgPicture.asset(widget.item.teamWinnerIcon),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Team',
                      style: textTheme().titleMedium?.copyWith(
                          fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.drawerButtonColor)),
                  Text(widget.item.teamName,
                      style: textTheme().titleMedium?.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gmailButtonColor)),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Points',
                      style: textTheme().titleMedium?.copyWith(
                          fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.drawerButtonColor)),
                  Text(widget.item.points,
                      style: textTheme().titleMedium?.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gmailButtonColor)),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status',
                      style: textTheme().titleMedium?.copyWith(
                          fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.drawerButtonColor)),
                  Text(widget.item.teamStatus,
                      style: textTheme().titleMedium?.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gmailButtonColor)),
                ],
              ),
            ],
          ),
        ),
        if (widget.item.isExpand)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Divider(color: Color(0xffB6D5CA), thickness: 1.5),
          ),
        if (widget.item.isExpand) widget.content
      ],
    );
  }
}

class LeaderBoardTeamsModel {
  final String teamName;
  final String teamWinnerIcon;
  final String points;
  final String teamStatus;
  final String teamCaptain;
  final String teamViceCaptain;
  final String teamSponsor;
  final String teamPoints;
  final String individualPoints;
  final String participantsEvents;
  final Color color;
  bool isExpand;

  LeaderBoardTeamsModel(
      {required this.teamName,
      this.isExpand = false,
      required this.color,
      required this.teamWinnerIcon,
      required this.points,
      required this.teamStatus,
      required this.teamCaptain,
      required this.teamViceCaptain,
      required this.teamSponsor,
      required this.teamPoints,
      required this.individualPoints,
      required this.participantsEvents});
}
