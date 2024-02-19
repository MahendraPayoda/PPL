class IndividualTeamDetailResponse {
  TeamDetail? team;
  bool? success;
  String? message;

  IndividualTeamDetailResponse({this.team, this.success, this.message});

  IndividualTeamDetailResponse.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? TeamDetail.fromJson(json['team']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class TeamDetail {
  String? captainName;
  int? captainId;
  String? viceCaptainName;
  int? viceCaptainId;
  String? sponsorName;
  int? sponsorId;
  List<Team>? team;

  TeamDetail(
      {this.captainName,
        this.captainId,
        this.viceCaptainName,
        this.viceCaptainId,
        this.sponsorName,
        this.sponsorId,
        this.team});

  TeamDetail.fromJson(Map<String, dynamic> json) {
    captainName = json['captainName'];
    captainId = json['captainId'];
    viceCaptainName = json['viceCaptainName'];
    viceCaptainId = json['viceCaptainId'];
    sponsorName = json['sponsorName'];
    sponsorId = json['sponsorId'];
    if (json['team'] != null) {
      team = <Team>[];
      json['team'].forEach((v) {
        team!.add(Team.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['captainName'] = captainName;
    data['captainId'] = captainId;
    data['viceCaptainName'] = viceCaptainName;
    data['viceCaptainId'] = viceCaptainId;
    data['sponsorName'] = sponsorName;
    data['sponsorId'] = sponsorId;
    if (team != null) {
      data['team'] = team!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Team {
  String? employeeName;
  int? employeeId;

  Team({this.employeeName, this.employeeId});

  Team.fromJson(Map<String, dynamic> json) {
    employeeName = json['employeeName'];
    employeeId = json['employeeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeName'] = employeeName;
    data['employeeId'] = employeeId;
    return data;
  }
}
