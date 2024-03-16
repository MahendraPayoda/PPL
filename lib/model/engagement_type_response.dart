class EngagementTypeResponse {
  String? id;
  String? engagementTypeId;
  String? name;

  EngagementTypeResponse({this.id, this.engagementTypeId, this.name});

  EngagementTypeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    engagementTypeId = json['engagementTypeId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['engagementTypeId'] = engagementTypeId;
    data['name'] = name;
    return data;
  }
}
