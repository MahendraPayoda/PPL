class GetTotalTeamsCountResponse {
  int? totalTeam;

  GetTotalTeamsCountResponse({this.totalTeam});

  GetTotalTeamsCountResponse.fromJson(Map<String, dynamic> json) {
    totalTeam = json['totalTeam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalTeam'] = totalTeam;
    return data;
  }
}
