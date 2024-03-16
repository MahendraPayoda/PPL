class EngagementQuaterResponse {
  EngagementsInQuarters? engagementsInQuarters;
  bool? success;
  String? message;

  EngagementQuaterResponse({this.engagementsInQuarters, this.success, this.message});

  EngagementQuaterResponse.fromJson(Map<String, dynamic> json) {
    engagementsInQuarters = json['engagementsInQuarters'] != null
        ? EngagementsInQuarters.fromJson(json['engagementsInQuarters'])
        : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (engagementsInQuarters != null) {
      data['engagementsInQuarters'] = engagementsInQuarters!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class EngagementsInQuarters {
  List<CommonQuater>? firstQuarter;
  List<CommonQuater>? secondQuarter;
  List<CommonQuater>? thirdQuarter;
  List<CommonQuater>? fourthQuarter;

  EngagementsInQuarters({this.firstQuarter, this.secondQuarter, this.thirdQuarter, this.fourthQuarter});

  EngagementsInQuarters.fromJson(Map<String, dynamic> json) {
    if (json['firstQuarter'] != null) {
      firstQuarter = <CommonQuater>[];
      json['firstQuarter'].forEach((v) {
        firstQuarter!.add(CommonQuater.fromJson(v));
      });
    }
    if (json['secondQuarter'] != null) {
      secondQuarter = <CommonQuater>[];
      json['secondQuarter'].forEach((v) {
        secondQuarter!.add(CommonQuater.fromJson(v));
      });
    }
    if (json['thirdQuarter'] != null) {
      thirdQuarter = <CommonQuater>[];
      json['thirdQuarter'].forEach((v) {
        thirdQuarter!.add(CommonQuater.fromJson(v));
      });
    }
    if (json['fourthQuarter'] != null) {
      fourthQuarter = <CommonQuater>[];
      json['fourthQuarter'].forEach((v) {
        fourthQuarter!.add(CommonQuater.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (firstQuarter != null) {
      data['firstQuarter'] = firstQuarter!.map((v) => v.toJson()).toList();
    }
    if (secondQuarter != null) {
      data['secondQuarter'] = secondQuarter!.map((v) => v.toJson()).toList();
    }
    if (thirdQuarter != null) {
      data['thirdQuarter'] = thirdQuarter!.map((v) => v.toJson()).toList();
    }
    if (fourthQuarter != null) {
      data['fourthQuarter'] = fourthQuarter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonQuater {
  String? eventName;
  String? dateTime;
  String? venue;

  CommonQuater({this.eventName, this.dateTime, this.venue});

  CommonQuater.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    dateTime = json['dateTime'];
    venue = json['venue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventName'] = eventName;
    data['dateTime'] = dateTime;
    data['venue'] = venue;
    return data;
  }
}
