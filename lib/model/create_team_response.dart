class CreateTeamResponse {
  String? id;
  String? teamId;
  String? teamName;
  int? captainId;
  int? viceCaptainId;
  int? sponsorId;
  String? logoPath;
  List<TeamMembers>? teamMembers;

  CreateTeamResponse(
      {this.id,
      this.teamId,
      this.teamName,
      this.captainId,
      this.viceCaptainId,
      this.sponsorId,
      this.logoPath,
      this.teamMembers});

  CreateTeamResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['teamId'];
    teamName = json['teamName'];
    captainId = json['captainId'];
    viceCaptainId = json['viceCaptainId'];
    sponsorId = json['sponsorId'];
    logoPath = json['logoPath'];
    if (json['teamMembers'] != null) {
      teamMembers = <TeamMembers>[];
      json['teamMembers'].forEach((v) {
        teamMembers!.add(TeamMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teamId'] = teamId;
    data['teamName'] = teamName;
    data['captainId'] = captainId;
    data['viceCaptainId'] = viceCaptainId;
    data['sponsorId'] = sponsorId;
    data['logoPath'] = logoPath;
    if (teamMembers != null) {
      data['teamMembers'] = teamMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamMembers {
  String? sId;
  int? employeeID;
  String? employeeName;
  String? officialEmail;
  String? teamName;
  String? role;

  TeamMembers({this.sId, this.employeeID, this.employeeName, this.officialEmail, this.teamName, this.role});

  TeamMembers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    employeeID = json['employeeID'];
    employeeName = json['employeeName'];
    officialEmail = json['officialEmail'];
    teamName = json['teamName'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['employeeID'] = employeeID;
    data['employeeName'] = employeeName;
    data['officialEmail'] = officialEmail;
    data['teamName'] = teamName;
    data['role'] = role;
    return data;
  }
}
