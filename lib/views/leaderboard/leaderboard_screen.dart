import 'package:flutter/material.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/common_app_bar.dart';
import 'package:payoda/common/common_drawer.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/views/leaderboard/leaderboard_individual_screen.dart';
import 'package:payoda/views/leaderboard/leaderboard_teams_screen.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  final List<LeaderBoardTeamsModel> teamPosition = [];

  @override
  void initState() {
    super.initState();
    teamPosition.add(LeaderBoardTeamsModel(
        teamName: 'Matatopians',
        isExpand: false,
        color: const Color(0xffDAF6EC),
        teamWinnerIcon: Assets.images.firstTrophy,
        points: '30300',
        teamStatus: 'Winner',
        teamCaptain: 'Gokulkrishnan',
        teamViceCaptain: 'Hemanand K',
        teamSponsor: 'Hariprasad',
        teamPoints: '10000',
        individualPoints: '20300',
        participantsEvents: '18'));
    teamPosition.add(LeaderBoardTeamsModel(
        teamName: 'Payoda Supremes',
        isExpand: false,
        color: const Color(0xffFFECD4),
        teamWinnerIcon: Assets.images.secondTrophy,
        points: '30300',
        teamStatus: 'Runner',
        teamCaptain: 'Gokulkrishnan',
        teamViceCaptain: 'Hemanand K',
        teamSponsor: 'Hariprasad',
        teamPoints: '10000',
        individualPoints: '20300',
        participantsEvents: '18'));

    teamPosition.add(LeaderBoardTeamsModel(
        teamName: 'Payoda Warriors',
        isExpand: false,
        color: const Color(0xffFFDED4),
        teamWinnerIcon: Assets.images.thirdTrophy,
        points: '30300',
        teamStatus: '-',
        teamCaptain: 'Gokulkrishnan',
        teamViceCaptain: 'Hemanand K',
        teamSponsor: 'Hariprasad',
        teamPoints: '10000',
        individualPoints: '20300',
        participantsEvents: '18'));

    teamPosition.add(LeaderBoardTeamsModel(
        teamName: 'Super Payodians',
        isExpand: false,
        color: const Color(0xffFCD9E8),
        teamWinnerIcon: Assets.images.forthTrophy,
        points: '30300',
        teamStatus: '-',
        teamCaptain: 'Gokulkrishnan',
        teamViceCaptain: 'Hemanand K',
        teamSponsor: 'Hariprasad',
        teamPoints: '10000',
        individualPoints: '20300',
        participantsEvents: '18'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      drawer: const CommonDrawer(),
      appBar: CommonAppBar(
          centerTitle: true,
          title: Text('leaderboard'.tr(),
              style: textTheme()
                  .titleMedium
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.gmailButtonColor))),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
                unselectedLabelColor: AppColors.drawerButtonColor,
                labelColor: AppColors.noTeamColor,
                isScrollable: true,
                indicator: const UnderlineTabIndicator(
                    insets: EdgeInsets.symmetric(horizontal: 18),
                    borderSide: BorderSide(color: AppColors.indicatorColor, width: 3.0)),
                unselectedLabelStyle: textTheme()
                    .titleSmall
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.drawerButtonColor),
                labelStyle: textTheme()
                    .titleMedium
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.noTeamColor),
                tabs: [Tab(text: 'teams'.tr()), const Tab(text: 'Individual')]),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  LeaderBoardTeamScreen(teamPosition: teamPosition),
                  LeaderBoardIndividualScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
