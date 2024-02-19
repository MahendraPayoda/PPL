import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:payoda/model/all_employee_assigned_unassigned_response.dart';
import 'package:payoda/model/individual_team_detail_response.dart';
import 'package:payoda/service/api_service.dart';
import 'package:payoda/service/api_urls.dart';

class AddEditMemberProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  AllEmployeeAssignedUnassignedResponse? getAllEmployeeAssignedUnassigned;
  IndividualTeamDetailResponse? individualTeamDetailResponse;
  TeamModel? selectedOptionForAllEmployee;
  TeamModel? selectedOptionForSpecificTeam;
  List<TeamList> getAllTeamList = [];
  List<TeamList> individualTeamList = [];

  List<TeamList> tempListForAllEmployee = [];
  List<TeamList> filteredListForAllEmployee = [];
  List<TeamList> tempListForSpecificTeam = [];
  List<TeamList> filteredListForSpecificTeam = [];

  bool isListSelectedForAllEmployees = true;
  bool isListSelectedForSpecificTeam = true;

  bool allEmpSelectAll = false;
  bool specificSelectAll = false;

  TextEditingController searchControllerForAllEmployees = TextEditingController();
  TextEditingController searchControllerForSpecificTeam = TextEditingController();
  final CustomPopupMenuController allEmployeePopUpController = CustomPopupMenuController();
  final CustomPopupMenuController specificTeamPopUpController = CustomPopupMenuController();

  bool selectAllForAllEmployees = false;
  bool selectAllForSpecificTeam = false;

  List<TeamModel> teamsForAllEmployees = [];
  List<TeamModel> teamsForSpecificTeam = [];

  getAllAssignedUnAssignedEmployee() async {
    try {
      final response = await _apiService.getData(ApiUrls.allAssignedUnAssignedEmployee);
      if (response.statusCode == 200) {
        getAllEmployeeAssignedUnassigned = AllEmployeeAssignedUnassignedResponse.fromJson(response.data);
        getAllTeamList = (getAllEmployeeAssignedUnassigned?.team ?? [])
            .map((element) => TeamList.fromJson(element.toJson()))
            .toList();
        tempListForAllEmployee = getAllTeamList;
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
    notifyListeners();
  }

  getIndividualTeamDetail(String teamId) async {
    try {
      final response = await _apiService.getData('${ApiUrls.individualTeamDetail}$teamId');
      if (response.statusCode == 200) {
        individualTeamDetailResponse = IndividualTeamDetailResponse.fromJson(response.data);
        individualTeamList = (individualTeamDetailResponse?.team?.team ?? [])
            .map((element) => TeamList.fromJson(element.toJson()))
            .toList();
        tempListForSpecificTeam = individualTeamList;
      } else {}
    } catch (error) {
      debugPrint('Error: $error');
    }
    notifyListeners();
  }

  void updateSelectedAllForAllEmployee() {
    allEmpSelectAll = !allEmpSelectAll;
    for (var item in getAllTeamList) {
      item.itemSelected = allEmpSelectAll;
    }

    selectAllForAllEmployees = getAllTeamList.every((element) => element.itemSelected);
    notifyListeners();
  }

  void updateSelectedAllForAllSpecificTeam() {
    specificSelectAll = !specificSelectAll;
    for (var item in individualTeamList) {
      item.itemSelected = specificSelectAll;
    }

    selectAllForSpecificTeam = individualTeamList.every((element) => element.itemSelected);
    notifyListeners();
  }

  void updateItemSelections(index) {
    getAllTeamList[index].itemSelected = !getAllTeamList[index].itemSelected;
    if (searchControllerForAllEmployees.text.isEmpty) {
      selectAllForAllEmployees = getAllTeamList.every((element) => element.itemSelected);
    }
    notifyListeners();
  }

  void updateItemSelectionsForSpecificTeam(index) {
    individualTeamList[index].itemSelected = !individualTeamList[index].itemSelected;
    if (searchControllerForSpecificTeam.text.isEmpty) {
      selectAllForSpecificTeam = individualTeamList.every((element) => element.itemSelected);
    }
    notifyListeners();
  }

  void updateSelectedSpecificTeam(index) {
    selectedOptionForSpecificTeam = teamsForSpecificTeam[index];
    // teamsForSpecificTeam[index].isSelected = !teamsForSpecificTeam[index].isSelected;
    notifyListeners();
  }

  void updateSelectedAllEmployeeTeam(index) {
    debugPrint('selectedAllEmployeeTeam ${selectedOptionForAllEmployee?.toJson()}');
    //  selectedOptionForAllEmployee = teamsForAllEmployees[index];
    // teamsForAllEmployees[index].isSelected = !teamsForAllEmployees[index].isSelected;
    // notifyListeners();
  }

  void searchFilterForAllEmployees(String value) {
    if (value.isNotEmpty) {
      filteredListForAllEmployee = getAllTeamList
          .where((data) => data.employeeName?.toLowerCase().contains(value.toLowerCase()) ?? false)
          .toList();
      getAllTeamList = filteredListForAllEmployee;
    } else {
      getAllTeamList = tempListForAllEmployee;
    }
    notifyListeners();
  }

  void searchFilterForSpecificTeam(String value) {
    if (value.isNotEmpty) {
      filteredListForSpecificTeam = individualTeamList
          .where((data) => data.employeeName?.toLowerCase().contains(value.toLowerCase()) ?? false)
          .toList();
      individualTeamList = filteredListForSpecificTeam;
    } else {
      individualTeamList = tempListForSpecificTeam;
    }
    notifyListeners();
  }
}

class TeamModel {
  String? teamId;
  String? teamName;
  String? captainId;
  String? viceCaptainId;
  String? sponsorId;
  String? logoPath;
  int? members;
  bool isSelected = false;

  TeamModel(
      {this.teamName,
      this.teamId,
      this.captainId,
      this.viceCaptainId,
      this.sponsorId,
      this.logoPath,
      this.members,
      this.isSelected = false});

  TeamModel.fromJson(Map<String, dynamic> json) {
    teamId = json['teamId'];
    teamName = json['teamName'];
    captainId = json['captainId'];
    viceCaptainId = json['viceCaptainId'];
    sponsorId = json['sponsorId'];
    logoPath = json['logoPath'];
    members = json['members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teamId'] = teamId;
    data['teamName'] = teamName;
    data['captainId'] = captainId;
    data['viceCaptainId'] = viceCaptainId;
    data['sponsorId'] = sponsorId;
    data['logoPath'] = logoPath;
    data['members'] = members;
    return data;
  }
}

class TeamList {
  int? employeeId;
  String? employeeName;
  String? teamName;
  bool itemSelected = false;

  TeamList({this.employeeId, this.employeeName, this.teamName, this.itemSelected = false});

  TeamList.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    employeeName = json['employeeName'];
    teamName = json['teamName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeId'] = employeeId;
    data['employeeName'] = employeeName;
    data['teamName'] = teamName;
    return data;
  }
}
