class GetEmployeeNameResponse {
  int? employeeID;
  String? employeeName;

  GetEmployeeNameResponse({this.employeeID, this.employeeName});

  GetEmployeeNameResponse.fromJson(Map<String, dynamic> json) {
    employeeID = json['employeeID'];
    employeeName = json['employeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeID'] = employeeID;
    data['employeeName'] = employeeName;
    return data;
  }
}
