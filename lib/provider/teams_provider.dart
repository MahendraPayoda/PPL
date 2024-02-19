import 'package:flutter/material.dart';
import 'package:payoda/model/get_all_employee_count_response.dart';
import 'package:payoda/model/get_total_teams_count_response.dart';
import 'package:payoda/model/team_list_response.dart';
import 'package:payoda/service/api_service.dart';
import 'package:payoda/service/api_urls.dart';

class TeamsProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  GetAllEmployeeCountResponse? getAllEmployeeCountResponse;
  GetTotalTeamsCountResponse? getTotalTeamsCountResponse;
  TeamListResponse? teamListResponse;
  bool loading = false;

  getTotalEmployeeCount() async {
    try {
      final response = await _apiService.getData(ApiUrls.getAllEmployeeCount);
      if (response.statusCode == 200) {
        getAllEmployeeCountResponse = GetAllEmployeeCountResponse.fromJson(response.data);
      } else {}
    } catch (error) {
      debugPrint('Error: $error');
    }
    notifyListeners();
  }

  getTotalTeamsCount() async {
    try {
      final response = await _apiService.getData(ApiUrls.getTotalTeamsCount);
      if (response.statusCode == 200) {
        getTotalTeamsCountResponse = GetTotalTeamsCountResponse.fromJson(response.data);
      } else {}
    } catch (error) {
      debugPrint('Error: $error');
    }
    notifyListeners();
  }


  getTeamList() async {
    try {
      final response = await _apiService.getData(ApiUrls.getTeamList);
      if (response.statusCode == 200) {
        teamListResponse = TeamListResponse.fromJson(response.data);
      } else {}
    } catch (error) {
      debugPrint('Error: $error');
    }
    notifyListeners();
  }

  Future<void> apiCalls() async {
    loading = true;
    await getTeamList();
    await getTotalEmployeeCount();
    await getTotalTeamsCount();
    loading = false;
    notifyListeners();
  }
}
