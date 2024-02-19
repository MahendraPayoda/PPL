class GetAllEmployeeCountResponse {
  int? totalEmployees;

  GetAllEmployeeCountResponse({this.totalEmployees});

  GetAllEmployeeCountResponse.fromJson(Map<String, dynamic> json) {
    totalEmployees = json['totalEmployees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalEmployees'] = totalEmployees;
    return data;
  }
}
