class AllEmployeeAssignedUnassignedResponse {
  List<Team>? team;
  bool? success;
  String? message;

  AllEmployeeAssignedUnassignedResponse(
      {this.team, this.success, this.message});

  AllEmployeeAssignedUnassignedResponse.fromJson(Map<String, dynamic> json) {
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
  int? employeeId;
  String? employeeName;
  String? teamName;

  Team({this.employeeId, this.employeeName, this.teamName});

  Team.fromJson(Map<String, dynamic> json) {
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
