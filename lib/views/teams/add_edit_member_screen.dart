import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/common/themes.dart';
import 'package:payoda/gen/assets.gen.dart';
import 'package:payoda/localization/translations.dart';
import 'package:payoda/model/team_list_response.dart';
import 'package:payoda/provider/add_edit_member_provider.dart';
import 'package:payoda/views/teams/widgets/add_edit_list_view_widget.dart';
import 'package:provider/provider.dart';

class AddEditMemberScreen extends StatefulWidget {
  final List<Team>? team;
  final int index;

  const AddEditMemberScreen({super.key, required this.team, required this.index});

  @override
  State<AddEditMemberScreen> createState() => _AddEditMemberScreenState();
}

class _AddEditMemberScreenState extends State<AddEditMemberScreen> {
  late AddEditMemberProvider addEditMemberProvider;
  bool isLoading = true;

  @override
  void initState() {
    addEditMemberProvider = AddEditMemberProvider();
    addEditMemberProvider.teamsForAllEmployees =
        (widget.team ?? []).map((element) => TeamModel.fromJson(element.toJson())).toList();
    addEditMemberProvider.teamsForSpecificTeam =
        (widget.team ?? []).map((element) => TeamModel.fromJson(element.toJson())).toList();
    apiCalls();
    super.initState();
  }

  apiCalls() async {
    try {
      await addEditMemberProvider.getAllAssignedUnAssignedEmployee();
      await addEditMemberProvider.getIndividualTeamDetail(widget.team![widget.index].teamId!);
      setState(() {
        isLoading = false;
      });
    } on Exception {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddEditMemberProvider>(
        create: (context) => addEditMemberProvider,
        child: Consumer<AddEditMemberProvider>(
            builder: (context, value, child) => Scaffold(
                backgroundColor: AppColors.pureWhite,
                appBar: AppBar(
                    elevation: 0,
                    leadingWidth: 400,
                    leading: Row(children: [
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                              height: 40,
                              padding: const EdgeInsets.only(left: 20),
                              child: SvgPicture.asset(Assets.icons.backIcon,
                                  width: 20,
                                  colorFilter:
                                      const ColorFilter.mode(AppColors.gmailButtonColor, BlendMode.srcIn)))),
                      const SizedBox(width: 10),
                      Text('Add/Edit Members',
                          style: textTheme().bodyMedium?.copyWith(
                              color: AppColors.gmailButtonColor, fontSize: 16, fontWeight: FontWeight.w700))
                    ])),
                body: isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.blue))
                    : DefaultTabController(
                        length: 2,
                        child: Column(children: [
                          TabBar(
                              unselectedLabelColor: AppColors.drawerButtonColor,
                              labelColor: AppColors.noTeamColor,
                              isScrollable: true,
                              indicator: const UnderlineTabIndicator(
                                  insets: EdgeInsets.symmetric(horizontal: 15),
                                  borderSide: BorderSide(color: AppColors.indicatorColor, width: 3.0)),
                              unselectedLabelStyle: textTheme().titleSmall?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.drawerButtonColor),
                              labelStyle: textTheme().titleMedium?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.noTeamColor),
                              tabs: [
                                Tab(
                                    text:
                                        '${'allEmployees'.tr()}${value.getAllTeamList.isNotEmpty ? ' (${value.getAllTeamList.length})' : ''}'),
                                Tab(
                                    text:
                                        '${widget.team![widget.index].teamName}${value.individualTeamList.isNotEmpty ? ' (${value.individualTeamList.length})' : ''}')
                              ]),
                          Expanded(
                              child: TabBarView(physics: const BouncingScrollPhysics(), children: [
                            AddEditListViewWidget(
                                list: value.getAllTeamList,
                                isListSelected: value.isListSelectedForAllEmployees,
                                searchController: value.searchControllerForAllEmployees,
                                selectAll: value.selectAllForAllEmployees,
                                fromIndividualTeam: false,
                                teams: value.teamsForAllEmployees,
                                popUpController: value.allEmployeePopUpController,
                                selectedOption: value.selectedOptionForAllEmployee,
                                onItemSelect: (index) => value.updateItemSelections(index),
                                selectAllOnTap: (index) => value.updateSelectedAllForAllEmployee(),
                                teamSelectOnTap: (index) => value.updateSelectedAllEmployeeTeam(index),
                                onChanged: (searchQuery) => value.searchFilterForAllEmployees(searchQuery),
                                switchOnTap: () {}),
                            AddEditListViewWidget(
                                list: value.individualTeamList,
                                isListSelected: value.isListSelectedForSpecificTeam,
                                searchController: value.searchControllerForSpecificTeam,
                                selectAll: value.selectAllForSpecificTeam,
                                fromIndividualTeam: true,
                                teams: value.teamsForSpecificTeam,
                                popUpController: value.specificTeamPopUpController,
                                selectedOption: value.selectedOptionForSpecificTeam,
                                onItemSelect: (index) => value.updateItemSelectionsForSpecificTeam(index),
                                selectAllOnTap: (index) => value.updateSelectedAllForAllSpecificTeam(),
                                teamSelectOnTap: (index) => value.updateSelectedSpecificTeam(index),
                                onChanged: (searchQuery) => value.searchFilterForSpecificTeam(searchQuery),
                                switchOnTap: () {})
                          ]))
                        ])))));
  }
}
