class EngagementDataResponse {
  int? countInFirstQuarter;
  int? countInSecondQuarter;
  int? countInThirdQuarter;
  int? countInFourthQuarter;
  bool? success;
  String? message;

  EngagementDataResponse(
      {this.countInFirstQuarter,
        this.countInSecondQuarter,
        this.countInThirdQuarter,
        this.countInFourthQuarter,
        this.success,
        this.message});

  EngagementDataResponse.fromJson(Map<String, dynamic> json) {
    countInFirstQuarter = json['countInFirstQuarter'];
    countInSecondQuarter = json['countInSecondQuarter'];
    countInThirdQuarter = json['countInThirdQuarter'];
    countInFourthQuarter = json['countInFourthQuarter'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countInFirstQuarter'] = countInFirstQuarter;
    data['countInSecondQuarter'] = countInSecondQuarter;
    data['countInThirdQuarter'] = countInThirdQuarter;
    data['countInFourthQuarter'] = countInFourthQuarter;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
