import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/provider/dashboard_provider.dart';
import 'package:payoda/views/engagement/engagement_screen.dart';
import 'package:payoda/views/leaderboard/leaderboard_screen.dart';
import 'package:payoda/views/teams/teams_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardProvider dashboardProvider;

  @override
  void initState() {
    dashboardProvider = DashboardProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardProvider>(
      create: (context) => dashboardProvider,
      child: Consumer<DashboardProvider>(
        builder: (context, value, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.lightPrimary,
              onPressed: () {},
              child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.pureWhite,
                  child: Icon(Icons.add, color: AppColors.lightPrimary))),
          body: const [
            TeamsScreen(),
            LeaderBoardScreen(),
            EngagementScreen(),
            Center(child: Text('Coming soon')),
          ][value.selectedIndex],
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
                labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((Set<MaterialState> states) =>
                    states.contains(MaterialState.selected)
                        ? textTheme().titleMedium!.copyWith(
                            color: AppColors.lightPrimary, fontWeight: FontWeight.w700, fontSize: 13)
                        : textTheme().titleMedium!.copyWith(
                            color: AppColors.unSelectedColor, fontWeight: FontWeight.w400, fontSize: 12))),
            child: NavigationBar(
              selectedIndex: value.selectedIndex,
              elevation: 5,
              backgroundColor: AppColors.pureWhite,
              indicatorColor: Colors.transparent,
              onDestinationSelected: (int index) => value.setBottomIndex(index),
              destinations: <NavigationDestination>[
                NavigationDestination(
                    selectedIcon: SvgPicture.asset(Assets.icons.teamsIcon,
                        colorFilter: const ColorFilter.mode(AppColors.lightPrimary, BlendMode.srcIn)),
                    icon: SvgPicture.asset(Assets.icons.teamsIcon,
                        colorFilter: const ColorFilter.mode(AppColors.unSelectedColor, BlendMode.srcIn)),
                    label: 'teams'.tr()),
                NavigationDestination(
                    selectedIcon: SvgPicture.asset(Assets.icons.leaderboardIcon,
                        colorFilter: const ColorFilter.mode(AppColors.lightPrimary, BlendMode.srcIn)),
                    icon: SvgPicture.asset(Assets.icons.leaderboardIcon,
                        colorFilter: const ColorFilter.mode(AppColors.unSelectedColor, BlendMode.srcIn)),
                    label: 'leaderboard'.tr()),
                NavigationDestination(
                    selectedIcon: SvgPicture.asset(Assets.icons.engagementsIcon,
                        colorFilter: const ColorFilter.mode(AppColors.lightPrimary, BlendMode.srcIn)),
                    icon: SvgPicture.asset(Assets.icons.engagementsIcon,
                        colorFilter: const ColorFilter.mode(AppColors.unSelectedColor, BlendMode.srcIn)),
                    label: 'engagements'.tr()),
                NavigationDestination(
                    selectedIcon: SvgPicture.asset(Assets.icons.connectsIcon,
                        colorFilter: const ColorFilter.mode(AppColors.lightPrimary, BlendMode.srcIn)),
                    icon: SvgPicture.asset(Assets.icons.connectsIcon,
                        colorFilter: const ColorFilter.mode(AppColors.unSelectedColor, BlendMode.srcIn)),
                    label: 'connects'.tr()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
