import 'package:flutter/material.dart';
import 'package:payoda/model/engagement_data_response.dart';
import 'package:payoda/model/engagement_quater_response.dart';
import 'package:payoda/service/api_service.dart';
import 'package:payoda/service/api_urls.dart';

class EngagementVm extends ChangeNotifier {
  final _apiService = ApiService();
  EngagementQuaterResponse? engagementQuaterResponse;
  EngagementDataResponse? engagementDataResponse;

  Future<void> getEngagementQuaterData() async {
    try {
      final response = await _apiService.getData(ApiUrls.getEngagementQuaterData);
      if (response.statusCode == 200) {
        engagementQuaterResponse = EngagementQuaterResponse.fromJson(response.data);
      } else {
        engagementQuaterResponse = EngagementQuaterResponse(
            engagementsInQuarters: EngagementsInQuarters(
                firstQuarter: [], secondQuarter: [], thirdQuarter: [], fourthQuarter: []));
      }
    } catch (error) {
      engagementQuaterResponse = EngagementQuaterResponse(
          engagementsInQuarters: EngagementsInQuarters(
              firstQuarter: [], secondQuarter: [], thirdQuarter: [], fourthQuarter: []));
    }
    notifyListeners();
  }

  Future<void> getEngagementData() async {
    try {
      final response = await _apiService.getData(ApiUrls.getEngagementQuaterData);
      if (response.statusCode == 200) {
        engagementDataResponse = EngagementDataResponse.fromJson(response.data);
      } else {
        engagementDataResponse = EngagementDataResponse(
            countInFirstQuarter: 0, countInFourthQuarter: 0, countInSecondQuarter: 0, countInThirdQuarter: 0);
      }
    } catch (error) {
      engagementDataResponse = EngagementDataResponse(
          countInFirstQuarter: 0, countInFourthQuarter: 0, countInSecondQuarter: 0, countInThirdQuarter: 0);
    }
    notifyListeners();
  }
}
