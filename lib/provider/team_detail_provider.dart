import 'package:flutter/material.dart';
import 'package:payoda/model/individual_team_detail_response.dart';
import 'package:payoda/service/api_service.dart';
import 'package:payoda/service/api_urls.dart';

class TeamDetailProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  IndividualTeamDetailResponse? individualTeamDetailResponse;

  bool isExpanded = false;

  getIndividualTeamDetail(String teamId) async {
    try {
      final response = await _apiService.getData('${ApiUrls.individualTeamDetail}$teamId');
      if (response.statusCode == 200) {
        debugPrint('individualTeamDetailResponse ${response.data}');

        individualTeamDetailResponse = IndividualTeamDetailResponse.fromJson(response.data);
      } else {}
    } catch (error) {
      debugPrint('Error: $error');
    }
    notifyListeners();
  }
}
