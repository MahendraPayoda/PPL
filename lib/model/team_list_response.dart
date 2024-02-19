class TeamListResponse {
  List<Team>? team;
  bool? success;
  String? message;

  TeamListResponse({this.team, this.success, this.message});

  TeamListResponse.fromJson(Map<String, dynamic> json) {
    if (json['team'] != null) {
      team = <Team>[];
      json['team'].forEach((v) {
        team!.add(Team.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class Team {
  String? teamId;
  String? teamName;
  String? captainId;
  String? viceCaptainId;
  String? sponsorId;
  String? logoPath;
  int? members;

  Team(
      {this.teamName,
        this.teamId,
        this.captainId,
        this.viceCaptainId,
        this.sponsorId,
        this.logoPath,
        this.members});

  Team.fromJson(Map<String, dynamic> json) {
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
